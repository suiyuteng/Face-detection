# Face detector benchmark protocol (planned)

**状态：评测方案，尚未实测。** 不要把模型文件大小或来源目录作为检测精度的依据。

## 能力对齐

- 标准输出：`boxes_xyxy`、`scores`、可选 `landmarks5`、图像原始尺寸。
- 每种检测器单独记录：输入颜色顺序、归一化、resize/letterbox、stride、anchor、bbox/landmark decode、NMS、置信阈值。
- 对不提供五点的模型，在“bbox-only”表单独对比；不得把外接关键点网络的延迟隐去。
- MTCNN 是多阶段推理；配套 PNet/RNet/ONet 同步管理。

## 测量方式

1. 使用有权使用的公开检测数据集（例如 WIDER FACE 合规使用的验证集）和固定环境；记录数据集版本。
2. 数据输入、尺寸、多尺度/翻转、置信阈值、NMS 均统一或明确给出差异。
3. 精度：Precision/Recall/AP，按 easy/medium/hard 或小、中、大目标统计；记录关键点误差（仅对有标签数据）。
4. 性能：CPU/GPU 型号、操作系统、框架、线程、batch、FP32/FP16/INT8、预热次数、重复次数、P50/P95、吞吐量、峰值 RSS/显存。
5. ONNX、Caffe、NCNN 与 TensorRT 后端必须先进行输出一致性检查；不能只比较文件大小或部署格式。
6. 对商业/加密 SDK 记录可访问 API 与限制；不能假定 SDK 的分数可与开源网络直接横向比较。

## 报告结构

每项实验保存 `model_id`、权重 SHA256、代码 commit、配置文件、完整运行命令、机器配置、原始指标及异常说明。

当前没有任何模型被标记为“已完成统一评测”。
