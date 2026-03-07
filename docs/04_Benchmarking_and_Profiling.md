# Notebook 04 - Benchmarking and Profiling

**File:** `notebooks/04_Benchmarking_and_Profiling.ipynb`

## Objective

Learn how to measure and profile local CPU inference performance: latency, CPU and RAM usage, and the effect of temperature on output variability.

## What students will learn

- How to define a representative benchmark set of prompts
- How to measure inference latency using `time.time()`
- How to compute latency statistics (min, max, mean) with `statistics`
- How to monitor CPU% and RAM usage with `psutil`
- How to observe the effect of the `temperature` parameter on output variability

## Notebook structure

| Section | Content |
|---------|---------|
| 1) Benchmark set | 3 representative prompts (explanation, code, summarization) |
| 2) Latency measurement | Loop over prompts with stopwatch, collect latencies |
| 3) System usage | CPU% and RAM snapshot with `psutil` |
| 4) Temperature effect | Same question with `temperature` = 0.2, 0.7, 1.2 |

## Benchmark prompts used

```python
prompts = [
    "Explain overfitting in 3 bullet points.",
    "Write a Python function that computes prime numbers up to N.",
    "Summarize the idea of attention in transformers in 5 sentences."
]
```

## Metrics collected

| Metric | Tool | Description |
|--------|------|-------------|
| Latency (s) | `time.time()` | Time from prompt to full output |
| CPU% | `psutil.cpu_percent()` | CPU usage percentage during inference |
| RAM used (GB) | `psutil.virtual_memory()` | Occupied RAM |
| Output variability | visual comparison | Output differences as temperature changes |

## Typical expected values (llama3.2:3b on CPU)

| Prompt type | Typical latency |
|-------------|----------------|
| Short (<50 tokens) | 2-4 seconds |
| Medium (50-200 tokens) | 4-7 seconds |
| Long (>200 tokens) | 7-15 seconds |

## Effect of temperature

- **`temperature=0.2`**: deterministic, precise, repeatable output
- **`temperature=0.7`**: good balance between creativity and coherence
- **`temperature=1.2`**: more creative and variable output, less predictable

## Technical prerequisites

```python
import psutil      # pip install psutil (already included in Docker image)
import statistics  # Python standard library
import time        # Python standard library
```

## Suggested student experiments

- Compare latencies across different models (if available)
- Repeat the same prompt N times and compute the standard deviation of latency
- Observe how RAM usage changes during model loading
