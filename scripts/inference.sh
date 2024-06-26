#!/bin/bash

# 変数の定義
CUDA_DEVICE=2
CKPT="logs/CACD_2_2024-06-12T11-12-59_v1.5_biom/checkpoints/last.ckpt"
BASE_OUTDIR="experiment/CACD_2"

CONFIG="configs/stable-diffusion/v1-inference.yaml"
SCALE=10.0
STEPS=100
NSAMPLES=8
NITER=1
ETA=0.0

# 年齢のリスト
AGES=("child" "teenager" "youngadults" "middleaged" "elderly" "old")

# ループを使って各年齢についてコマンドを実行
for AGE in "${AGES[@]}"; do
  OUTDIR="${BASE_OUTDIR}/${AGE}"
  
  # ディレクトリが存在しない場合は作成
  mkdir -p $OUTDIR
  
  CUDA_VISIBLE_DEVICES=$CUDA_DEVICE python scripts/stable_txt2img.py \
    --ddim_eta $ETA \
    --n_samples $NSAMPLES \
    --n_iter $NITER \
    --scale $SCALE \
    --ddim_steps $STEPS \
    --ckpt $CKPT \
    --prompt "photo of a sks person as $AGE" \
    --outdir $OUTDIR \
    --config $CONFIG
done
