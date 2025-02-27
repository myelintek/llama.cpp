#!/bin/bash

# Model variants to test
# ~/.cache/llama.cpp/DeepSeek-R1-1.5B_Q4_K_M.gguf
# -m ~/DeepSeek-R1-GGUF/DeepSeek-R1-Q8_0/DeepSeek-R1.Q8_0-00001-of-00015.gguf

# Model variants to test
# DeepSeek-R1-1.5B_Q8_0
# DeepSeek-R1-8B_Q8_0
# DeepSeek-R1-14B_Q8_0
# Llama-3.2-1B-Instruct_Q8_0
# Llama-3.2-3B-Instruct_Q8_0

MODEL_VARIANTS=("DeepSeek-R1-1.5B_Q4_K_M" "DeepSeek-R1-1.5B_Q8_0" "DeepSeek-R1-8B_Q8_0" "DeepSeek-R1-14B_Q8_0" "Llama-3.2-1B-Instruct_Q8_0" "Llama-3.2-3B-Instruct_Q8_0")

# Base model name
# BASE_MODEL="DeepSeek-R1-1.5B"
# BASE_MODEL="DeepSeek-R1"

# Benchmark parameters
PROMPT_TOKENS="512,1024"
NEW_TOKENS="128,256"
THREADS="64,128"
DELAY=0
REPEAT=50
MMAP=0
CPU_STRICT="1"
DATE=$(date +"%Y%m%d_%H%M")

# Run benchmark for each model variant
for variant in "${MODEL_VARIANTS[@]}"; do
    MODEL_NAME="${variant}"
    OUTPUT_FILE="./records/SMT_1DPC_4800Mhz_newFans/${MODEL_NAME}-host-4800Mhz-${DATE}.record"

    {
        echo "./build/bin/llama-bench -m ~/.cache/llama.cpp/${MODEL_NAME}.gguf \
            -p ${PROMPT_TOKENS} \
            -n ${NEW_TOKENS} \
            -t ${THREADS} \
            --delay ${DELAY} \
            -r ${REPEAT} \
            --cpu-strict ${CPU_STRICT} \
            --mmap ${MMAP}"

	echo "begin"
	date

        ./build/bin/llama-bench -m ~/.cache/llama.cpp/${MODEL_NAME}.gguf \
            -p ${PROMPT_TOKENS} \
            -n ${NEW_TOKENS} \
            -t ${THREADS} \
            --delay ${DELAY} \
            -r ${REPEAT} \
            --cpu-strict ${CPU_STRICT} \
            --mmap ${MMAP}
	date
       echo "end"
    } 2>&1 | tee ${OUTPUT_FILE}
done
date +"%Y%m%d_%H%M"
