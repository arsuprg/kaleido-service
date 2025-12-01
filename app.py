from flask import Flask, request, send_file
import plotly.graph_objects as go
import kaleido
import io

app = Flask(__name__)

@app.route("/image", methods=["POST"])
def create_image():
    data = request.get_json()
    
    # Zorg dat Chrome aanwezig is voor Kaleido
    kaleido.get_chrome_sync()
    
    fig = go.Figure(data=data["figure"]["data"], layout=data["figure"].get("layout"))
    img_bytes = fig.to_image(format=data.get("format", "png"))
    
    return send_file(
        io.BytesIO(img_bytes),
        mimetype="image/png",
        as_attachment=True,
        download_name="figure.png"
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
