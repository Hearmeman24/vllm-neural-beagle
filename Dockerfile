# Use multi-stage build with caching optimizations
FROM runpod/worker-v1-vllm:v2.5.0stable-cuda12.1.0 AS base

# Consolidated environment variables
ENV DEBIAN_FRONTEND=noninteractive \
   PIP_PREFER_BINARY=1 \
   PYTHONUNBUFFERED=1 \
   CMAKE_BUILD_PARALLEL_LEVEL=8


FROM base AS final
# 2) Install the HF Hub client for snapshot-download
RUN pip install --no-cache-dir huggingface-hub

# 3) Download the open model into /models/
RUN huggingface-cli snapshot-download \
      LoneStriker/NeuralBeagle14-7B-8.0bpw-h8-exl2 \
      --local-dir /models/NeuralBeagle14-7B-8.0bpw-h8-exl2