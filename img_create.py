from PIL import Image
import numpy as np

# Parameters
width, height = 510, 510
input_file = "lena_new.txt"
output_file = "lena_new.bmp"

# Read pixels
with open(input_file, "r") as f:
    pixels = [int(line.strip()) for line in f]

if len(pixels) != width*height:
    raise ValueError(f"Expected {width*height} pixels, got {len(pixels)}")

# Convert to numpy array
img_array = np.array(pixels, dtype=np.uint8).reshape((height, width))

# Create grayscale image
img = Image.fromarray(img_array, mode='L')
img.save(output_file)
print(f"Saved BMP image to {output_file}")
