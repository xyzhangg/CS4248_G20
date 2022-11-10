import torch

model = torch.hub.load('huggingface/pytorch-transformers', 'model', 'bert-base-cased')

model.save_pretrained('../bert-base-cased')