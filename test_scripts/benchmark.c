#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

#define WIDTH 512
#define HEIGHT 512
#define ITERATIONS 50 // Run multiple times to get a stable average

// Saturation macro (Branchless version often faster on some CPUs, but ternary is smart enough in -O3)
#define CLAMP(x) (((x) < 0) ? 0 : ((x) > 255) ? 255 \
                                              : (x))

void convolution_fast(const uint8_t *__restrict in, uint8_t *__restrict out, int width, int height, const int8_t *kernel)
{
    int w = width;

    for (int y = 1; y < height - 1; y++)
    {

        const uint8_t *row_top = &in[(y - 1) * w];
        const uint8_t *row_mid = &in[y * w];
        const uint8_t *row_bot = &in[(y + 1) * w];
        uint8_t *row_out = &out[y * w];

        for (int x = 1; x < width - 1; x++)
        {
            // ERROR WAS HERE: "intsum" should be "int sum"
            int sum = 0;

            // Top Row
            sum += row_top[x - 1] * kernel[0];
            sum += row_top[x] * kernel[1];
            sum += row_top[x + 1] * kernel[2];

            // Middle Row
            sum += row_mid[x - 1] * kernel[3];
            sum += row_mid[x] * kernel[4];
            sum += row_mid[x + 1] * kernel[5];

            // Bottom Row
            sum += row_bot[x - 1] * kernel[6];
            sum += row_bot[x] * kernel[7];
            sum += row_bot[x + 1] * kernel[8];

            // Saturation / Clipping
            row_out[x] = (uint8_t)CLAMP(sum);
        }
    }
}

int main()
{
    // 1. Setup Memory (Using malloc for large arrays to avoid stack overflow)
    size_t img_size = WIDTH * HEIGHT * sizeof(uint8_t);
    uint8_t *input_image = (uint8_t *)malloc(img_size);
    uint8_t *output_image = (uint8_t *)malloc(img_size);

    if (!input_image || !output_image)
    {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Initialize with random noise
    srand(time(NULL));
    for (int i = 0; i < WIDTH * HEIGHT; i++)
    {
        input_image[i] = rand() % 256;
    }

    // Standard Edge Detection Kernel
    // Signed 8-bit integers
    int8_t kernel[9] = {
        -1, -1, -1,
        -1, 8, -1,
        -1, -1, -1};

    printf("Image Size: %dx%d\n", WIDTH, HEIGHT);
    printf("Benchmarking C implementation (%d iterations)...\n", ITERATIONS);

    // 2. Timing
    clock_t start = clock();

    for (int i = 0; i < ITERATIONS; i++)
    {
        // We re-run the convolution multiple times to average out OS noise
        convolution_fast(input_image, output_image, WIDTH, HEIGHT, kernel);
    }

    clock_t end = clock();

    // 3. Results
    double total_time_ms = ((double)(end - start) / CLOCKS_PER_SEC) * 1000.0;
    double avg_time_ms = total_time_ms / ITERATIONS;
    double throughput = (double)(WIDTH * HEIGHT) / (avg_time_ms / 1000.0);

    printf("\n--- C Results ---\n");
    printf("Average Time: %.4f ms\n", avg_time_ms);
    printf("Throughput:   %.2f MP/s (Mega-pixels/sec)\n", throughput / 1e6);

    free(input_image);
    free(output_image);
    return 0;
}