from PIL import Image
import os

input_filename = 'baitap1_nhieu.bmp'
output_filename = 'input_img.txt'

def convert_gray_bitmap():
    try:
        if not os.path.exists(input_filename):
            print(f"Lỗi: Không tìm thấy file '{input_filename}'")
            return

        img = Image.open(input_filename)
        img = img.convert('L')
        
        width, height = img.size
        pixels = list(img.getdata())

        print(f"--- THÔNG TIN ẢNH ---")
        print(f"Kích thước: {width} (Rộng) x {height} (Cao)")
        print(f"Tổng số pixel: {len(pixels)}")
        
        with open(output_filename, 'w') as f:
            for p in pixels:
                f.write(f"{p:02X}\n")

        print(f"---------------------")
        print(f"Đã xuất xong file: {output_filename}")

    except Exception as e:
        print(f"Có lỗi xảy ra: {e}")

if __name__ == '__main__':
    convert_gray_bitmap()