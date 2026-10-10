# UltraFace

- **算法家族**：UltraFace
- **扫描变体**：Slim/Tiny、RFB，320/640
- **本地相关文件路径**：28（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `version-slim-320.onnx` （1.14 MB）
- `version-RFB-320.onnx` （1.21 MB）
- `Mb_Tiny_FD_train_input_320.pth` （1.04 MB）

## 注意

特别标注输入尺寸、RFB/Slim 变体，以及是否含 NMS/解码。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
