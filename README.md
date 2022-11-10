# Instructions

## BART 

The BART model was taken and modified from [Katsumata420/generic-pretrained-GEC/BART-GEC](https://github.com/Katsumata420/generic-pretrained-GEC/tree/master/BART-GEC)

### Preparation

Change working directory to `BART-GEC` and perform the following steps:

1. Download pretrained BART model (`bart.large.tar.gz`) and related files (`encoder.json`, `vocab.bpe` and `dict.txt`).
    - `bart.large.tar.gz`: [url](https://dl.fbaipublicfiles.com/fairseq/models/bart.large.tar.gz)
    - `encoder.json`: [url](https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/encoder.json)
    - `vocab.bpe`: [url](https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/vocab.bpe)
    - `dict.txt`: [url](https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/dict.txt)
2. Apply BART BPE to the train/valid data by running `apply_bpe.sh`.
3. Binarize train/valid data by running `preprocess.sh`.

### Training

Fine-tune the BART model with binarized data by running `train.sh`.

### Data Translation

Generate the output for the BEA-2019 and CoNLL-2014 test data by running `translate.sh [input] [output_dir] [gpu] [model_dir]`. The output generated from our trained BART model is included in the `data` folder.


## BERT-fuse GED

The BERT model was taken and modified from [kanekomasahiro/bert-gec](https://github.com/kanekomasahiro/bert-gec)

### Requirements
python >= 3.5, torch == 1.1.0, [bert-nmt](https://github.com/bert-nmt/bert-nmt), [subword](https://github.com/rsennrich/subword-nmt), [gec-pseudodata](https://github.com/butsugiri/gec-pseudodata)

### Preparation

Change working directory to `bert-gec/scripts` and perform the following steps:

1. Run `setup.sh`.
2. Run `get_model.py` to download bert-base-cased model. (Note: we added a script to load the pretrained BERT model from huggingface instead of from the `setup.sh` script as the original links are broken.)

### Training

Fine-tune the BERT model by running `train.sh`.

### Data Translation

Generate the output for the BEA-2019 and CoNLL-2014 test data by running `generate.sh [input] [output_dir] [gpu]`. The output generated from our trained BERT model is included in the `data` folder.


## System Combination (ESC)

The system combination method was taken and modified from [nusnlp/esc](https://github.com/nusnlp/esc)

### Preparation

1. Create a new experiment directory under `esc-main` and go inside it.
2. Create a `dev-text` folder and put the base model's output on the dev data into the folder, along with the corresponding `source.txt` and `target.txt`.
3. Create a `test-text` folder and put the base model's output on the test data into the folder, along with the corresponding `source.txt` and `target.txt`.
4. Create a `models` and a `output` folder.

The output that we generated for both BART and BERT models are included in the `data/output` folder 

### Training

