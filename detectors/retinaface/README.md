# RetinaFace

- **算法家族**：RetinaFace
- **扫描变体**：ResNet-50；MobileNet-0.25；FaceX-Zoo SDK
- **本地相关文件路径**：16（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `R50_onnx.onnx` （112.59 MB，R50 候选）
- `mnet025_v1.onnx` （1.97 MB）
- `mnet025_fix_gamma_v2.onnx` （1.97 MB）
- `mnet25.caffemodel` （1.69 MB）
- `mnet.txt` （5.13 MB，疑似加密 TRT，未验证）

## 注意

R50 骨干、检测头及五点输出仍需解析 ONNX；.cache 文件不是已确认可移植的权重。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
