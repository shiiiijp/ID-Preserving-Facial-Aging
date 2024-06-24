#!/bin/bash

# 変数の定義
CUDA_DEVICE=3
CKPT="logs/SubID_0001_NumImages_292024-06-05T16-11-01_v1.5_cont/checkpoints/last.ckpt"
BASE_OUTDIR="experiment/SubID_0001_cont_v1.4"

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
