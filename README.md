
# Edge LLM Systems Lab

An educational **Edge AI / Local LLM laboratory** for PhD students and researchers.

This repository demonstrates how to run **Large Language Models locally on CPU** using **Ollama**, and how to integrate them programmatically in Python for research workflows — from basic inference to advanced Retrieval Augmented Generation (RAG) systems.

Topics covered:

- Local LLM inference on CPU
- Ollama REST API integration
- Retrieval Augmented Generation (RAG) — basic and advanced
- PDF ingestion and semantic search with ChromaDB
- LLM benchmarking and profiling
- Quantization exploration
- Research experiment logging

---

# Architecture

Ollama runs **on the host machine**.

Docker is used only to provide a reproducible Python + Jupyter environment.

```
Host
 └── Ollama (localhost:11434)

Docker container
 └── JupyterLab
       └── Python notebooks
             ↓
       http://host.docker.internal:11434
```

---

# Prerequisites

Install Ollama on your host machine:

https://ollama.com

Start Ollama:

```
ollama serve
```

Pull a model:

```
ollama pull llama3.2:3b
```

---

# Run the Lab

Start the environment:

```
docker compose up --build
```

Open JupyterLab:

```
http://localhost:8888
```

---

# Notebooks

| # | Title | Topics |
|---|---|---|
| 01 | Local LLM Introduction | Ollama setup, first inference |
| 02 | API Integration | REST API, Python client |
| 03 | RAG with Embeddings & ChromaDB | Embeddings, vector search, basic RAG |
| 04 | Benchmarking and Profiling | Latency, throughput, CPU/RAM monitoring |
| 05 | Quantization Analysis | Model sizes, quality vs. speed tradeoffs |
| 06 | Research Experiments | Systematic logging, JSONL schema |
| 07 | Quiz | Knowledge check with hidden answers |
| 08 | Advanced PDF RAG with ChromaDB | PDF ingestion, chunking, semantic retrieval |

---

# Requirements

The Docker environment includes:

- `sentence-transformers` — text embeddings
- `chromadb` — vector database
- `requests` / `httpx` — HTTP clients
- `numpy` — numerical computing
- `psutil` — system monitoring
- `jupyterlab` — interactive environment

---

# Educational Goals

This lab teaches:

- Running LLMs locally on consumer hardware
- Integrating LLM APIs in Python research workflows
- Building RAG systems from scratch
- Ingesting and querying PDF documents semantically
- Measuring and profiling inference performance
- Logging and comparing experiments systematically

---

# Roadmap

See [ROADMAP.md](ROADMAP.md) for the full plan — including upcoming notebooks on streaming, multi-model comparison, prompt engineering, agents, RAG evaluation, and more.

---

© 2026 Fabio Antonini — MIT License
