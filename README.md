
# Edge LLM Systems Lab

An introductory **Edge AI / Local LLM laboratory** for PhD students.

This repository demonstrates how to run **Large Language Models locally on CPU** using **Ollama**, and how to integrate them programmatically in Python for research workflows.

Topics covered:

- Local LLM inference on CPU
- Ollama REST API integration
- Retrieval Augmented Generation (RAG)
- Vector databases (ChromaDB)
- LLM benchmarking and profiling
- Quantization exploration
- Research experiment logging

---

# Architecture

Ollama runs **on the host machine**.

Docker is used only to provide a reproducible Python + Jupyter environment.

Host
 └── Ollama (localhost:11434)

Docker container
 └── Jupyter Lab
       └── Python notebooks
             ↓
       http://host.docker.internal:11434

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

1. Local LLM introduction
2. API integration with Ollama
3. Retrieval Augmented Generation (RAG)
4. Benchmarking and profiling
5. Quantization analysis
6. Research experiments
7. Quiz

---

# Requirements

The Docker environment includes:

- sentence-transformers
- chromadb
- requests
- numpy
- psutil

---

# Educational goals

This lab teaches:

- running LLMs locally
- integrating LLM APIs in Python
- building a simple RAG system
- measuring inference performance
- experimenting with local AI infrastructure

---

© 2026
