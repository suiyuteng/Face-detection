# BlazeFace / MediaPipe face detection

- **算法家族**：BlazeFace / MediaPipe face detection
- **扫描变体**：short-range / full-range；TFLite/ONNX/TRT
- **本地相关文件路径**：9（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `face_detection_short_range.tflite` （0.22 MB）
- `face_detection_full_range_sparse.tflite` （0.65 MB）
- `Triton-Blazeface 下的 model.onnx / model.plan`

## 注意

通用文件名 model.onnx 仅因其父目录归属被归入此类；TRT plan 与设备/软件版本绑定。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
