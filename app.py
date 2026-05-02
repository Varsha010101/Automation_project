from flask import Flask
import os

app = Flask(__name__)

VERSION = os.getenv("APP_VERSION", "unknown")

@app.route('/')
def home():
    return f"{VERSION.upper()} VERSION"

@app.route('/health')
def health():
    return "OK", 200

@app.route('/ready')
def ready():
    return "READY", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)