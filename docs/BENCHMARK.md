# Face detector benchmark protocol (planned)

**状态：训练可复现 + 推理评测方案，尚未完成实测。** 不以权重文件大小或文件名称代替指标。

## 训练结果可复现

- 记录模型架构、原始实现与许可、数据来源和拆分、数据标注与增强、随机种子、输入大小；
- 记录 optimizer、学习率计划、训练步数、batch、loss、checkpoint、断点恢复，训练/验证曲线；
- 对 WIDER FACE（符合其数据授权和使用约束）的验证集报告检测 AP（easy/medium/hard）或适用的其他数据集分组结果；
- 验证是否训练产生的 checkpoint 能被仓库的推理加载，而不是只有离线权重。

## 统一推理输出与正确性

- 标准输出：`boxes_xyxy`、`scores`、可选 `landmarks5`，像素坐标基于原图；
- 记录 RGB/BGR、mean/std、resize/letterbox、anchor、bbox/landmark 解码、置信度和 NMS；
- 关键点仅对具备标注和关键点输出的模型比较，避免跨模型虚假公平性；
- 验证不同框架导出模型与训练参考模型在框、得分、关键点上的输出一致性；
- MTCNN 多阶段模型需保持 PNet/RNet/ONet 来源一致。

## 性能

- 固定设备、OS、CPU/GPU、CUDA、TensorRT、Python/PyTorch/ONNX Runtime/OpenCV 版本、线程与 batch；
- 预热后重复测量 P50/P95、FPS、峰值内存、输入大小、精度类型 FP32/FP16/INT8；
- 单模型推理和预处理 + 推理 + 后处理端到端分别报告；
- 保留权重 SHA256、实际命令、配置、错误/异常及原始统计数据。

**当前不声称任何检测器已经完成跨框架统一 benchmark。**
