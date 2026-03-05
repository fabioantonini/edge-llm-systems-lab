# Claude.md - Edge LLM Systems Lab

## 1. Project Documentation

### Overview
**Edge LLM Systems Lab** is an educational laboratory for exploring Large Language Models running locally on Edge/CPU hardware, specifically designed for PhD students and researchers.

**Author:** Fabio Antonini
**Year:** 2026
**License:** MIT

### Educational Goals
The project teaches researchers how to:
- Run LLMs locally on CPU using Ollama
- Integrate LLM APIs into Python research workflows
- Build Retrieval Augmented Generation (RAG) systems
- Use vector databases (ChromaDB) for semantic search
- Measure and profile inference performance
- Analyze quantization techniques
- Log experiments systematically

### System Architecture

```
Host Machine
├── Ollama Server (localhost:11434)
│   └── Manages LLM inference on CPU
│   └── Serves REST API
│
Docker Container (edge_llm_lab)
├── JupyterLab (localhost:8888)
├── Python 3.10 environment
├── Workspace mounted as volume
└── Connection to Ollama via host.docker.internal:11434
```

### Repository Content

```
edge-llm-systems-lab/
├── notebooks/                          # 7 educational Jupyter notebooks
│   ├── 01_Local_LLM_Introduction.ipynb
│   ├── 02_API_Integration.ipynb
│   ├── 03_RAG_With_Embeddings_Chroma.ipynb
│   ├── 04_Benchmarking_and_Profiling.ipynb
│   ├── 05_Quantization_Analysis.ipynb
│   ├── 06_Research_Experiments.ipynb
│   └── 07_Quiz_Hidden_Answers.ipynb
├── experiments/                        # Experiment tracking system
│   ├── analysis_scripts/
│   │   └── log_utils.py               # JSONL analysis utilities
│   ├── logs/
│   │   └── experiments.jsonl          # Timestamped logs
│   └── results/
│       └── quantization_bench.jsonl   # Quantization benchmarks
├── datasets/                           # Datasets for RAG experiments
├── docker/                             # Docker configuration files
├── slides/                             # Educational materials
├── Dockerfile                          # Python + JupyterLab container
├── docker-compose.yml                  # Service orchestration
├── requirements.txt                    # Python dependencies
└── README.md                           # User documentation
```

### Technology Stack

**Python Libraries:**
- `requests==2.31.0` - HTTP client for API calls
- `sentence-transformers==2.2.2` - Text embeddings
- `chromadb==0.4.22` - Vector database
- `numpy==1.26.4` - Numerical computing
- `psutil==5.9.8` - System monitoring
- `huggingface_hub==0.14.1` - Model access
- `httpx==0.27.0` - Async HTTP client
- `jupyterlab==4.1.5` - Interactive development environment

**Infrastructure:**
- Docker & Docker Compose
- Ollama (local LLM server)
- Python 3.10

---

## 2. Instructions for Claude Code

### Project Context
This is an **educational and research** project. Modifications must maintain:
- **Educational simplicity**: code must be understandable for PhD students
- **Reproducibility**: Docker environment must work across different machines
- **Clear documentation**: each notebook must be self-explanatory

### Working Principles

#### When modifying Jupyter notebooks:
- **Preserve educational structure**: each notebook follows a logical progression
- **Maintain explanatory cells**: markdown cells are integral to teaching
- **Don't over-optimize**: code should remain readable, not necessarily optimal
- **Include sample output**: when possible, show expected results

#### When working with experiments:
- **Use JSONL format**: all logs go to `experiments/logs/experiments.jsonl`
- **Timestamp required**: every experiment must have `ts` (Unix timestamp)
- **Consistent schema**: maintain fields `model`, `temperature`, `prompt`, `latency_s`, `output_chars`
- **Don't delete data**: add new experiments, don't overwrite existing logs

#### When modifying Docker setup:
- **Always test builds**: `docker compose up --build` must work
- **Keep Ollama on host**: DO NOT containerize Ollama
- **Preserve volume mount**: `/workspace` must map to current directory
- **Don't remove `host.docker.internal`**: necessary to communicate with Ollama

#### Files NOT to modify without explicit request:
- `requirements.txt` - only if strictly necessary
- `experiments/logs/*.jsonl` - existing research data
- `docker-compose.yml` - established architecture
- Files in `slides/` - approved educational materials

#### Best Practices for modifications:
1. **Always read before modifying**: use `Read` to understand context
2. **Maintain existing style**: follow existing conventions
3. **Test locally**: if possible, verify code works
4. **Document changes**: add comments where necessary
5. **Respect modular structure**: each notebook is independent

