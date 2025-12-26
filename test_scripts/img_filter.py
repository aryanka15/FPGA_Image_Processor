import cv2
import numpy as np

def apply_horizontal_sobel(image_path, output_path):
    # 1. Load the BMP image
    # cv2.imread loads the image in BGR format
    img = cv2.imread(image_path)

    if img is None:
        print(f"Error: Could not load image at {image_path}")
        return

    # 2. Convert to Grayscale
    # Edge detection is typically performed on grayscale images to reduce complexity
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # 3. Apply Horizontal Sobel Filter (Sobel Y)
    # dx=0, dy=1 calculates the derivative in the Y direction (detects horizontal lines)
    # ksize=3 uses a standard 3x3 kernel
    # cv2.CV_64F keeps negative values (gradients) which are later converted
    sobel_y = cv2.Sobel(gray, cv2.CV_64F, dx=1, dy=0, ksize=3)

    # 4. Convert back to uint8
    # We take the absolute value to handle negative gradients (dark-to-light transitions)
    # and convert to 8-bit unsigned integers (0-255) for display
    abs_sobel_y = np.absolute(sobel_y)
    sobel_uint8 = np.uint8(abs_sobel_y)

    # 5. Save the result
    cv2.imwrite(output_path, sobel_uint8)
    print(f"Success! Horizontal edge map saved to {output_path}")

    # Optional: Display the images (requires GUI environment)
    # cv2.imshow('Original', gray)
    # cv2.imshow('Horizontal Edges', sobel_uint8)
    # cv2.waitKey(0)
    # cv2.destroyAllWindows()

if __name__ == "__main__":
    # Ensure you have a 'input.bmp' in the same folder or update the path
    apply_horizontal_sobel('./clown.bmp', './clown_horizontal_sw.bmp')