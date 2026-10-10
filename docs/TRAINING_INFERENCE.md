# 训练 + 推理一体化规范

项目目标：研究和保留各类人脸检测模型从**数据准备 → 训练 → 验证 → 导出 → 推理 → 性能评测**的完整过程，而不是仅保存可执行推理或各格式权重。

## 单个检测器的目标目录（只有具备真实内容后才创建）

```text
detectors/<family>/
  README.md             # 功能、来源/许可、现状、训练/推理命令
  train/
    train.py             # 实际存在的训练入口（如支持训练）
    datasets.py          # 数据集适配（也可以共用 datasets/）
    losses.py            # 损失函数实现（如适用）
  configs/
    train.yaml           # 模型、数据、优化器、调度器、种子
    infer.yaml           # 预处理、阈值、NMS、输入大小
  inference/
    pytorch/             # PyTorch 推理
    onnx/                # ONNX Runtime/OpenCV DNN
    caffe/               # Caffe/OpenCV DNN
    tensorrt/            # TensorRT 推理；需注明平台和插件
  export/
    export_onnx.py       # 从有权访问的训练检查点导出
    validate_export.py   # 比对框/分数/关键点与误差
  tests/
    test_preprocess.py
    test_decode.py
  models/
    manifest.csv         # 元数据，非大权重默认仓库目录
```

这是**接口和组织约定**，不是当前仓库的真实文件树；如果没有训练实现，不应创建空的 `train.py` 来伪装完成。

## 训练需要满足的最低要求

- 列出模型原始论文/代码仓库、版本、许可证、修改及使用限制；
- 列出数据来源、标注格式、训练/验证拆分、预处理与增强策略；**不将人脸原图上传到公有仓库**；
- 保存网络定义、loss、优化器、学习率、batch、epoch/iteration、随机种子、checkpoint 及断点恢复步骤；
- 明确输入尺寸、框坐标和五点关键点的监督方式（无关键点标签时应说明）；
- 提供一次可复现的小规模验证和完整训练命令（只有实际运行验证后才能标记为完成）。

## 推理与导出需要满足的最低要求

- 能单张图片加载并输出 `boxes_xyxy`、`scores`、可选 `landmarks5`；
- 记录颜色通道、mean/std、resize、anchor、置信阈值、NMS、输出排序；
- 分别标记是否具备 PyTorch、Caffe/OpenCV、ONNX Runtime、NCNN、TensorRT 的真实实现；
- 导出版本应记录来源训练 checkpoint 的 SHA256、导出命令和输入输出一致性测试；
- TensorRT Engine/Cache 不等于可移植模型权重，应记录 CUDA/TRT/GPU/插件环境。

## 训练代码与转换、部署代码的区别

- 有 `train.py` 不代表可复现：还需数据、配置、依赖和实测记录。
- `MXNet2Caffe`、ONNX 导出、INT8 Calibration 是**模型转换/部署准备**，不是训练入口。
- `retina_mnet.cpp`、`retina_r50.cpp` 等 TensorRTx 代码主要负责**模型构建与推理**，不等于网络训练实现。
- 私有 SDK 的加密模型权重没有训练源码时，只能登记为**推理/封装模型**，不可冒充训练+推理完整工程。

## MTCNN 现状及迁移顺序

目前旧版 `MTCNN-pytorch/` 已有：

- 训练：`train_pnet.py`、`train_rnet.py`、`train_onet.py`；
- 数据生成：`data_gen/`、`data/`；
- 结构：`Nets.py`；
- 推理：`MTCNN.py`；
- 三阶段权重：`models/*.pkl`。

训练脚本引用本仓库未包含的 `../dataset/`，因此**只能确认源码存在，尚不能宣称现在开箱即跑通完整训练链路**。第一阶段应先梳理数据集/依赖、独立安装环境、smoke test，再考虑移动目录。

## 优先级

1. **MTCNN**：先把原有训练+推理验证成基准；保留历史路径。
2. **RetinaFace**：检查是否有对应的训练源；若本地仅有 Caffe/TensorRT/ONNX 推理与转换代码，先做来源/许可追溯、补齐训练实现计划，而不是伪造。
3. **CenterFace、UltraFace、YOLOv5-Face**：逐个迁入可复现训练和推理流程，验证输出和精度。
4. **CARS SDK / 加密模型**：若训练源码不可用，按历史推理模型管理，在状态表标记缺失，不强求完整训练。

见 [实现状态表](../catalog/implementation_status.csv) 和 [迁移计划](MIGRATION.md)。
