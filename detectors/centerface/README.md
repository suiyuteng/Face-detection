# CenterFace

- **算法家族**：CenterFace
- **扫描变体**：原版、BN merged；ONNX/NCNN/TensorRT
- **本地相关文件路径**：29（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：目前仅登记本地候选；尚未迁入实现、权重或模型验证代码。

## 模型线索

- `centerface.onnx` （7.18 MB）
- `centerface_bnmerged.onnx` （6.97 MB）
- `centerface.bin + centerface.param` （NCNN）
- `centerface.trt` （9.53 MB，设备/版本敏感）

## 注意

同一网络的不同导出或运行时产物应关联到一个训练版本，不能按后缀数目计算独立模型。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
