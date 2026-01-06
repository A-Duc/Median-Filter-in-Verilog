import cv2
import numpy as np
from skimage.metrics import structural_similarity as ssim
from skimage.metrics import peak_signal_noise_ratio as psnr

def calculate_similarity_percentage(img1, img2):
    """
    Tính độ giống nhau theo phần trăm dựa trên sai số trung bình pixel.
    """
    diff = cv2.absdiff(img1, img2)
    diff = diff.astype(np.float32)
    mean_diff = np.mean(diff)
    similarity = 100 - (mean_diff / 255.0 * 100)
    return similarity

def evaluate_images(original_path, reconstructed_path):
    # Đọc ảnh
    original = cv2.imread(original_path)
    reconstructed = cv2.imread(reconstructed_path)
    
    if original is None:
        print(f"Lỗi: Không thể đọc ảnh gốc từ {original_path}")
        return
    if reconstructed is None:
        print(f"Lỗi: Không thể đọc ảnh tái tạo từ {reconstructed_path}")
        return
    
    # Resize nếu kích thước không khớp
    if original.shape != reconstructed.shape:
        print(f"Cảnh báo: Kích thước không khớp, đang resize ảnh tái tạo...")
        reconstructed = cv2.resize(reconstructed, (original.shape[1], original.shape[0]))
    
    # Tính toán các chỉ số
    psnr_value = psnr(original, reconstructed)
    ssim_value = ssim(original, reconstructed, channel_axis=-1)
    similarity_percent = calculate_similarity_percentage(original, reconstructed)
    
    # In kết quả ngắn gọn
    print("="*50)
    print("KẾT QUẢ SO SÁNH ẢNH")
    print("="*50)
    print(f"Ảnh gốc     : {original_path}")
    print(f"Ảnh tái tạo : {reconstructed_path}")
    print("-" * 50)
    print(f"PSNR            : {psnr_value:.4f} dB")
    print(f"SSIM            : {ssim_value:.4f}")
    print(f"Độ tương đồng   : {similarity_percent:.2f} %")
    print("="*50)
    
    return psnr_value, ssim_value, similarity_percent

if __name__ == "__main__":
    # Cập nhật tên file của bạn tại đây
    original_image = "baitap1_anhgoc.jpg"
    reconstructed_image = "Output_using_Verilog.bmp"
    
    evaluate_images(original_image, reconstructed_image)