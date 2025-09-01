# syntax=docker/dockerfile:1
FROM python:3.11-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# System dependencies (needed for some Python packages, e.g., cryptography)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc libffi-dev libssl-dev \
 && rm -rf /var/lib/apt/lists/*

# Install Python deps first to leverage Docker layer caching
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Create a non-root user and prepare writable directories
RUN addgroup --system app && adduser --system --ingroup app app \
 && mkdir -p uploads outputs blockchain_storage \
 && chown -R app:app /app

USER app

# Default runtime env
ENV PORT=8000 \
    APP_MODULE=api_server:app

EXPOSE 8000

# Start Gunicorn with a config file; APP_MODULE can be overridden (e.g., api_server:app)
CMD ["/bin/sh", "-c", "exec gunicorn -c gunicorn.conf.py ${APP_MODULE}"]
