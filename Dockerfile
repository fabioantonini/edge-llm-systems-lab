FROM python:3.10-slim

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    gcc \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip setuptools wheel
RUN pip install --default-timeout=100 --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir jupyterlab==4.1.5

# copia i notebook dentro l'immagine
COPY notebooks /workspace/notebooks
COPY datasets /workspace/datasets
COPY src /workspace/src

EXPOSE 8888

CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--NotebookApp.token=", "--NotebookApp.password=", "--allow-root"]