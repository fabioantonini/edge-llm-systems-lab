FROM python:3.10-slim

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip setuptools wheel
# Installa PyTorch CPU-only prima dei requirements per evitare i binari CUDA (~3-4 GB)
RUN pip install --no-cache-dir torch torchvision --index-url https://download.pytorch.org/whl/cpu
RUN pip install --default-timeout=100 --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir jupyterlab==4.1.5

# copia i notebook dentro l'immagine
COPY notebooks /workspace/notebooks
COPY datasets /workspace/datasets

EXPOSE 8888

CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--NotebookApp.token=", "--NotebookApp.password=", "--allow-root"]
