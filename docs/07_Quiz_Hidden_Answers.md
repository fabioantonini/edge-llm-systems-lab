# Notebook 07 - Quiz with Hidden Answers

**File:** `notebooks/07_Quiz_Hidden_Answers.ipynb`

## Objective

Assess students' understanding through 20 open-ended questions on the lab topics, with answers hidden using HTML `<details>` tags (expandable by clicking). Includes a practical bonus task at the end.

## Topics covered

- Ollama: installation, ports, API endpoints
- Local inference vs cloud
- Model quantization
- Latency and profiling
- RAG (Retrieval-Augmented Generation)
- Embeddings and vector databases
- Prompt engineering
- Docker networking

## Structure

The notebook contains **20 questions** + 1 **practical Bonus Task**.
Each question has a hidden answer that expands by clicking "Answer".

## Question summary

| # | Question | Topic |
|---|----------|-------|
| 1 | What problem does Ollama solve compared to cloud LLM APIs? | Ollama basics |
| 2 | Which default port does the Ollama server use? | Configuration |
| 3 | Difference between `/api/generate` and `/api/chat`? | API |
| 4 | Why are quantized models useful for CPU inference? | Quantization |
| 5 | What is local inference latency and why should students measure it? | Benchmarking |
| 6 | Name two CPU-friendly model families for Ollama | Models |
| 7 | Minimum information needed for a `/api/generate` request? | API |
| 8 | What does the `temperature` parameter control? | Generation |
| 9 | What is RAG in one sentence? | RAG |
| 10 | Why use a vector database in RAG? | RAG |
| 11 | What is an embedding in the RAG context? | Embeddings |
| 12 | What goes wrong if you embed huge documents without chunking? | RAG |
| 13 | Why instruct the LLM to answer ONLY from the provided context? | Prompt engineering |
| 14 | Why use `http://ollama:11434` instead of `localhost` in Docker Compose? | Docker |
| 15 | One reason to prefer local LLMs in an industrial setting? | Use cases |
| 16 | Main limitation of running large LLMs on CPU? | Hardware |
| 17 | How can you observe CPU/RAM usage during inference? | Profiling |
| 18 | A simple baseline retrieval method that does not require neural embeddings? | Alternative RAG |
| 19 | Why might outputs differ across runs with the same prompt? | Stochasticity |
| 20 | How to safely teach prompt engineering in this lab? | Teaching |

## Practical Bonus Task

Students must:
1. Pull a small model (e.g. `llama3.2:3b`)
2. Write a Python function that calls `/api/generate`
3. Measure latency for 3 prompts
4. Change `temperature` and compare outputs

## Suggested teaching uses

- Use as a **final assessment** after completing notebooks 01-06
- Assign as an **individual quiz** (students do not expand answers until they have tried)
- Use the questions as a starting point for **group discussion** in class
- The Bonus Task can be assigned as a **mini-project** to submit
