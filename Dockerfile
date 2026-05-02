FROM python:3.10-slim

LABEL maintainer="blue-green-deployment"
LABEL description="Blue-Green Deployment Demo Application"
LABEL version="1.0"

WORKDIR /app

# Create non-root user
RUN useradd -m -u 1000 appuser

COPY app.py .

RUN pip install --no-cache-dir flask gunicorn && \
    chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

CMD ["gunicorn", "-b", "0.0.0.0:5000", "--workers", "4", "--threads", "2", "--worker-class", "gthread", "--timeout", "60", "app:app"]