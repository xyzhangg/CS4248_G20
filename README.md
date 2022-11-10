# Instructions

## BART 

The BART model is adapted from [Katsumata420/generic-pretrained-GEC/BART-GEC](https://github.com/Katsumata420/generic-pretrained-GEC/tree/master/BART-GEC).

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

Fine-tune the BART model with binarized data by running `train.sh`. Our trained BART model can be downloaded from this [link](https://drive.google.com/file/d/1fg80NjpbNcMrpQcInw-7DUn4z4N0CqiU/view?usp=sharing).

### Data Translation

Generate the output for the BEA-2019 and CoNLL-2014 test data by running `translate.sh [input] [output_dir] [gpu] [model_dir]`. The output generated from our trained BART model is included in the `data` folder.


## BERT-fuse GED

The BERT model is adapted from [kanekomasahiro/bert-gec](https://github.com/kanekomasahiro/bert-gec).

### Requirements
python >= 3.5, torch == 1.1.0, [bert-nmt](https://github.com/bert-nmt/bert-nmt), [subword](https://github.com/rsennrich/subword-nmt), [gec-pseudodata](https://github.com/butsugiri/gec-pseudodata)

### Preparation

Change working directory to `bert-gec/scripts` and perform the following steps:

1. Run `setup.sh`.
2. Run `get_model.py` to download bert-base-cased model. (Note: we added a script to load the pretrained BERT model from huggingface instead of from the `setup.sh` script as the original links are broken.)

### Training

Fine-tune the BERT model by running `train.sh`. Our trained BERT model can be downloaded from this [link](https://drive.google.com/file/d/13UOliqDNL0rE94mRcX6bXjZga7eBXzOT/view?usp=sharing).

### Data Translation

Generate the output for the BEA-2019 and CoNLL-2014 test data by running `generate.sh [input] [output_dir] [gpu]`. The output generated from our trained BERT model is included in the `data` folder.


## System Combination (ESC)

The system combination method is adapted from [nusnlp/esc](https://github.com/nusnlp/esc).

### Requirements
Refer [here](https://github.com/nusnlp/esc#installation) for instructions on installation and requirements.

### Reproducing our results
For the BEA-2019 experiment, the my-bea-exp folder also contains the best-performing trained models, as mentioned in our paper, in the models folder and the respective outputs in outputs/[model description].out.
Get the F0.5 score for BEA-2019 by submitting the desired output file in a zip to CodaLab.

For the CoNLL-2014 experiment, the my-conll-exp folder also contains the best-performing trained models, as mentioned in our paper, in the models folder and the respective outputs in outputs/[model description].out.
Get the F0.5 score for CoNLL-2014 using M2 scorer with the desired output file.

### Our trained models and outputs:
* base5_bart_conll.pt and base5_bart_conll.out: Model and output for ESC trained on the 5 base models included and BART
* base5_bart_pytorchLR_conll.pt and base5_bart_pytorchLR_conll.out: Model and output for ESC trained on the 5 base models included and BART, along with PyTorch's learning rate decay with gamma=0.98
* base5_bart_selfimplementedLR_conll.pt and base5_bart_selfimplementedLR_conll.out: Model and output for ESC trained on the 5 base models included and BART, along with our own learning rate decay and early stop implementation
* base6_bert_pytorchLR_bea.pt and base6_bert_pytorchLR_bea.out: Model and output for ESC trained on the 6 base models included and BERT, along with PyTorch's learning rate decay with gamma=0.99
* base6_bert_bea.pt and base6_bert_bea.out: Model and output for ESC trained on the 6 base models included and BERT, along with our own learning rate decay and early stop implementation

### Retraining the experiments in the paper
Run `export EXP_DIR=my-bea-exp` and `export EXP_DIR=my-conll-exp` for the BEA-2019 and CoNLL-2014 experiments respectively.
1. Run the training by running `python run.py --train --data_dir $EXP_DIR/dev-text --m2_dir $EXP_DIR/dev-m2 --model_path $EXP_DIR/models --vocab_path $EXP_DIR/vocab.idx`.
2. Get the prediction on the BEA-2019 development dataset by running `python run.py --test --data_dir $EXP_DIR/dev-text --m2_dir $EXP_DIR/dev-m2 --model_path $EXP_DIR/models/[model description].pt --vocab_path $EXP_DIR/vocab.idx --output_path $EXP_DIR/outputs/dev.out`.
3. Get the F0.5 development score by running `errant_parallel -ori $EXP_DIR/dev-text/source.txt -cor $EXP_DIR/outputs/dev.out -out $EXP_DIR/outputs/dev.m2` followed by `errant_compare -ref bea-full-valid.m2 -hyp $EXP_DIR/outputs/dev.m2`.
4. Get the test prediction by running `python run.py --test --data_dir $EXP_DIR/test-text --m2_dir $EXP_DIR/test-m2 --model_path $EXP_DIR/models/model.pt --vocab_path $EXP_DIR/vocab.idx --output_path $EXP_DIR/outputs/test.out`.
