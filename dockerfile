# Start vanaf een klein Python image
FROM python:3.11-slim

# Update en install basic dependencies
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
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Force Kaleido Chrome download tijdens build (optioneel)
RUN python -c "import kaleido; kaleido.get_chrome_sync()"

# Copy rest van de app
COPY . .

# Expose poort
EXPOSE 5000

# Start Flask app
CMD ["python", "app.py"]
