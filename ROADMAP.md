# Edge LLM Systems Lab — Project Roadmap

This document outlines the planned growth of the **Edge LLM Systems Lab**, an educational platform for running and researching Large Language Models on local/edge hardware.

---

## Current State (v1.0.0)

- 8 educational Jupyter notebooks covering: local LLM inference, API integration, RAG with ChromaDB, benchmarking, quantization analysis, experiment logging, quizzes, and advanced PDF RAG
- Docker + JupyterLab environment
- Ollama integration for local CPU inference
- JSONL-based experiment tracking

---

## Phase 1 — Content Expansion (v1.1 - v1.2)

**Goal:** Broaden the curriculum to cover more real-world research workflows.

### New Notebooks

| Notebook | Topic | Description |
|---|---|---|
| `09_Streaming_Responses.ipynb` | Streaming | Handle token-by-token output from Ollama, build a simple chat loop |
| `10_Multi_Model_Comparison.ipynb` | Evaluation | Compare llama3.2, mistral, phi3 on the same task suite |
| `11_Prompt_Engineering.ipynb` | Prompting | Zero-shot, few-shot, chain-of-thought, system prompts |
| `12_Agents_and_Tools.ipynb` | Agentic AI | Build a minimal tool-calling agent with Ollama |
| `13_Fine_Tuning_Basics.ipynb` | Training | LoRA fine-tuning with small datasets (CPU/GPU optional) |

### Dataset Collection

- Add curated domain-specific datasets in `datasets/` (scientific abstracts, technical documentation)
- Add dataset cards (metadata markdown) for each dataset
- Expand PDF ingestion pipeline from notebook 08 to support multi-document collections

---

## Phase 2 — Evaluation & Research Tools (v1.3 - v1.4)

**Goal:** Equip researchers with systematic evaluation infrastructure.

### Automated Benchmarking

- `experiments/benchmarks/` — structured benchmark suite
- Metrics: latency percentiles (p50, p90, p99), throughput (tokens/s), memory usage
- Automated comparison reports exported as HTML/PDF from notebooks

### Experiment Tracking Improvements

- Extend JSONL schema with fields: `tokens_prompt`, `tokens_generated`, `cpu_model`, `ram_gb`, `os`
- `analysis_scripts/report_generator.py` — generates markdown summary from `experiments.jsonl`
- Optional: Weights & Biases integration (offline-first, W&B as optional export)

### RAG Evaluation Framework

- Implement RAGAS-style metrics: faithfulness, answer relevancy, context recall
- Notebook: `14_RAG_Evaluation.ipynb`
- Ground-truth Q&A pairs for included datasets

---

## Phase 3 — Infrastructure & Usability (v1.5)

**Goal:** Make the lab easier to run, extend, and share.

### Developer Experience

- `Makefile` with targets: `make start`, `make stop`, `make pull-models`, `make test`
- `scripts/setup.sh` — one-command bootstrap for Linux/macOS
- `scripts/setup.ps1` — PowerShell equivalent for Windows

### Testing

- `tests/` directory with pytest suite
- Test Ollama connectivity, embedding pipeline, ChromaDB CRUD, logging schema
- CI-ready: tests runnable without Docker (mock Ollama responses)

### Model Management

- `models/` directory with model cards (YAML): name, size, quantization, use case, benchmark results
- Helper script to pull all recommended models: `scripts/pull_models.sh`

### Documentation

- Interactive `README` with badges (Docker, Python version, license)
- Per-notebook `docs/` pages rendered via MkDocs or Jupyter Book
- Glossary of terms: RAG, embeddings, quantization, inference, perplexity

---

## Phase 4 — Advanced Research Features (v2.0)

**Goal:** Support graduate-level research and publication workflows.

### Multi-Modal Support

- Notebook: `15_Vision_Language_Models.ipynb` — LLaVA or moondream via Ollama
- Image + text RAG pipeline using CLIP embeddings

### Knowledge Graph Integration

- Build a lightweight knowledge graph from documents (NetworkX or Neo4j lite)
- Graph-augmented RAG: combine vector search with graph traversal

### Serving & Deployment

- `FastAPI` wrapper: `serve/api.py` — expose local models as a REST endpoint
- Gradio demo: `serve/demo.py` — simple browser UI for model interaction
- Notebook: `16_Serving_Local_Models.ipynb`

### Privacy-Preserving Research

- Notebook on differential privacy basics applied to LLM outputs
- Discussion of air-gapped deployment patterns

---

## Phase 5 — Community & Open Science (v2.1+)

**Goal:** Make the lab shareable and forkable for other research groups.

### Template & Fork Support

- GitHub template repository configuration
- `CONTRIBUTING.md` with guidelines for adding notebooks
- Issue templates for bug reports and notebook proposals

### Shared Benchmark Results

- `results/` public leaderboard (markdown table) of model benchmarks on common hardware
- Encourage contributors to submit their own hardware benchmarks via PRs

### Integration Ecosystem

- LangChain adapter notebook
- LlamaIndex adapter notebook
- HuggingFace Transformers fallback (no-Ollama path)

---

## Milestone Summary

| Version | Theme | Target |
|---|---|---|
| v1.1 | Streaming + Multi-model comparison | Q2 2026 |
| v1.2 | Prompt engineering + Agents | Q3 2026 |
| v1.3 | Benchmarking infrastructure | Q3 2026 |
| v1.4 | RAG evaluation framework | Q4 2026 |
| v1.5 | DX improvements + Testing | Q4 2026 |
| v2.0 | Multi-modal + Serving | Q1 2027 |
| v2.1 | Community + Open Science | Q2 2027 |

---

## Contributing

If you want to contribute a notebook, benchmark result, or dataset, please follow the conventions in CLAUDE.md and open a pull request with:

1. The notebook following the `##_Title.ipynb` naming scheme
2. A brief description in the PR of what it teaches
3. At least one runnable example cell with expected output

---

*Maintained by Fabio Antonini — Edge LLM Systems Lab, 2026*
