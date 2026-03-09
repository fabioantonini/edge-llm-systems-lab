---
marp: true
theme: default
paginate: true
backgroundColor: "#ffffff"
color: "#1a1a2e"
style: |
  section { font-family: "Segoe UI", sans-serif; font-size: 1.1rem; }
  h1 { color: #1a1a2e; border-bottom: 3px solid #4a90d9; padding-bottom: 0.3em; }
  h2 { color: #2c5f8a; }
  h3 { color: #4a90d9; }
  code { background: #f0f4f8; padding: 0.1em 0.4em; border-radius: 4px; }
  pre { background: #f0f4f8; border-left: 4px solid #4a90d9; padding: 1em; }
  strong { color: #2c5f8a; }
  section.title { background: linear-gradient(135deg, #1a1a2e 0%, #2c5f8a 100%); color: #ffffff; text-align: center; justify-content: center; }
  section.title h1 { color: #ffffff; border-bottom: 3px solid #4a90d9; }
  section.title h2 { color: #a8d4f5; }
  section.section-header { background: #2c5f8a; color: #ffffff; justify-content: center; text-align: center; }
  section.section-header h1 { color: #ffffff; border-bottom: 2px solid #a8d4f5; }
---

<\!-- _class: title -->

# Local LLMs and RAG Systems
## A Research Perspective

**Edge LLM Systems Lab**
Fabio Antonini — 2026

---

## Agenda

1. Introduction: The AI Infrastructure Paradigm Shift
2. Privacy and Data Control
3. Cost and Sustainability
4. Research Reproducibility
5. Latency and Performance
6. RAG Systems: Bringing It All Together
7. Practical Considerations and Limitations
8. The Future of Local AI in Research
9. Key Takeaways

---

<\!-- _class: section-header -->

# 1. Introduction
## The AI Infrastructure Paradigm Shift

---

## The Cloud-First Era — and Its Limits

**The dominant model (2020–2023):**
- GPT-3, ChatGPT: AI capabilities lived exclusively in the cloud
- Zero infrastructure management, instant access
- But: data leaves your environment, API costs scale with usage, models change without notice

**The shift (2023–today):**
- Meta LLaMA: powerful models under open licenses
- Quantization: 7B models run on CPU with minimal quality loss
- Ollama: local deployment as simple as `ollama pull llama3.2:3b`

> The question is no longer *cloud or local?* but **when to use cloud, when to use local**.

---

## Four Pillars of Local LLM Motivation

| Pillar | Why it matters |
|---|---|
| **Privacy** | Sensitive data never leaves your environment |
| **Cost** | No per-token charges at research scale |
| **Reproducibility** | Frozen weights: identical results in 5 years |
| **Performance** | No network latency for batch or real-time workloads |

---

## This Lab Architecture

```
Host Machine
└── Ollama (localhost:11434)
      └── llama3.2:3b weights — never leave your machine

Docker Container
└── JupyterLab + Python
      └── Notebooks → http://host.docker.internal:11434
```

**Design principle:** model serving and application logic are separated.
Data stays local. Environment is reproducible.

---

<\!-- _class: section-header -->

# 2. Privacy and Data Control

---

## What You Agree To with Cloud APIs

When you call `api.openai.com`, your data:

- Travels over the internet (encrypted in transit, decrypted at destination)
- May be **retained 30–90 days** for abuse monitoring
- May be **used to improve models** on free/research tiers
- May be accessed by law enforcement with a valid legal demand
- Is processed across **multiple jurisdictions**

**Research contexts where this is a blocker:**
- Medical data (HIPAA, GDPR) — IRB protocols
- Legal / attorney-client privileged documents
- Unpublished results and novel hypotheses
- Corporate partnerships with NDAs

---

## Local Inference as Privacy Insurance

```python
# Cloud API — data leaves your network
response = requests.post("https://api.openai.com/v1/chat/completions",
    json={"messages": [{"role": "user", "content": sensitive_data}]})

# Local Ollama — data stays on localhost
response = requests.post("http://localhost:11434/api/generate",
    json={"model": "llama3.2:3b", "prompt": sensitive_data})
```

**What local inference guarantees:**
- No third-party data transmission
- Complete processing control — audit every step
- Data residency compliance
- Your retention policy, not the provider retention policy

---

<\!-- _class: section-header -->

# 3. Cost and Sustainability

---

## The Economics of Cloud APIs

| Model | Input | Output |
|---|---|---|
| GPT-4o | ~$5 / 1M tokens | ~$15 / 1M tokens |
| Claude 3.5 Sonnet | ~$3 / 1M tokens | ~$15 / 1M tokens |

**At research scale:**
- 1 experiment × 500 tokens × 1,000 runs = **500K tokens**
- A research group running experiments daily → **millions of tokens/month**
- Cloud cost grows linearly with scale

**Local inference costs:**
- Hardware: one-time (hardware you may already own)
- Electricity: ~10–30W during inference
- Marginal cost per token: **effectively zero**

---

## Break-Even and Sustainability

> If you run more than a few hundred API calls per week consistently,
> local infrastructure pays for itself within months.

**Hidden cloud costs often missed:**
- API key management and rate limit handling
- Vendor lock-in migration costs
- Compliance audits for externally processed data

**Environmental note:**
Local CPU inference uses a fraction of datacenter energy at scale.
For large batch workloads, local is often the greener choice.

---

<\!-- _class: section-header -->

# 4. Research Reproducibility

---

## The Reproducibility Problem with Cloud APIs

Cloud model APIs are **moving targets:**

- The model behind `gpt-4` today is not the same as `gpt-4` next month
- Providers update models silently for safety, performance, or cost reasons
- **Exact reproduction of results is impossible** without frozen weights

**Documented instability examples:**
- Classification accuracy shifts of 5–15% between undocumented updates
- Reasoning step counts changing across API versions
- Stylistic drift affecting downstream NLP pipelines

---

## Local Models as Reproducible Artifacts

```bash
# Pin a specific model version — SHA256 of weights is fixed
ollama pull llama3.2:3b
```

```python
# Every experiment saved with full metadata
log_entry = {
    "ts": time.time(),
    "model": "llama3.2:3b",
    "temperature": 0.0,   # deterministic output
    "prompt": prompt,
    "latency_s": latency,
    "output_chars": len(output)
}
# saved to experiments/logs/experiments.jsonl
```

**pin model + temperature=0.0 + log everything = fully reproducible**

---

<\!-- _class: section-header -->

# 5. Latency and Performance

---

## Local CPU Inference: What to Expect

**Typical latency for `llama3.2:3b` on CPU:**

| Prompt length | Latency |
|---|---|
| Short (< 50 tokens) | 2–4 seconds |
| Medium (50–200 tokens) | 4–7 seconds |
| Long (> 200 tokens) | 7–15 seconds |

**Quantization trade-off:**

| Format | RAM needed | Quality loss |
|---|---|---|
| F16 | ~7 GB | None — baseline |
| Q8 | ~4 GB | Negligible |
| Q4 | ~3 GB | Small — recommended |
| Q2 | ~2 GB | Noticeable |

---

## When Local Performance is Sufficient

**Local is well-suited for:**
- Batch annotation and classification (async, no SLA)
- Document summarization pipelines
- RAG retrieval and generation for researchers
- Offline / air-gapped environments

**Consider cloud when:**
- Sub-second response time required (user-facing real-time apps)
- Input context > 32K tokens regularly
- Tasks require frontier model capability
- One-off tasks where setup cost exceeds usage cost

---

<\!-- _class: section-header -->

# 6. RAG Systems
## Bringing It All Together

---

## What is Retrieval-Augmented Generation?

**The problem:** LLMs only know their training data.
They hallucinate on private documents, recent events, domain-specific knowledge.

**RAG = Retrieve + Generate**

```
User query
    |
[1] Embed query → search vector DB → top-k relevant chunks
    |
[2] Prompt: "Answer using this context: {chunks}  Question: {query}"
    |
[3] LLM generates answer grounded in retrieved evidence
```

---

## Local RAG Architecture

```
Documents (PDFs, text, notes)
    |  sentence-transformers (all-MiniLM-L6-v2)
Embeddings (384-dim vectors)
    |  ChromaDB — local vector database
Persistent index on disk

Query → embed → similarity search → context chunks
    |  Ollama (llama3.2:3b)
Grounded answer
```

**Everything runs locally.** No API key. No data transmission. No per-query cost.

---

## RAG for Research: Key Use Cases

| Use case | What RAG enables |
|---|---|
| Literature review | Query thousands of papers semantically |
| Lab protocol management | Ask questions over historical experiments |
| PDF ingestion | Chat with technical documents |
| Clinical notes | Analyze patient records without cloud exposure |

---

## RAG Through the Four Pillars Lens

| Pillar | How local RAG addresses it |
|---|---|
| **Privacy** | Documents never leave your machine |
| **Cost** | Index once, query unlimited times for free |
| **Reproducibility** | Same index + same model = same answers |
| **Performance** | No network round-trips for retrieval |

> Local RAG simultaneously satisfies all four motivations for local AI.

---

<\!-- _class: section-header -->

# 7. Practical Considerations
## When NOT to Use Local LLMs

---

## Honest Limitations

**Do not use local LLMs when:**

- You need **frontier-level reasoning** — 3B/7B models are not GPT-4
- Your task requires **> 32K token context** — local models have shorter windows
- You need **real-time responses** (< 1 second) in a user-facing product
- The task is **one-off** and setup cost outweighs usage cost

**Realistic expectations:**
- A 3B parameter model is a capable intern, not a domain expert
- Q4 quantization loses some nuance on complex reasoning tasks
- CPU inference is slow — design workflows accordingly

---

## Hybrid Architecture: Use Both

| Task type | Recommendation |
|---|---|
| Sensitive data, batch annotation, offline | Local Ollama |
| Complex reasoning, large context, one-off | Cloud API |
| High-volume reproducible research | Local Ollama |
| Frontier capability required | Cloud API |

> The goal is not to replace cloud APIs but to **use each where it fits best.** 

---

<\!-- _class: section-header -->

# 8. The Future of Local AI in Research

---

## Emerging Trends

**Hardware:**
- Consumer NPUs in laptops: 10x inference speedup on the horizon
- Apple Silicon unified memory advantage
- NVIDIA RTX local inference becoming mainstream

**Models:**
- Phi-3 mini, Gemma 2B outperform older 13B models on many tasks
- Speculative decoding: 2–4x throughput improvement
- Mixture-of-Experts: selectively activate model subsets

**Tooling:**
- Ollama, LM Studio, Jan: local inference turnkey
- LangChain, LlamaIndex: RAG frameworks maturing rapidly

---

## Research Opportunities for PhD Students

Areas ripe for investigation:

- **Evaluation methodology:** measuring local model quality for research tasks
- **RAG optimization:** chunking strategies, retrieval, re-ranking
- **Domain-specific fine-tuning:** LoRA on scientific literature with minimal compute
- **Privacy-preserving inference:** differential privacy, federated learning
- **Reproducibility standards:** formalizing LLM experiment reporting for publication
- **Energy efficiency:** measuring the carbon footprint of research inference

---

<\!-- _class: section-header -->

# 9. Key Takeaways

---

## Summary: The Four Pillars

| | Local LLM + RAG | Cloud API |
|---|---|---|
| **Privacy** | Data stays on your machine | Data leaves your environment |
| **Cost** | Fixed hardware, zero marginal cost | Scales linearly with usage |
| **Reproducibility** | Frozen weights, identical outputs | Models updated silently |
| **Performance** | 2–15s latency, no network overhead | Variable, network-dependent |

---

## Decision Framework

**Choose local when:**
- Sensitive data or compliance requirements
- High-volume / repetitive workloads
- Reproducibility is critical for publication
- Offline or air-gapped environment

**Choose cloud when:**
- Frontier capability required
- One-off or exploratory task
- Ultra-low latency required
- Context > 32K tokens regularly

> **Default for research:** start local, move to cloud only when local capability is demonstrably insufficient.

---

## Actionable Next Steps

1. Install Ollama and pull `llama3.2:3b` — 5 minutes
2. Run **notebook 01** — verify local inference on your hardware
3. Run **notebook 03** — build your first local RAG system
4. Run **notebook 04** — benchmark your hardware baseline
5. Apply to your research — identify one task where local inference improves privacy, cost, or reproducibility

---

<\!-- _class: title -->

# Thank You

**Edge LLM Systems Lab**

```bash
ollama pull llama3.2:3b
docker compose up --build
# open http://localhost:8888
```

*Further reading: `slides/Local_LLMs_and_RAG_Research_Article.pdf`*
*Fabio Antonini — 2026*
