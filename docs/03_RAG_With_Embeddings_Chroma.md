# Notebook 03 - RAG with Embeddings and ChromaDB

**File:** `notebooks/03_RAG_With_Embeddings_Chroma.ipynb`

## Objective

Build a **fully local RAG (Retrieval-Augmented Generation) pipeline**: CPU embeddings, local vector database, local LLM. No data leaves the machine.

## What students will learn

- What RAG is and why it is useful for answering questions on specific documents
- How to generate text embeddings with `sentence-transformers` (entirely on CPU)
- How to index documents in ChromaDB (local vector database)
- How to perform semantic similarity search (top-k retrieval)
- How to build a RAG prompt that includes the retrieved context
- How the LLM responds based only on the provided documents

## Pipeline architecture

```
User query
    |
    v
[Query embedding]      <-- sentence-transformers/all-MiniLM-L6-v2
    |
    v
[Similarity search]    <-- ChromaDB (cosine distance)
    |
    v
[Top-k documents]
    |
    v
[RAG prompt]           <-- context + question
    |
    v
[Ollama LLM]           <-- llama3.2:3b
    |
    v
Grounded answer
```

## Notebook structure

| Section | Content |
|---------|---------|
| 1) Health check | Verify Ollama connection |
| 2) Import libraries | `chromadb`, `sentence_transformers` |
| 3) Knowledge base | 5 sample documents on Ollama, RAG, quantization, ChromaDB |
| 4) Create embeddings | Encoding with `all-MiniLM-L6-v2` (384-dimensional vectors) |
| 5) ChromaDB indexing | Store ids, texts, metadata, and embeddings |
| 6) Retrieval function | `retrieve(query, k=3)` with similarity search |
| 7) RAG answer | `rag_answer(question)` combining retrieval + generation |
| 8) Mini-lab | Free questions to test |
| 9) Extensions | Ideas for chunking, re-ranking, persistence |

## Technologies used

| Component | Library/Tool |
|-----------|-------------|
| LLM | Ollama (`llama3.2:3b`) |
| Embeddings | `sentence-transformers` (`all-MiniLM-L6-v2`) |
| Vector DB | ChromaDB (in-memory) |
| HTTP client | `requests` |

## RAG query example

```python
answer, hits = rag_answer("Which Ollama endpoints are available for chat and generation?")
# Output: "According to the context, /api/chat for multi-turn and /api/generate for single-turn [2]"
```

## Key concepts

- **Embedding**: vector representation of text in a semantic space (384 dimensions with MiniLM)
- **Cosine similarity**: measures how semantically close two vectors are
- **Grounding**: the LLM answers based ONLY on retrieved context, reducing hallucinations
- **Chunking**: splitting long documents into smaller pieces (suggested extension)

## Technical prerequisites

```bash
pip install chromadb sentence-transformers
# Already included in the lab's Docker image
```
