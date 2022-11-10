fairseq-preprocess \
  --source-lang "src" \
  --target-lang "tgt" \
  --trainpref "./bpe" \
  --validpref "./bpe" \
  --destdir "gec_data-bin/" \
  --workers 10 \
  --srcdict dict.txt \
  --tgtdict dict.txt;
