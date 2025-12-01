# Gebruik een klein Python image
FROM python:3.11-slim

WORKDIR /app

# Update en installeer dependencies voor Chromium/Kaleido
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libnss3 \
    libxss1 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy de app
COPY . .

# Vertel Kaleido waar Chromium staat
ENV PLOTLY_KALEIDO_EXECUTABLE=/usr/bin/chromium

# Expose poort
EXPOSE 5000

# Start Flask app
CMD ["python", "app.py"]
