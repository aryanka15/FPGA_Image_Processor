import argparse
from PIL import Image

def main():
    parser = argparse.ArgumentParser(description="Convert image to grayscale text matrix")
    parser.add_argument("image_path", nargs="?", default="lena.bmp", help="Path to input image")
    parser.add_argument("-o", "--output", default="image.txt", help="Output text file")
    args = parser.parse_args()

    img = Image.open(args.image_path).convert("L")
    width, height = img.size

    pixels = list(img.getdata())
    with open(args.output, "w") as f:
        for y in range(height):
            line = pixels[y*width:(y+1)*width]
            f.write(" ".join(str(p) for p in line) + "\n")

if __name__ == "__main__":
    main()

