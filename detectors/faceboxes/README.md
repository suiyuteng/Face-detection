# FaceBoxes

- **算法家族**：FaceBoxes
- **扫描变体**：标准版、without-dense
- **本地相关文件路径**：6（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `faceboxes_iter_120000.caffemodel` （3.88 MB）
- `faceboxes.pt` （3.88 MB）
- `faceboxes-without-dense/faceboxes.caffemodel` （3.41 MB）

## 注意

需核对标准与 without-dense 两种结构、预处理和后处理。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
