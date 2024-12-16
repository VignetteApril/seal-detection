FROM python:3.10.13-bullseye

RUN apt-get update && apt-get install libgl1-mesa-glx -y

COPY requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

WORKDIR /app