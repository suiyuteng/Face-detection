# CARS SDK detectors

- **算法家族**：CARS SDK detectors
- **扫描变体**：CARSDetect（58 路径）；CARS1/2/3（42 路径，类型待确认）
- **本地相关文件路径**：100（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `CARSDetect.bin + CARSDetect.para.bin` （加密/封装配对）
- `CARS1.bin、CARS2.bin、CARS3.bin` （旧版 SDK 候选）

## 注意

封装模型需要关联的解密处理和 SDK 接口；不把加密 .bin 直接当作裸 Caffe 或 TensorRT 权重。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
