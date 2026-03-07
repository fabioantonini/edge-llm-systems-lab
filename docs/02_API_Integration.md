# Notebook 02 - API Integration with Ollama

**File:** `notebooks/02_API_Integration.ipynb`

## Objective

Deepen the programmatic integration with the Ollama REST API in Python, covering all main endpoints and robust error handling.

## What students will learn

- How to perform a health check on the Ollama server
- How to list locally installed models
- The difference between `/api/generate` (single-turn) and `/api/chat` (multi-turn)
- How to handle **streaming** responses (JSONL line-by-line)
- How to handle timeouts and HTTP errors robustly

## Notebook structure

| Section | Content |
|---------|---------|
| Health check | `health_check()` function with exception handling |
| List models | Call to `/api/tags` to retrieve available models |
| `/api/generate` | Single-turn generation with configurable temperature |
| `/api/chat` | Multi-turn conversation with `system`/`user`/`assistant` roles |
| Streaming | Chunk-by-chunk reading with `stream=True` and `iter_lines()` |

## Functions implemented

```python
health_check()          # Verify server reachability
list_models()           # List installed models
generate(prompt, ...)   # Single-turn generation via /api/generate
chat(messages, ...)     # Multi-turn chat via /api/chat
generate_stream(prompt) # Streaming generation with JSONL
```

## Key concepts

- **`/api/generate`**: accepts `model` + `prompt`, returns a single `response`
- **`/api/chat`**: accepts a list of `messages` with roles, supports conversational context
- **Streaming**: the server sends one JSON line per token, useful for real-time output display
- **`temperature`**: controls output creativity (0.0 = deterministic, >1.0 = highly creative)

## Available models (example from real output)

```
['llama3.2:3b', 'gemma3:4b', 'gpt-oss:20b', 'gemma:2b', 'llama3.2:latest']
```

## Technical prerequisites

```python
import requests
import json
from typing import Iterator, Dict, Any, List
```
