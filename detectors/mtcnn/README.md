# MTCNN

- **算法家族**：MTCNN
- **扫描变体**：PNet / RNet / ONet；det1–det4；历史检查点
- **本地相关文件路径**：312（含重复路径、结构/配置和不同后端；非独立权重数）
- **代码状态**：已有仓库内 [MTCNN-pytorch/](../../MTCNN-pytorch/)；此目录仅作为统一入口。

## 模型线索

- `MTCNN-pytorch/models/pnet_20181218_final.pkl` （仓库已收录）
- `MTCNN-pytorch/models/rnet_20181218_final.pkl` （仓库已收录）
- `MTCNN-pytorch/models/onet_20181218_final.pkl` （仓库已收录）
- `det1–det4 的 Caffe/NCNN 配套文件` （本地发现）

## 注意

原有可追溯的代码位于根目录 MTCNN-pytorch/，不移动、不复制第二份。不同 P/R/O Net 版本需要成套验证。

下一步按 [迁移计划](../../docs/MIGRATION.md) 逐个确认来源、许可、哈希、输入输出和统一评测；禁止仅因名称相同就覆盖本地旧文件。