### Useful Commands

```bash
# Start the environment
docker compose up --build

# Verify Ollama is active
curl http://localhost:11434/api/tags

# Pull a model
ollama pull llama3.2:3b

# Access the container
docker exec -it edge_llm_lab bash

# View container logs
docker logs edge_llm_lab
```

### Common Troubleshooting

**Problem:** Container cannot connect to Ollama
- **Solution:** Verify Ollama is running on host: `ollama serve`
- **Verify:** `curl http://host.docker.internal:11434/api/tags` from container

**Problem:** Import error for sentence-transformers
- **Solution:** Rebuild container: `docker compose down && docker compose up --build`

**Problem:** Jupyter won't start
- **Solution:** Port 8888 may be occupied, check with `netstat -an | findstr 8888`

---

## 3. Setup and Configuration

### Prerequisites

#### On Windows:
```powershell
# 1. Install Docker Desktop
# Download: https://www.docker.com/products/docker-desktop/

# 2. Install Ollama
# Download: https://ollama.com

# 3. Verify installation
docker --version
ollama --version
```

#### On macOS:
```bash
# 1. Install Docker Desktop
brew install --cask docker

# 2. Install Ollama
brew install ollama

# 3. Verify installation
docker --version
ollama --version
```

#### On Linux:
```bash
# 1. Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 2. Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 3. Verify installation
docker --version
ollama --version
```

### Complete Installation

#### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd edge-llm-systems-lab
```

#### Step 2: Start Ollama
```bash
# Start Ollama server (keep open in a separate terminal)
ollama serve

# In a new terminal, pull the model
ollama pull llama3.2:3b

# Verify the model is available
ollama list
```

#### Step 3: Start Docker Environment
```bash
# Build and start container
docker compose up --build

# Expected output:
# ✓ Container edge_llm_lab Started
# JupyterLab available at http://localhost:8888
```

#### Step 4: Access JupyterLab
```
Open browser at: http://localhost:8888
```

**Note:** Authentication token is disabled for simplicity in local environment.

### Advanced Configuration

#### Change JupyterLab Port
Modify in `docker-compose.yml`:
```yaml
ports:
  - "9999:8888"  # Use port 9999 instead of 8888
```

#### Add Environment Variables
Add in `docker-compose.yml`:
```yaml
environment:
  - OLLAMA_BASE_URL=http://host.docker.internal:11434
  - CUSTOM_VAR=value
```

#### Use a Different Model
```bash
# Pull other Ollama models
ollama pull mistral:7b
ollama pull codellama:13b
ollama pull llama3.1:8b
```

Modify in notebooks the `model` variable:
```python
model = "mistral:7b"  # instead of llama3.2:3b
```

### Installation Verification

#### Connectivity Test
From Docker container:
```bash
docker exec -it edge_llm_lab python3 -c "
import requests
response = requests.get('http://host.docker.internal:11434/api/tags')
print('Status:', response.status_code)
print('Models:', response.json())
"
```

#### Inference Test
From notebook or terminal:
```python
import requests

response = requests.post(
    "http://host.docker.internal:11434/api/generate",
    json={
        "model": "llama3.2:3b",
        "prompt": "Hello, world!",
        "stream": False
    }
)
print(response.json()["response"])
```

### Uninstallation

```bash
# Stop and remove container
docker compose down

# Remove image
docker rmi edge-llm-systems-lab-lab

# Remove Ollama models (optional)
ollama rm llama3.2:3b
```

---

## 4. Development Notes

### Code Conventions

#### Jupyter Notebooks
- **Naming:** `##_Descriptive_Title.ipynb` (two-digit numbering)
- **Structure:**
  1. Title and introduction (markdown)
  2. Imports and setup (code cell)
  3. Thematic sections with markdown headers
  4. Executable examples with output
  5. Exercises/quizzes when appropriate

#### Python Scripts
- **Style:** PEP 8 compliant
- **Docstrings:** Google style
- **Type hints:** Optional but encouraged for utility functions

#### Experiment Logging
Standard JSONL schema:
```python
{
    "ts": float,              # Unix timestamp
    "model": str,             # Ollama model name
    "temperature": float,     # Sampling parameter
    "prompt": str,            # User input
    "latency_s": float,       # Inference time in seconds
    "output_chars": int       # Output length
}
```

### Dependency Architecture

#### Core Dependencies
```
sentence-transformers
├── torch (auto-installed)
├── transformers
└── numpy

chromadb
├── onnxruntime
├── sqlite3
└── httpx

requests
└── urllib3
```

