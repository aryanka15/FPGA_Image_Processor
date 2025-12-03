from PIL import Image

img = Image.open("lena.bmp").convert("L")
width, height = img.size

pixels = list(img.getdata())
with open("image.txt", "w") as f:
    for y in range(height):
        line = pixels[y*width:(y+1)*width]
        f.write(" ".join(str(p) for p in line) + "\n")

