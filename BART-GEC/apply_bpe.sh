for SPLIT in train valid
do
  for LANG in src tgt
  do
      python -m examples.roberta.multiprocessing_bpe_encoder \
          --encoder-json encoder.json \
          --vocab-bpe vocab.bpe \
          --inputs "../data/$SPLIT/$SPLIT.$LANG" \
          --outputs "./bpe/$SPLIT.bpe.$LANG" \
          --workers 10 \
          --keep-empty;
    done
done

