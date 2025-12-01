from flask import Flask, request, send_file, jsonify
import plotly.io as pio
import json
import base64
import io

app = Flask(__name__)

@app.post("/image")
def image():
    try:
        body = request.json
        figure = body.get("figure")
        if figure is None:
            return jsonify({"error": "Missing figure"}), 400

        format = body.get("format", "png")
        width = body.get("width", 1200)
        height = body.get("height", 600)
        encoded = body.get("encoded", False)

        fig = pio.from_json(json.dumps(figure))
        img_bytes = fig.to_image(format=format, width=width, height=height)

        if encoded:
            return jsonify({"image": base64.b64encode(img_bytes).decode()})
        return send_file(io.BytesIO(img_bytes), mimetype=f"image/{format}")
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
