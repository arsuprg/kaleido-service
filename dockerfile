# Start vanaf een klein Python image
FROM python:3.11-slim

# Werkdirectory
WORKDIR /app

# Update en install basic dependencies + extra libs voor Chrome/Kaleido
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
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
    libgbm1 \
    libxfixes3 \
    libxkbcommon0 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies
COPY requirements.txt .

# Installeer dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy de Flask app
COPY app.py .

# Forceer Kaleido Chrome download tijdens build
RUN python -c "import kaleido; kaleido.get_chrome_sync()"

# Copy de rest van je app (indien meer bestanden)
COPY . .

# Expose poort
EXPOSE 5000

# Start Flask app
CMD ["python", "app.py"]
