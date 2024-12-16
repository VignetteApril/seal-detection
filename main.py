import os
import cv2
from PIL import Image
from fastapi import FastAPI, File, UploadFile
from io import BytesIO
import traceback
import numpy as np
from fastapi.responses import JSONResponse

from pkg.ocr import seal_ocr, text_ocr

app = FastAPI()

def read_image_from_bytes(image_bytes: bytes):
    """将上传的图片字节流转换为OpenCV格式的图片"""
    image = Image.open(BytesIO(image_bytes))
    image = cv2.cvtColor(np.array(image), cv2.COLOR_RGB2BGR)
    return image

@app.post("/detect-seal/")
async def detect_seal(file: UploadFile = File(...)):
    """接受图片，检测是否包含印章"""
    try:
        print(f"Received file: {file.filename}, content type: {file.content_type}")
        # 读取图片内容
        image_bytes = await file.read()
        frame = read_image_from_bytes(image_bytes)

        # 进行印章检测
        img_drawed = Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
        resize_img, _ = seal_ocr(frame, img_drawed)

        # 印章文字识别
        texts = text_ocr(resize_img, "ch_PP-OCRv4_xx")

        if resize_img is None:
            return JSONResponse(content={"message": "未检测到印章", "has_seal": False, "seal_text": ""}, status_code=200)
        else:
            return JSONResponse(content={"message": "检测到印章", "has_seal": True, "seal_text": texts}, status_code=200)

    except Exception as e:
        traceback_str = ''.join(traceback.format_tb(e.__traceback__))
        print(f"Error: {str(e)}\nTraceback: {traceback_str}")
        return JSONResponse(content={"error": str(e), "traceback": traceback_str}, status_code=500)