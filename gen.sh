#!/bin/bash

# 定义镜像名称和容器名称
IMAGE_NAME="seal-detect"
DOCKER_USERNAME="zhangjieboot"
PORT="9999"
VERSION="v1"

# 构建镜像
echo "开始构建 Docker 镜像..."
docker build -t $IMAGE_NAME:$VERSION -f prod.Dockerfile .

# 检查构建是否成功
if [ $? -ne 0 ]; then
    echo "Docker 镜像构建失败，请检查错误信息！"
    exit 1
fi

# 打 Docker Hub 标签
echo "为 Docker Hub 打标签..."
docker tag $IMAGE_NAME:$VERSION $DOCKER_USERNAME/$IMAGE_NAME:$VERSION

# 推送到 Docker Hub
echo "推送镜像到 Docker Hub..."
docker push $DOCKER_USERNAME/$IMAGE_NAME:$VERSION

# 检查推送是否成功
if [ $? -ne 0 ]; then
    echo "Docker 镜像推送失败，请检查错误信息！"
    exit 1
fi

echo "镜像已成功推送到 Docker Hub: $DOCKER_USERNAME/$IMAGE_NAME:$VERSION"
