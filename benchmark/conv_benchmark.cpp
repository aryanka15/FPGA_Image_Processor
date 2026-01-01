#include <iostream>
#include <vector>
#include <chrono>
#include <fstream>
#include <omp.h> // OpenMP for multithreading

// CONFIGURATION
const char* INPUT_FILENAME = "../test_scripts/clown.bmp";
const char* OUTPUT_FILENAME = "out.bmp";
const int WIDTH = 512;
const int HEIGHT = 512;

// Standard BMP Header Wrapper to keep things simple
#pragma pack(push, 1)
struct BMPHeader {
    uint16_t signature;      // "BM"
    uint32_t fileSize;
    uint16_t reserved1;
    uint16_t reserved2;
    uint32_t dataOffset;     // <--- The most important number
    // Info Header starts here
    uint32_t headerSize;
    int32_t  width;
    int32_t  height;
    uint16_t planes;
    uint16_t bitCount;       // 8 for grayscale, 24 for RGB
    uint32_t compression;
    uint32_t imageSize;
    int32_t  xPixelsPerM;
    int32_t  yPixelsPerM;
    uint32_t colorsUsed;
    uint32_t colorsImportant;
};
#pragma pack(pop)

int main() {
    // 1. Open File
    std::ifstream file(INPUT_FILENAME, std::ios::binary);
    if (!file) { std::cerr << "Error: Could not open " << INPUT_FILENAME << "\n"; return 1; }

    // 2. Read Header
    BMPHeader header;
    file.read(reinterpret_cast<char*>(&header), sizeof(BMPHeader));

    if (header.signature != 0x4D42) { // "BM" in hex
        std::cerr << "Error: Not a valid BMP file.\n"; return 1;
    }
    
    // 3. Handle Variable Header/Palette Size
    // We need to preserve everything between the struct end and the pixel data (the palette)
    int paletteSize = header.dataOffset - sizeof(BMPHeader);
    std::vector<uint8_t> palette(paletteSize);
    file.read(reinterpret_cast<char*>(palette.data()), paletteSize);

    // 4. Read Pixel Data
    // 512x512 = 262,144 bytes
    std::vector<uint8_t> img_in(WIDTH * HEIGHT);
    std::vector<uint8_t> img_out(WIDTH * HEIGHT);
    file.read(reinterpret_cast<char*>(img_in.data()), WIDTH * HEIGHT);
    file.close();

    std::cout << "Processing " << WIDTH << "x" << HEIGHT << " BMP (Offset: " << header.dataOffset << ")...\n";

    // 5. High-Performance Convolution (Sobel X)
    auto start = std::chrono::high_resolution_clock::now();

    // OpenMP splits the rows across all CPU cores
    #pragma omp parallel for schedule(static)
    for (int y = 1; y < HEIGHT - 1; y++) {
        // Direct pointer arithmetic to avoid y*WIDTH recalc
        const uint8_t* row_top = &img_in[(y - 1) * WIDTH];
        const uint8_t* row_mid = &img_in[(y)     * WIDTH];
        const uint8_t* row_bot = &img_in[(y + 1) * WIDTH];
        uint8_t* row_out       = &img_out[y       * WIDTH];

        for (int x = 1; x < WIDTH - 1; x++) {
            // Unrolled Sobel X Kernel
            // -1  0  1
            // -2  0  2
            // -1  0  1
            
            int sum = 0;
            // Left Column (Negative)
            sum -= row_top[x - 1]; 
            sum -= (int)row_mid[x - 1] << 1; // Bit shift for *2 is faster
            sum -= row_bot[x - 1];

            // Right Column (Positive)
            sum += row_top[x + 1];
            sum += (int)row_mid[x + 1] << 1;
            sum += row_bot[x + 1];

            // Absolute value and Clamp (Fast version)
            if (sum < 0) sum = -sum; 
            if (sum > 255) sum = 255;

            row_out[x] = (uint8_t)sum;
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double, std::milli> elapsed = end - start;

    // 6. Write Output
    std::ofstream outfile(OUTPUT_FILENAME, std::ios::binary);
    outfile.write(reinterpret_cast<char*>(&header), sizeof(BMPHeader)); // Write old header
    outfile.write(reinterpret_cast<char*>(palette.data()), paletteSize); // Write old palette
    outfile.write(reinterpret_cast<char*>(img_out.data()), WIDTH * HEIGHT); // Write new pixels
    outfile.close();

    std::cout << "Done! Time: " << elapsed.count() << " ms\n";
    
    return 0;
}