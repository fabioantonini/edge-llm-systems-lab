# edge-llm-systems-lab

An **introductory, research-aware** lab for PhD students covering:

- Local LLM inference on CPU with **Ollama**
- Python integration via REST APIs
- RAG with embeddings + vector DB (Chroma)
- Benchmarking & profiling
- Intro quantization benchmarking
- A minimal experiment harness with JSONL logs

## Quick start (Docker)

```bash
docker compose up --build
```

Open JupyterLab: http://localhost:8888

Pull a model (first time only):

```bash
docker exec -it ollama_server ollama pull llama3.2:3b
```

## Notebook roadmap

1. `01_Local_LLM_Introduction.ipynb`
2. `02_API_Integration.ipynb`
3. `03_RAG_With_Embeddings_Chroma.ipynb`
4. `04_Benchmarking_and_Profiling.ipynb`
5. `05_Quantization_Analysis.ipynb`
6. `06_Research_Experiments.ipynb`
7. `07_Quiz_Hidden_Answers.ipynb`

## Slides

- `slides/Ollama_Tutorial_Advanced_Slides.pptx`

© 2026