#### Known Conflicts
- **numpy:** Use version >=1.26.4 for compatibility with sentence-transformers
- **chromadb:** Version 0.4.22 required for stability

### Common Development Patterns

#### 1. Standard Ollama API Call
```python
import requests

def query_ollama(prompt: str, model: str = "llama3.2:3b", temperature: float = 0.0):
    response = requests.post(
        "http://host.docker.internal:11434/api/generate",
        json={
            "model": model,
            "prompt": prompt,
            "temperature": temperature,
            "stream": False
        }
    )
    return response.json()["response"]
```

#### 2. Experiment Logging
```python
import json
import time

def log_experiment(model, temperature, prompt, latency, output):
    log_entry = {
        "ts": time.time(),
        "model": model,
        "temperature": temperature,
        "prompt": prompt,
        "latency_s": latency,
        "output_chars": len(output)
    }

    with open("/workspace/experiments/logs/experiments.jsonl", "a") as f:
        f.write(json.dumps(log_entry) + "\n")
```

#### 3. Embeddings for RAG
```python
from sentence_transformers import SentenceTransformer

model = SentenceTransformer('all-MiniLM-L6-v2')
embeddings = model.encode(["text 1", "text 2"])
```

#### 4. ChromaDB Setup
```python
import chromadb

client = chromadb.PersistentClient(path="/workspace/datasets/chromadb")
collection = client.get_or_create_collection(name="documents")
```

### Performance Considerations

#### Typical Latency (llama3.2:3b on CPU)
- **Short prompts (<50 tokens):** 2-4 seconds
- **Medium prompts (50-200 tokens):** 4-7 seconds
- **Long prompts (>200 tokens):** 7-15 seconds

#### Memory Footprint
- **Base container:** ~500MB RAM
- **With 3B model loaded:** ~3-4GB RAM
- **ChromaDB collection:** ~100MB per 10k documents

#### Possible Optimizations
1. **Batch inference:** Process multiple prompts together
2. **Context caching:** Reuse common prefixes
3. **Quantization:** Use quantized models (e.g., `llama3.2:3b-q4`)

### Debugging and Profiling

#### Measure Latency
```python
import time

start = time.time()
response = query_ollama(prompt)
latency = time.time() - start
print(f"Latency: {latency:.2f}s")
```

#### Monitor Resources
```python
import psutil

cpu_percent = psutil.cpu_percent(interval=1)
memory = psutil.virtual_memory()
print(f"CPU: {cpu_percent}%")
print(f"Memory: {memory.percent}%")
```

#### Ollama Log Level
```bash
# Start Ollama with verbose logging
OLLAMA_DEBUG=1 ollama serve
```

### Future Extensions

#### Ideas for New Notebooks
- **08_Multi_Model_Comparison.ipynb** - Compare different models
- **09_Streaming_Responses.ipynb** - Handle streaming output
- **10_Fine_Tuning_Basics.ipynb** - Introduction to fine-tuning

#### Possible Integrations
- **LangChain:** Framework for complex LLM applications
- **Weights & Biases:** Cloud experiment tracking
- **FastAPI:** Serve models via custom REST API
- **Gradio:** Interactive UI for demos

### Testing

#### Unit Tests (to be implemented)
```bash
# Proposed structure
tests/
├── test_api_integration.py
├── test_embeddings.py
└── test_logging.py
```

#### Integration Tests
```python
# Example Ollama connectivity test
def test_ollama_connection():
    import requests
    response = requests.get("http://host.docker.internal:11434/api/tags")
    assert response.status_code == 200
    assert "models" in response.json()
```

### Security Notes

#### Security Considerations
- **JupyterLab without password:** OK for local development, NOT for production
- **Docker socket:** Container has no access to Docker socket (secure)
- **Network:** Container uses bridge network (isolated)
- **Sensitive data:** DO NOT commit API keys or personal data in logs

#### Best Practices
1. Use `.gitignore` to exclude sensitive logs
2. Don't expose JupyterLab on 0.0.0.0 in production
3. Validate user input before passing to Ollama
4. Monitor log file sizes

---

## Changelog

### v1.0.0 (2026)
- Initial laboratory release
- 7 complete educational notebooks
- JSONL experiment logging system
- Docker environment with JupyterLab
- Complete documentation

---

## Contributing

To contribute to the project:
1. Maintain the educational philosophy
2. Test all modifications in Docker environment
3. Document new features in notebooks
4. Follow existing code conventions
5. Add executable examples

---

## Contact and Support

**Author:** Fabio Antonini
**Year:** 2026
**License:** MIT

For questions or issues, refer to Ollama documentation: https://ollama.com/docs
