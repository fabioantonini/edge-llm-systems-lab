# I Built a Local RAG System in 50 Lines of Python. Here's How.

A few months ago, a colleague asked me to help him build a system that could answer questions about a collection of research papers. "We'll just use the OpenAI API," he said. "It's the easy way."

I asked him two questions.

How many papers are you indexing? About 500, he said. And are any of them unpublished? Yes, quite a few.

We didn't use the OpenAI API.

Instead, I showed him how to build the same thing in about 50 lines of Python — running entirely on his laptop, with no API key, no cost per query, and no data ever leaving his machine. This is what I showed him.

---

## What RAG Actually Is (in One Paragraph)

Language models only know what they were trained on. Ask a local model about your unpublished research, your company's internal documents, or yesterday's clinical notes — and it will either hallucinate or admit it doesn't know.

RAG fixes this. The idea is simple:

1. **Embed** your documents into a vector space
2. When a query arrives, **find the most similar chunks**
3. **Inject those chunks** into the prompt as context
4. The model answers **based on what you retrieved**, not on training data

The result: grounded, verifiable answers. Much less hallucination. And in a local setup — zero cost after the initial setup.

---

## The Three Components You Need

**1. Ollama** — runs the LLM locally (I use `llama3.2:3b`, 2GB download)

**2. sentence-transformers** — converts text to semantic vectors, entirely on CPU

**3. ChromaDB** — local vector database, stores and searches your document embeddings

No cloud dependency. No API key. Everything runs in process.

---

## The Code

```python
import requests
import chromadb
from sentence_transformers import SentenceTransformer

OLLAMA = "http://localhost:11434"
MODEL = "llama3.2:3b"

# 1. Set up embedding model and vector database
embedder = SentenceTransformer('all-MiniLM-L6-v2')
client = chromadb.Client()
collection = client.create_collection("research_docs")

# 2. Index your documents
documents = [
    "Ollama exposes a REST API on port 11434 with /api/generate and /api/chat endpoints.",
    "RAG systems reduce hallucinations by grounding answers in retrieved context.",
    "ChromaDB stores embeddings and supports cosine similarity search.",
    "Quantization reduces model size from ~12GB (float32) to ~1.5GB (int4) with minimal quality loss.",
    "Temperature 0.0 produces deterministic outputs — useful for reproducible research.",
]

embeddings = embedder.encode(documents).tolist()
collection.add(
    ids=[str(i) for i in range(len(documents))],
    documents=documents,
    embeddings=embeddings
)

# 3. Retrieve relevant context for a query
def retrieve(query: str, k: int = 3):
    query_embedding = embedder.encode([query]).tolist()
    results = collection.query(query_embeddings=query_embedding, n_results=k)
    return results["documents"][0]

# 4. Generate a grounded answer
def rag_answer(question: str) -> str:
    context_chunks = retrieve(question)
    context = "\n".join(f"[{i+1}] {chunk}" for i, chunk in enumerate(context_chunks))

    prompt = f"""Answer the question using ONLY the context below.
If the answer is not in the context, say so.

Context:
{context}

Question: {question}
Answer:"""

    response = requests.post(f"{OLLAMA}/api/generate",
        json={"model": MODEL, "prompt": prompt, "stream": False})
    return response.json()["response"]
```

That's it. The full pipeline — indexing, retrieval, generation — in under 50 lines.

---

## What This Actually Looks Like in Practice

```python
answer = rag_answer("What Ollama endpoints are available?")
# → "According to the context, Ollama exposes /api/generate for single-turn
#    generation and /api/chat for multi-turn conversations [1]."
```

The answer is grounded in document [1]. The model isn't guessing — it's reading. This is the core shift RAG enables.

---

## What I've Used This For

After building this pattern, I applied it to real problems:

- Querying a corpus of 200 internal documents without exposing them to any cloud service
- Building a "chat with your papers" interface for a literature review
- Creating a lab protocol assistant that answers questions over historical experiment logs

In each case, the documents stayed local. The cost per query was zero (after the initial setup). The answers were traceable to specific sources.

---

## The Honest Limitations

A few things worth knowing before you build this:

**Chunking matters.** If you embed entire long documents, retrieval degrades. For real deployments, split documents into 256–512 token chunks with overlap. The toy example above works because the documents are already short.

**all-MiniLM-L6-v2 is small.** It produces 384-dimensional vectors and runs well on CPU. For domain-specific tasks (medical, legal, scientific), domain-adapted embedding models often perform significantly better.

**3B models have limits.** They're excellent at extracting and reformulating retrieved context. They struggle with complex multi-step reasoning over that context. For heavy reasoning, you may want a larger model — or occasionally, cloud.

---

## The Setup Is Genuinely Simple

```bash
# Ollama
ollama pull llama3.2:3b

# Python dependencies
pip install sentence-transformers chromadb requests
```

No Docker required (though I use it for reproducibility in my lab). No GPU. Just Python and a 2GB model download.

My colleague indexed his 500 papers that afternoon. The setup took about 20 minutes including the model download. He hasn't paid an API bill for paper queries since.

---

*This is part of a series on local AI infrastructure for researchers. The full code is part of the Edge LLM Systems Lab — an open educational project teaching local LLMs and RAG systems to PhD students and researchers.*

*Next: what the benchmarks actually show after 1,000 experiments on CPU.*

---

**#Python #RAG #LLM #OpenSource #AI #Research #ChromaDB #MachineLearning**
