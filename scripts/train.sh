#!/bin/bash

# 変数の定義
CUDA_DEVICE=1
VERSION="v1.5"
LOSS="cont"
DATA_ROOT="/mnt/npalfs01disk/users/itohlee/dataset/CACD/ID/CACD_2"
REG_DATA_ROOT="dataset/regularization/CelebA_regularization_NEW"

# バージョンに基づいて変数を設定
if [ "$VERSION" = "v1.4" ]; then
  RESUME="pretrained_models/sd-v1-4-full-ema.ckpt"
elif [ "$VERSION" = "v1.5" ]; then
  RESUME="pretrained_models/v1-5-pruned.ckpt"
else
  echo "Unsupported version: $VERSION"
  exit 1
fi

# LOSS に基づいて変数を設定
if [ "$LOSS" = "biom" ]; then
  CONFIG="configs/stable-diffusion/v1-finetune_biomloss.yaml"
elif [ "$LOSS" = "cont" ]; then
  CONFIG="configs/stable-diffusion/v1-finetune_contrastiveloss.yaml"
else
  echo "Unsupported loss: $LOSS"
  exit 1
fi

# NAME="${VERSION}_${LOSS}"
NAME="v1.5_cont"
GPUS="0,"
CLASS_WORD="person"
NO_TEST="--no-test"

# コマンドの実行
CUDA_VISIBLE_DEVICES=$CUDA_DEVICE python main.py \
  --base $CONFIG \
  -t \
  --actual_resume $RESUME \
  -n $NAME \
  --gpus $GPUS \
  --data_root $DATA_ROOT \
  --reg_data_root $REG_DATA_ROOT \
  --class_word $CLASS_WORD \
  $NO_TEST
