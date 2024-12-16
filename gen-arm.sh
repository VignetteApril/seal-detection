# 定义镜像名称和容器名称
IMAGE_NAME="seal-detect"
DOCKER_USERNAME="zhangjieboot"
PORT="9999"
VERSION="v1"

# 启用 Docker Buildx
export DOCKER_CLI_EXPERIMENTAL=enabled

# 创建并使用 Buildx 构建器（如果已经存在，直接使用）
docker buildx create --use --name mybuilder || docker buildx use mybuilder

# 构建 ARM64 镜像并推送到 Docker Hub
echo "开始构建 ARM64 Docker 镜像..."
docker buildx build --platform linux/arm64 -t $DOCKER_USERNAME/$IMAGE_NAME:$VERSION-arm -f arm.Dockerfile --push .

# 检查构建和推送是否成功
if [ $? -ne 0 ]; then
    echo "ARM64 Docker 镜像构建或推送失败，请检查错误信息！"
    exit 1
fi