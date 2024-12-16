# Seal Detection Application

This is a seal detection application based on FastAPI. Users can upload images and detect whether there is a seal in the image. The application is simple and easy to use.

## How to Pull and Use the Image

### Step 1: Pull the Image

You can pull the image from Docker Hub using the following command:

```bash
docker pull zhangjieboot/seal-detect:v1
```

### Step 2: Run the Container

After pulling the image, you can run the container using the following command:

```bash
docker run -d -p 9999:9999 zhangjieboot/seal-detect:v1
```

This command will start the FastAPI application and map its `9999` port to the `9999` port on your local machine. Once the application is running, you can access the service via `http://localhost:9999`.

### Step 3: Test the API

The FastAPI application provides an API endpoint for seal detection, which you can test using `curl` or tools like Postman.

#### `/detect-seal/` Endpoint

- **Method**: `POST`
- **Content-Type**: `multipart/form-data`
- **Parameter**: `file` (uploaded image file)

#### Example Test with `curl`:

```bash
curl -X POST "http://localhost:9999/detect-seal/" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/path/to/your/image.jpg"
```

### API Response

- If a seal is detected, the API returns the following JSON:

  ```json
  {
      "message": "Seal detected",
      "has_seal": true
  }
  ```

- If no seal is detected, the API returns the following JSON:

  ```json
  {
      "message": "No seal detected",
      "has_seal": false
  }
  ```

## Development Guide

If you want to run the FastAPI application locally without using Docker, follow the steps below:

1. Clone the repository.
2. Install the required Python dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Run the application:

   ```bash
   uvicorn main:app --host 0.0.0.0 --port 9999 --reload
   ```