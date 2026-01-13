import cv2
import numpy as np
from skimage.metrics import structural_similarity as ssim
from skimage.metrics import peak_signal_noise_ratio as psnr
import os

def evaluate_images(original_path, reconstructed_path):
    if not os.path.exists(original_path):
        print(f"Lỗi: Không tìm thấy file {original_path}")
        return None
    if not os.path.exists(reconstructed_path):
        print(f"Lỗi: Không tìm thấy file {reconstructed_path}")
        return None
    
    original = cv2.imread(original_path)
    reconstructed = cv2.imread(reconstructed_path)
    
    if original is None or reconstructed is None:
        print("Lỗi: Không thể đọc ảnh")
        return None
    
    if original.shape != reconstructed.shape:
        reconstructed = cv2.resize(reconstructed, (original.shape[1], original.shape[0]))
    
    psnr_value = psnr(original, reconstructed, data_range=255)
    ssim_value = ssim(original, reconstructed, channel_axis=-1, data_range=255)
    mae = np.mean(np.abs(original.astype(np.float32) - reconstructed.astype(np.float32)))
    similarity_percent = 100 - (mae / 255.0 * 100)
    
    print("\n" + "="*50)
    print("KẾT QUẢ SO SÁNH")
    print("="*50)
    print(f"PSNR           : {psnr_value:.4f} dB")
    print(f"SSIM           : {ssim_value:.6f}")
    print(f"Độ tương đồng  : {similarity_percent:.4f}%")
    print("="*50 + "\n")
    
    return {
        'psnr': psnr_value,
        'ssim': ssim_value,
        'similarity_percent': similarity_percent
    }

if __name__ == "__main__":
    original_image = "baitap1_anhgoc.jpg"
    reconstructed_image = "Output_using_Verilog.bmp"
    
    evaluate_images(original_image, reconstructed_image)