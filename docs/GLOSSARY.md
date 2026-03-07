# Glossary

Key terms used across the Edge LLM Systems Lab notebooks.

---

## A

**API (Application Programming Interface)**
A set of rules that allows software to communicate. In this lab, Ollama exposes a REST API on port `11434` that notebooks use to send prompts and receive responses.

---

## C

**ChromaDB**
An open-source, local vector database used to store and search text embeddings. In this lab it runs entirely in-process — no server required.

**Context window**
The maximum number of tokens a model can process at once (prompt + response). For `llama3.2:3b` this is typically 4096–8192 tokens. Exceeding it causes the model to forget earlier content.

**CPU inference**
Running a neural network on the CPU rather than a GPU. Slower but accessible on any machine. This lab focuses entirely on CPU inference via Ollama.

---

## D

**Docker**
A containerization platform used in this lab to provide a reproducible Python + JupyterLab environment independent of the host OS.

---

## E

**Embedding**
A fixed-length numerical vector that represents the semantic meaning of a piece of text. Similar texts have embeddings that are close together in vector space. Generated in this lab with `sentence-transformers`.

---

## H

**Hallucination**
When a language model generates text that is factually incorrect or fabricated, stated with apparent confidence. RAG reduces hallucinations by grounding responses in retrieved documents.

---

## J

**JSONL (JSON Lines)**
A text format where each line is a valid JSON object. Used in this lab for experiment logs (`experiments.jsonl`) because it is easy to append and parse incrementally.

---

## L

**Latency**
The time elapsed between sending a prompt and receiving the full response. Measured in seconds (`latency_s`). Typical range on CPU for `llama3.2:3b`: 2–15 seconds depending on prompt length.

**LLM (Large Language Model)**
A neural network trained on large text corpora that can generate, summarize, translate, and reason about text. Examples: llama3.2, mistral, phi3.

---

## O

**Ollama**
A local runtime that downloads and serves open-source LLMs on CPU (and GPU if available). Exposes a REST API compatible with the OpenAI format. Runs on the host machine in this lab.

---

## P

**Perplexity**
A measure of how well a language model predicts a text sample. Lower perplexity = the model finds the text more likely / natural. Used to compare model quality.

**Prompt**
The text input sent to a language model. Prompt design (prompt engineering) strongly influences output quality.

---

## Q

**Quantization**
A technique to reduce model size and memory usage by representing weights with fewer bits (e.g., 4-bit instead of 32-bit floats). Trades a small drop in quality for large gains in speed and RAM efficiency. Explored in notebook 05.

---

## R

**RAG (Retrieval-Augmented Generation)**
A technique that combines a retrieval step (find relevant documents via semantic search) with a generation step (ask the LLM to answer using those documents as context). Reduces hallucinations and allows the model to answer questions about documents it was not trained on. Core topic of notebooks 03 and 08.

**REST API**
An HTTP-based interface where clients send requests (GET, POST) to endpoints (URLs) and receive JSON responses. Ollama's API follows this pattern.

---

## S

**Semantic search**
Finding documents that are *conceptually similar* to a query, even if they don't share the same words. Achieved by comparing embeddings in vector space using cosine similarity.

**Sentence Transformers**
A Python library (`sentence-transformers`) that provides pre-trained models for generating text embeddings. Used in this lab with the `all-MiniLM-L6-v2` model.

**Streaming**
Receiving a model's response token-by-token as it is generated, rather than waiting for the full output. Covered in notebook 02.

---

## T

**Temperature**
A parameter (0.0–2.0) that controls the randomness of model outputs. `0.0` = deterministic / focused; `1.0` = balanced; `>1.0` = creative / unpredictable. Explored in notebooks 04 and 06.

**Token**
The basic unit a language model operates on. A token is roughly 3–4 characters in English (e.g., "running" = 1 token, "unbelievable" = 3–4 tokens). Model limits (context window, pricing) are expressed in tokens.

**Throughput**
The number of tokens generated per second. A measure of inference speed complementary to latency.

---

## V

**Vector database**
A database optimized for storing and searching high-dimensional vectors (embeddings). Supports fast nearest-neighbor queries. ChromaDB is the vector database used in this lab.

---

*Edge LLM Systems Lab — Fabio Antonini, 2026*
