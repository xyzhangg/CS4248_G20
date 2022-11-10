INPUT=$1
OUT=$2
GPU=$3
model=$4

mkdir -p $OUT

CUDA_VISIBLE_DEVICES=$GPU python translate.py \
  $model \
  $INPUT \
  $OUT
