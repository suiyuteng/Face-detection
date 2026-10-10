# YuNet / YuFaceDetect

- **算法家族**：YuNet / YuFaceDetect
- **扫描变体**：v1、v2、ONNX 变体
- **本地相关文件路径**：10（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `yufacedetectnet-open-v1.caffemodel` （2.58 MB）
- `yufacedetectnet-open-v2.caffemodel` （3.34 MB）
- `yunet_n_640_640.onnx` （0.30 MB，命名候选）

## 注意

早期 YuFaceDetect 和现代 YuNet 命名相近，但不得未经检查就认定架构或训练权重一致。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
