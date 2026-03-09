# Installing Ollama and Running Local LLMs

This guide explains how to install **Ollama on Windows**, run a **local Large Language Model**, and understand how the system works internally.

Ollama makes it easy to run open-source LLMs locally, without relying on cloud services.

Typical use cases include:

* AI research
* RAG systems
* privacy-preserving AI
* offline LLM usage
* edge AI applications

---

# 1. System Requirements

Minimum recommended configuration:

| Component | Recommended             |
| --------- | ----------------------- |
| RAM       | 8 GB (16 GB preferred)  |
| CPU       | modern x86_64 processor |
| Disk      | 10 GB free              |
| OS        | Windows 10 / Windows 11 |

The **llama3.2:3b** model runs well on CPU.

---

# 2. Download Ollama

Visit:

[https://ollama.com](https://ollama.com)

Download the **Windows installer**.

---

# 3. Install Ollama

Run the installer:

```
OllamaSetup.exe
```

After installation verify that Ollama is available:

```
ollama --version
```

Example output:

```
ollama version 0.x.x
```

---

# 4. Start the Ollama Server

Normally Ollama runs automatically.

You can also start it manually:

```
ollama serve
```

The server runs at:

```
http://localhost:11434
```

Open a browser and visit:

```
http://localhost:11434
```

You should see:

```
Ollama is running
```

---

# 5. Download the Model

Download the Llama 3.2 model:

```
ollama pull llama3.2:3b
```

Approximate size:

```
~2 GB
```

---

# 6. Run the Model

Start an interactive session:

```
ollama run llama3.2:3b
```

Example:

```
>>> Explain what a Large Language Model is.
```

---

# 7. Ollama Architecture

Ollama acts as a **local LLM runtime and API server**.

```
User / Application
        │
        │  HTTP API
        ▼
+---------------------+
|     Ollama API      |
|  localhost:11434    |
+---------------------+
        │
        │
        ▼
+---------------------+
|  Model Runtime      |
|  (GGUF models)      |
+---------------------+
        │
        │
        ▼
+---------------------+
| CPU / GPU Inference |
+---------------------+
        │
        ▼
Generated Response
```

Main components:

| Component        | Role                      |
| ---------------- | ------------------------- |
| API Server       | exposes REST endpoints    |
| Runtime          | loads GGUF models         |
| Tokenizer        | converts text into tokens |
| Inference Engine | generates tokens          |
| Hardware         | CPU or GPU                |

---

# 8. LLM Inference Pipeline

When a prompt is sent to the model, the following steps occur.

```
Prompt
  │
  ▼
Tokenization
  │
  ▼
Embedding lookup
  │
  ▼
Transformer layers
  │
  ▼
Next-token prediction
  │
  ▼
Token sampling
  │
  ▼
Generated text
```

In simplified form:

$$
P(w_t | w_1, w_2, ..., w_{t-1})
$$

The model predicts the probability of the next token given the previous tokens.

Key operations inside the transformer include:

* attention
* feed-forward layers
* normalization
* residual connections

---

# 9. Ollama API Example

Example request:

```
POST /api/generate
```

Python example:

```python
import requests

BASE_URL = "http://localhost:11434"

payload = {
    "model": "llama3.2:3b",
    "prompt": "Explain transformers in simple terms",
    "stream": False
}

r = requests.post(f"{BASE_URL}/api/generate", json=payload)

print(r.json()["response"])
```

---

# 10. Comparison: Ollama vs HuggingFace vs OpenAI

| Feature          | Ollama        | HuggingFace      | OpenAI     |
| ---------------- | ------------- | ---------------- | ---------- |
| Local models     | yes           | yes              | no         |
| Cloud API        | no            | optional         | yes        |
| Privacy          | high          | medium           | low        |
| Hardware control | full          | full             | none       |
| Ease of use      | very high     | medium           | very high  |
| Deployment       | local runtime | Python libraries | remote API |

### Ollama

Best for:

* local AI
* edge AI
* RAG systems
* research experiments

---

### HuggingFace

Best for:

* training models
* experimentation
* research frameworks

Libraries include:

* transformers
* datasets
* accelerate

---

### OpenAI API

Best for:

* production AI services
* high-performance models
* minimal infrastructure

---

# 11. CPU vs GPU Inference

Running LLMs locally can use either CPU or GPU.

| Feature       | CPU     | GPU         |
| ------------- | ------- | ----------- |
| Hardware cost | low     | high        |
| Speed         | slower  | much faster |
| Memory        | limited | high VRAM   |
| Setup         | simple  | complex     |

Example speeds:

| Model | CPU tokens/sec | GPU tokens/sec |
| ----- | -------------- | -------------- |
| 3B    | 5-15           | 50-150         |
| 7B    | 2-8            | 30-100         |
| 13B   | 1-3            | 20-70          |

---

### Why small models run on CPU

Models like:

```
llama3.2:3b
phi3
gemma2:2b
```

are designed to run efficiently on consumer hardware.

This enables:

* laptops
* edge devices
* research prototypes

---

# 12. Typical Workflow for Local LLM Research

```
Install Ollama
      │
      ▼
Download model
      │
      ▼
Run local API
      │
      ▼
Integrate with Python
      │
      ▼
Build applications
```

Examples:

* local chatbots
* document QA
* RAG systems
* AI assistants
* research experiments

---

# 13. Next Steps

After installing Ollama you can experiment with:

* prompt engineering
* retrieval augmented generation
* local embeddings
* benchmarking LLM performance
* edge AI deployment

