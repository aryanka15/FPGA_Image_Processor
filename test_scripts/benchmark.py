import cv2
import numpy as np
import time

def benchmark_hardware_logic():
    # 1. SETUP: 2048x2048 Image (Standard 8-bit grayscale input)
    # Hardware Equivalent: reg [7:0] pixel_in;
    height, width = 512, 512
    image = np.random.randint(0, 255, (height, width)).astype(np.uint8)

    # 2. SETUP: Integer Kernel
    # Hardware Equivalent: signed reg [3:0] weights [0:8];
    kernel = np.array([[-1, -1, -1],
                       [-1,  8, -1],
                       [-1, -1, -1]], dtype=np.int8)

    print(f"Image Size: {width}x{height}")
    print("Warming up...")
    # Warmup runs to fill CPU caches
    _ = cv2.filter2D(image, cv2.CV_16S, kernel)

    print("Starting hardware-accurate integer benchmark...")
    
    # --- START CRITICAL PATH ---
    start_time = time.perf_counter()

    # Step A: Convolution (The MAC Unit)
    # We use ddepth=cv2.CV_16S (Signed 16-bit integer). 
    # This mimics your accumulator growing to prevent overflow before the final result.
    # Hardware Equivalent: reg signed [15:0] acc;
    accumulator = cv2.filter2D(image, cv2.CV_16S, kernel)

    # Step B: Saturation / Clipping (The Controller Logic)
    # Hardware rarely handles negatives by "abs", it usually clamps to 0 (black) or 255 (white).
    # This logic mimics: always_comb y = (acc < 0) ? 8'd0 : (acc > 255) ? 8'd255 : acc[7:0];
    output = np.clip(accumulator, 0, 255).astype(np.uint8)
    
    # --- END CRITICAL PATH ---
    end_time = time.perf_counter()

    elapsed = end_time - start_time
    pixels_per_sec = (width * height) / elapsed

    print(f"\n--- Results ---")
    print(f"Time Taken:   {elapsed*1000:.4f} ms")
    print(f"Throughput:   {pixels_per_sec/1e6:.2f} MP/s")
    print(f"Data verification: Output is type {output.dtype} (Min: {output.min()}, Max: {output.max()})")

if __name__ == "__main__":
    benchmark_hardware_logic()