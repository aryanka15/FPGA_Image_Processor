import argparse
from PIL import Image
import numpy as np


def main():
    parser = argparse.ArgumentParser(description="Create BMP from text pixel list")
    parser.add_argument("input_file", nargs="?", default="../output/lena_new.txt",
                        help="Input text file with pixel values (one per line)")
    parser.add_argument("-o", "--output", default="../output/lena_new2.bmp",
                        help="Output BMP file path")
    parser.add_argument("--width", type=int, default=510, help="Image width")
    parser.add_argument("--height", type=int, default=510, help="Image height")
    args = parser.parse_args()

    # Read pixels
    with open(args.input_file, "r") as f:
        pixels = [int(line.strip()) for line in f if line.strip()]

    if len(pixels) != args.width * args.height:
        raise ValueError(f"Expected {args.width*args.height} pixels, got {len(pixels)}")

    # Convert to numpy array
    img_array = np.array(pixels, dtype=np.uint8).reshape((args.height, args.width))

    # Create grayscale image
    img = Image.fromarray(img_array, mode="L")
    img.save(args.output)
    print(f"Saved BMP image to {args.output}")


if __name__ == "__main__":
    main()
