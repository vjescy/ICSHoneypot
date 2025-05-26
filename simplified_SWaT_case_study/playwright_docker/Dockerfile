# Use Python 3.9 slim image
FROM python:3.9-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxcomposite1 \
    libxrandr2 \
    libglu1-mesa \
    libnss3 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libxss1 \
    libgdk-pixbuf2.0-0 \
    libasound2 \
    libgbm-dev \
    libpango-1.0-0 \
    wget \
    curl \
    ca-certificates \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy your application files
COPY ./ /app/

# Install python dependencies
RUN python3 -m venv .venv
RUN .venv/bin/pip install --upgrade pip
RUN .venv/bin/pip install -r requirements.txt

# Install Playwright and its dependencies
RUN .venv/bin/pip install playwright
RUN .venv/bin/python -m playwright install-deps  # Install the necessary system dependencies for Playwright
RUN .venv/bin/python -m playwright install  # Install the Playwright browsers

# Run the script (replace with your script name)
CMD [".venv/bin/python", "auto.py", "auto2.py", "auto3.py"]
