# Notebook 06 - Research Experiment Harness

**File:** `notebooks/06_Research_Experiments.ipynb`

## Objective

Build a minimal **experiment harness** that runs a grid search over models, temperatures, and prompts, logging each result to a JSONL file with timestamps. This is the foundational pattern for conducting reproducible experiments with LLMs.

## What students will learn

- How to structure an experiment as a grid search over multiple variables (model x temperature x prompt)
- How to record each run with complete metadata (timestamp, parameters, latency, output length)
- JSONL format as the standard for experiment logs
- How to read and analyze logs with `log_utils.py`

## Notebook structure

| Section | Content |
|---------|---------|
| `run()` function | Single inference with automatic latency and metadata collection |
| Grid search | Triple loop over `MODELS x TEMPS x PROMPTS` |
| Save logs | Append to `experiments/logs/experiments.jsonl` |

## Experiment grid

```python
MODELS = ['llama3.2:3b']
TEMPS  = [0.0, 0.2, 0.8]
PROMPTS = [
  'Explain RAG in a systems perspective.',
  'Give a short comparison: local inference vs cloud inference.',
  'Write pseudocode for SGD.'
]
# Total: 1 x 3 x 3 = 9 runs
```

## JSONL log schema

Each line in `experiments.jsonl` contains:

```json
{
  "ts": 1772715847.65,
  "model": "llama3.2:3b",
  "temperature": 0.0,
  "prompt": "Explain RAG in a systems perspective.",
  "latency_s": 6.55,
  "output_chars": 3285
}
```

| Field | Type | Description |
|-------|------|-------------|
| `ts` | float | Unix timestamp of the run |
| `model` | str | Ollama model name |
| `temperature` | float | Sampling parameter |
| `prompt` | str | Prompt text |
| `latency_s` | float | Inference latency in seconds |
| `output_chars` | int | Output length in characters |

## Output file

```
experiments/logs/experiments.jsonl
```

## Analyzing results

Logs can be analyzed with:
```python
# experiments/analysis_scripts/log_utils.py
```

Or directly in Python:
```python
import json

with open('../experiments/logs/experiments.jsonl') as f:
    runs = [json.loads(line) for line in f]

# Mean latency per temperature
for t in [0.0, 0.2, 0.8]:
    lats = [r['latency_s'] for r in runs if r['temperature'] == t]
    print(f"temp={t}: mean latency = {sum(lats)/len(lats):.2f}s")
```

## Scientific best practices applied

- **Timestamp**: every run has a Unix timestamp for traceability
- **Complete parameters**: all relevant parameters are recorded
- **Open format**: JSONL is readable from any programming language
- **Append-only**: logs are never overwritten, only extended
