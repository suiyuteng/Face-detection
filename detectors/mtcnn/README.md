# MTCNN — train + inference

**现有训练和推理代码在 [MTCNN-pytorch/](../../MTCNN-pytorch/) 目录。** 这个目录不移动原源码，只提供统一算法入口。

## 训练

- [train_pnet.py](../../MTCNN-pytorch/train_pnet.py)
- [train_rnet.py](../../MTCNN-pytorch/train_rnet.py)
- [train_onet.py](../../MTCNN-pytorch/train_onet.py)
- [data_gen/](../../MTCNN-pytorch/data_gen/)：训练数据生成
- [data/](../../MTCNN-pytorch/data/)：训练数据加载和增强
- [Nets.py](../../MTCNN-pytorch/Nets.py)：PNet、RNet、ONet 网络定义

三个训练脚本指向 `../dataset/`，但该数据集未被提交。模型训练数据、运行环境和端到端训练命令**尚未复现验证**。

## 推理

- [MTCNN.py](../../MTCNN-pytorch/MTCNN.py)：三级检测和后处理
- [models/](../../MTCNN-pytorch/models/)：PNet/RNet/ONet 三个已提交的 PyTorch `.pkl` 权重

存在推理源码及权重；当前分支尚无统一 I/O 或自动化 smoke test，**不标记已测试**。

## 后续

先核对旧脚本的运行依赖和训练数据格式、单张图检测、训练保存/恢复 checkpoint，确认结果后再考虑统一结构。完整目标规范见 [训练与推理](../../docs/TRAINING_INFERENCE.md)。
