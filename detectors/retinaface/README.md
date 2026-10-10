# RetinaFace — train + inference + export

**当前状态：本地发现了推理、转换和权重候选，但尚未找到、迁入或运行完整训练代码。** 请不要将该目录误认为训练/推理均已恢复的工程。

## 本地文件盘点

在 2026-10-10 的 `retinaface_files.csv` 中共 **55** 条文件记录，来自三个本地来源组：

| 来源组 | 数量 | 已发现的角色 |
|---|---:|---|
| `onnx_models` | 3 | MNet025 两份 ONNX + R50 ONNX 候选，**只有权重** |
| `legacy_retinaface` | 41 | Caffe 权重/结构，C++ 推理，MXNet→Caffe 格式转换，INT8 校准 |
| `tensorrtx_retinaface` | 11 | MNet/R50 TRT 构建与推理、解码、标定、构建文件 |

完整的**不含私有绝对路径**文件清单：[catalog/retinaface_snapshot.csv](../../catalog/retinaface_snapshot.csv)。

## 源码功能分类

| 环节 | 线索 | 状态 |
|---|---|---|
| 模型结构与训练 | 历史源码中有 `MXNet2Caffe/model_mxnet/mnet.25-symbol.json` | 网络结构线索，**并非训练实现** |
| Train | 目标扫描目录内无明确的 `train.py` 和训练配置 | **缺失或尚未定位** |
| Inference | `retinaface/RetinaFace.cpp`、`retinaface/tensorrt/trtretinafacenet.cpp` | 本地源码，**未迁入** |
| Inference (TRT) | `retina_mnet.cpp`、`retina_r50.cpp`、`decode.h` | 本地源码，**未迁入** |
| Export / conversion | `MXNet2Caffe/`、`INT8-Calibration-Tool/` | 本地工具，**非训练** |
| ONNX weights | MNet025 v1 / gamma-v2、R50 | 本地模型文件，**未验证导出来源** |

## 本地权重候选

| 版本 | 文件名 | 大小（近似） |
|---|---|---:|
| RetinaFace MNet025 v1 | `mnet025_v1.onnx` | 1.97 MB |
| RetinaFace MNet025 gamma-v2 | `mnet025_fix_gamma_v2.onnx` | 1.97 MB |
| RetinaFace R50 | `R50_onnx.onnx` | 112.59 MB |
| RetinaFace MNet25 Caffe | `mnet25.caffemodel` + `mnet25.prototxt` | 1.69 MB |
| RetinaFace MNet deconv0517 | `mnet-deconv-0517.caffemodel` + `mnet-deconv-0517.prototxt` | 1.69 MB |

**五份权重不一定对应五个训练版本。** 与哪个训练检查点配套、是否只是导出或图优化，需要通过结构、哈希和数值对照判断。

## 目标布局（尚未实现）

```text
detectors/retinaface/
  README.md            # 当前唯一已提交的该家族文件
  train/               # 训练入口、损失、数据集、配置（待源代码）
  configs/             # 训练和推理配置（待核对）
  inference/
    pytorch/           # 如找到 PyTorch 训练源则复用
    onnx/              # ONNX Runtime 推理
    caffe/             # Caffe/OpenCV DNN 推理
    tensorrt/          # TensorRT 推理构建
  export/              # MXNet/Caffe/ONNX 导出和转换
  tests/               # 单张图片、数值校验、bbox/landmarks
  models/manifest.csv  # 模型来源和校验和，而非默认提交大权重
```

该布局是迁移规范；不创建空壳实现，不在检查第三方许可之前拷贝已有历史项目。参考 [训练+推理统一规范](../../docs/TRAINING_INFERENCE.md) 和 [RetinaFace 迁移检查](../../docs/RETINAFACE_REVIEW.md)。

未核验：R50 内部网络结构、五点输出、不同 MNet 的训练身份、依赖版本、训练源码位置、许可、输入归一化和 NMS、实际运行速度/准确率。
