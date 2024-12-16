# 印章检测应用

这是一个基于 FastAPI 的印章检测应用镜像，用户可以上传图片并检测图片中是否有印章。该应用设计简单，易于使用。

## 如何拉取并使用镜像

### 第一步：拉取镜像

您可以使用以下命令从 Docker Hub 拉取该镜像：

```bash
docker pull zhangjieboot/seal-detect:v1
```

### 第二步：运行容器

拉取镜像后，可以使用以下命令运行容器：

```bash
docker run -d -p 9999:9999 zhangjieboot/seal-detect:v1
```

该命令会启动 FastAPI 应用，并将其端口 `9999` 映射到本地机器的 `9999` 端口。应用启动后，您可以通过 `http://localhost:9999` 访问该服务。

### 第三步：测试 API

FastAPI 应用提供了一个用于检测图片中印章的 API 端点，您可以通过 `curl` 或 Postman 等工具测试该 API。

#### `/detect-seal/` 端点

- **方法**: `POST`
- **Content-Type**: `multipart/form-data`
- **参数**: `file`（上传的图片文件）

#### 使用 `curl` 测试示例：

```bash
curl -X POST "http://localhost:9999/detect-seal/" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/path/to/your/image.jpg"
```

### API 响应

- 如果检测到印章，返回如下 JSON：

  ```json
  {
      "message": "检测到印章",
      "has_seal": true
  }
  ```

- 如果未检测到印章，返回如下 JSON：

  ```json
  {
      "message": "未检测到印章",
      "has_seal": false
  }
  ```

## 开发说明

如果您想在本地运行该 FastAPI 应用，而不使用 Docker，您可以按照以下步骤操作：

1. 克隆代码库。
2. 安装所需的 Python 依赖：

   ```bash
   pip install -r requirements.txt
   ```

3. 运行应用：

   ```bash
   uvicorn main:app --host 0.0.0.0 --port 9999 --reload
   ```