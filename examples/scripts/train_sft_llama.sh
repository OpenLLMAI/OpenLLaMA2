set -x

read -r -d '' training_commands <<EOF
../train_sft.py \
    --max_len 2048 \
    --dataset Open-Orca/OpenOrca \
    --dataset_probs 1.0 \
    --train_batch_size 128 \
    --micro_train_batch_size 1 \
    --max_samples 500000 \
    --pretrain meta-llama/Llama-2-7b-hf \
    --save_path ./ckpt/7b_llama \
    --zero_stage 2 \
    --max_epochs 1 \
    --bf16 \
    --learning_rate 5e-6 \
    --gradient_checkpointing \
    --flash_attn
EOF
    # --wandb [WANDB_TOKENS]

if [[ ${1} != "slurm" ]]; then
    export PATH=$HOME/.local/bin/:$PATH
    deepspeed $training_commands
fi