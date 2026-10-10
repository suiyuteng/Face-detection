# 迁移计划（非破坏性）

目标：逐步把当前 `Face-detection` 扩展为可比较、可追溯的检测算法集合，**不一次性搬运旧代码仓库或所有权重**。

## Phase 0：冻结和索引（本分支）

- 保留 `MTCNN-pytorch/` 原有路径、代码、三个 `.pkl` 权重与提交历史，不改动、不删除。
- 建立 `detectors/<family>/` 算法家族入口、`catalog/` 模型索引及评测规范。
- 本次 GitHub 只含文档、CSV 和只读本地核验脚本；未从用户 D/G/I 盘上传任何权重。

## Phase 1：核实本地资产

1. 用私有的 `catalog/local_paths.csv` 对应 `model_candidates.csv` 中的 `id` 与 Windows 完整路径。
2. 运行 `scripts/verify_local_assets.ps1`，读取大小及 SHA256；结果写到被忽略的 `artifacts/`。
3. 识别字节级副本；**不得仅凭文件名和 MB 大小删除文件**。
4. 按一条记录一份“原训练模型”的规则关联多种导出：例如 CenterFace ONNX/NCNN/TRT，RetinaFace MNet Caffe/ONNX/缓存。未验证同源时保留分离记录。

## Phase 2：引入可运行实现（按优先级）

- 第一组：现有 MTCNN（建立依赖说明和 smoke test）。
- 第二组：RetinaFace MNet025 与 R50（统一前后处理后比较）。
- 第三组：CenterFace、UltraFace、YuNet、YOLOv5-Face。
- 第四组：FaceBoxes、DSFD、BlazeFace、OpenCV SSD。
- CARSDetect 和 CARS1/2/3 作为历史 SDK 模型，依赖解密或专有 API，单独评估。

每迁入一个实现：记录上游来源/commit、LICENSE、是否修改、运行平台、依赖、前处理、输出格式、权重校验值、运行命令和一次可复现结果。**版权或再分发权限未知时不要复制第三方源码和 SDK 二进制到公开仓库**。

## Phase 3：权重存储策略

- 默认不跟踪 `local_assets/`（供本地试验）。
- 对取得再分发权的公开权重，在模型说明中保存 SHA256/来源及下载方式；只有确需入库时才考虑 Git LFS。
- 大于 GitHub 普通 Git 单文件上限的权重不能按普通文件上传，例如 `R50_onnx.onnx` 和 `WIDERFace_DSFD_RES152.pth`。
- 私有加密 Engine、商业 SDK、受许可限制的模型及人脸数据默认不公开。
- 导出缓存、训练中间产物和 TensorRT plan 应记录生成环境，避免跨硬件假兼容。

## Phase 4：统一评测与去重

统一检测 bbox、score、可选五点关键点 API；在同一数据集及固定策略下测试 Accuracy/Recall/latency/memory。完成核验后才决定保留的基线版本，**不自动删除本地其他备份**。

## 公有索引与私有路径

`catalog/model_candidates.csv`：安全的候选清单，无完整私有磁盘路径。

`catalog/local_paths.csv`：用户私有映射；**不要提交**，参见 `catalog/local_paths.template.csv`。

`artifacts/local_hash_report.csv`：本地哈希结果；不要提交。
