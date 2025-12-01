# Start vanaf een klein Python image
FROM python:3.11-slim
WORKDIR /app

# Update en install Chromium + dependencies voor Kaleido
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    fonts-liberation \
    libnss3 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libxkbcommon0 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libgtk-3-0 \
    libx11-xcb1 \
    xdg-utils \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy de app
COPY app.py .
COPY . .

# Force Kaleido Chrome download tijdens build
RUN python -c "import kaleido; kaleido.get_chrome_sync()"

# Expose poort
EXPOSE 5000

# Start Flask app
CMD ["python", "app.py"]
