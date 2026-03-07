# Notebook 05 - Quantization Analysis

**File:** `notebooks/05_Quantization_Analysis.ipynb`

## Objective

Introduce the concept of **model quantization** and build a systematic benchmarking protocol to measure latency variability across different models and variants on CPU.

## What students will learn

- What quantizing a model means (precision reduction from float32 to 4-bit/8-bit)
- How to design a reproducible benchmarking experiment
- How to run N repetitions per prompt and compute reliable statistics (mean, min, max)
- How to save results in JSONL format for later analysis
- The importance of **measurement discipline** in research

## Notebook structure

| Section | Content |
|---------|---------|
| Configuration | Define models, prompts, and number of runs |
| `bench()` function | Loop over prompts x N_RUNS, collect latencies per model |
| Save results | Output to `experiments/results/quantization_bench.jsonl` |

## Experiment setup

```python
PROMPTS = [
  'Explain attention in transformers in 6 sentences.',
  'Summarize gradient descent in 5 bullet points.',
  'Write a Python function to compute factorial.'
]
MODELS = ['llama3.2:3b']   # extendable with gemma:2b, phi, etc.
N_RUNS = 3                  # repetitions for statistical estimation
```

## Output format (JSONL)

Each line in `quantization_bench.jsonl` contains:

```json
{
  "model": "llama3.2:3b",
  "prompt": "Explain attention in transformers in 6 sentences.",
  "n_runs": 3,
  "lat_mean_s": 5.23,
  "lat_min_s": 4.89,
  "lat_max_s": 5.71
}
```

## Quantization concept

| Precision | Typical size (3B model) | Notes |
|-----------|------------------------|-------|
| float32 (full) | ~12 GB | Not practical on CPU |
| int8 (8-bit) | ~3 GB | Good trade-off |
| int4 (4-bit) | ~1.5 GB | Great for CPU, slight quality loss |

With Ollama, variants like `llama3.2:3b` vs `llama3.2:3b-q4` can be compared (if available).

## Suggested extensions

- Add more models to the `MODELS` list (e.g. `gemma:2b`, `phi`)
- Increase `N_RUNS` to 5 or 10 for more stable estimates
- Compute tokens/second as an additional metric
- Analyze results with notebook `06` or with `experiments/analysis_scripts/log_utils.py`

## Output file

Results are saved to:
```
experiments/results/quantization_bench.jsonl
```
