from PIL import Image
import os

# Cấu hình tên file
txt_filename = 'input_img.txt'          # File text chứa dữ liệu hex
original_img_filename = 'baitap1_nhieu.bmp' # Ảnh gốc (để lấy kích thước)
output_filename = 'reconstructed_output.bmp' # Tên file ảnh đầu ra

def convert_txt_back_to_img():
    try:
        # 1. Kiểm tra file tồn tại
        if not os.path.exists(txt_filename):
            print(f"Lỗi: Không tìm thấy file '{txt_filename}'")
            return
        if not os.path.exists(original_img_filename):
            print(f"Lỗi: Cần file ảnh gốc '{original_img_filename}' để lấy kích thước chuẩn.")
            return

        # 2. Lấy kích thước từ ảnh gốc
        ref_img = Image.open(original_img_filename)
        width, height = ref_img.size
        print(f"Kích thước mục tiêu: {width}x{height}")

        # 3. Đọc dữ liệu từ file TXT
        print("Đang đọc dữ liệu pixel...")
        pixel_values = []
        with open(txt_filename, 'r') as f:
            for line in f:
                line = line.strip()
                if line: # Chỉ xử lý nếu dòng không rỗng
                    # Chuyển đổi từ Hex string (ví dụ "0A") sang số nguyên (10)
                    pixel_values.append(int(line, 16))

        # Kiểm tra tính toàn vẹn dữ liệu
        total_pixels = width * height
        if len(pixel_values) != total_pixels:
            print(f"Cảnh báo: Số lượng pixel trong file txt ({len(pixel_values)}) "
                  f"khác với tổng số pixel của ảnh gốc ({total_pixels}).")
            # Nếu thiếu hoặc thừa, ảnh có thể bị lỗi hoặc trượt hình.
        
        # 4. Tạo ảnh mới và nạp dữ liệu
        # Mode 'L' là cho ảnh xám (Grayscale), tương tự như script convert ban đầu
        new_img = Image.new('L', (width, height))
        new_img.putdata(pixel_values)

        # 5. Lưu ảnh
        new_img.save(output_filename)
        print(f"---------------------")
        print(f"Đã khôi phục ảnh thành công: {output_filename}")

    except Exception as e:
        print(f"Có lỗi xảy ra: {e}")

if __name__ == '__main__':
    convert_txt_back_to_img()