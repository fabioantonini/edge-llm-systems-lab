# Notebook 01 - Local LLM Introduction

**File:** `notebooks/01_Local_LLM_Introduction.ipynb`

## Objective

Introduce students to **local inference of Large Language Models (LLMs)** using Ollama, a server that runs open-source models directly on the CPU of your own machine.

## What students will learn

- What running an LLM locally means (no cloud, no API key, no per-token cost)
- How to verify that the Ollama server is reachable via HTTP
- How to send a text generation request through the Ollama REST API
- How to measure inference latency on CPU
- How to reflect on hardware constraints (CPU, RAM)

## Notebook structure

| Section | Content |
|---------|---------|
| 1) Server check | Connect to `http://localhost:11434` and verify status |
| 2) Basic text generation | First call to `llama3.2:3b` with a simple prompt |
| 3) Latency measurement | Stopwatch around the API call using `time.time()` |
| 4) Discussion questions | Reflections on hardware, prompt length, and comparison with cloud APIs |

## Key concepts

- **Ollama**: local runtime for LLMs that exposes a REST API on port `11434`
- **Model used**: `llama3.2:3b` (3 billion parameters, lightweight for CPU)
- **API endpoints**: `/v1/chat/completions` (OpenAI-compatible) and `/api/generate`
- **CPU latency**: typically 2-7 seconds for short/medium prompts

## Technical prerequisites

```bash
# The model must be pulled before running the notebook
ollama pull llama3.2:3b
```

## Expected output example

```
Using Ollama at: http://host.docker.internal:11434
Server reachable. Status: 200
Latency (seconds): 1.79
```

## Discussion questions included in the notebook

1. How does latency compare to cloud-based APIs you have used?
2. What happens if you increase prompt length significantly?
3. What hardware resource (CPU, RAM) seems most critical?
