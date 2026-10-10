# OpenCV SSD face detector

- **算法家族**：OpenCV SSD face detector
- **扫描变体**：ResNet-10 SSD
- **本地相关文件路径**：3（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `res10_300x300_ssd_iter_140000.caffemodel` （10.17 MB）
- `deploy.prototxt`

## 注意

作为传统 OpenCV DNN 对照基线；要确认结构与权重是相互匹配的文件。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
