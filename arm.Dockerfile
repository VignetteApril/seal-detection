# 使用 Python 3.10.13 的 Bullseye 版本作为基础镜像
FROM arm64v8/python:3.10.13

# 设置环境变量以防止交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新 apt 包管理器并安装 OpenCV 所需的依赖库
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 将本地的 requirements.txt 复制到容器中
COPY arm.requirements.txt /app/requirements.txt

# 安装 Python 依赖
RUN pip install --no-cache-dir -r /app/requirements.txt

# 将当前目录的所有文件复制到容器的工作目录中
COPY . /app

# 暴露 FastAPI 服务的端口（9999）
EXPOSE 9999

# 启动 FastAPI 服务
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9999"]
