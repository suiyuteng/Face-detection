# 迁移计划：训练 + 推理 + 评测（非破坏性）

目标：建立覆盖**训练、验证、导出、推理、性能评测**的人脸检测研究仓库，不是将一堆历史权重直接复制到 GitHub。

## Phase 0：资产盘点与现状冻结（当前草稿 PR）

- 保留 `MTCNN-pytorch/` 原有训练脚本、推理、模型及提交历史；**不移动、不删除，不覆盖**。
- 保留 `detectors/<family>/` 算法家族入口，明确区分 `训练源码已发现`、`推理源码已发现`、`仅权重`、`已验证` 四类状态。
- 按 [训练/推理约定](TRAINING_INFERENCE.md) 为未来真实代码留出规范，**没有源码的模块不创建假入口**。
- 路径/文件索引属于本地快照，不等同模型训练可复现证明。公有目录不公开私人 Windows 完整路径。

## Phase 1：验证 MTCNN 基准

1. 检查 `train_pnet.py`、`train_rnet.py`、`train_onet.py`、数据生成和 `MTCNN.py`；
2. 梳理训练脚本需要的 `../dataset/`、Python/PyTorch/OpenCV 版本、标注格式；
3. 用已存在的三个阶段权重完成单张图 smoke test，然后验证小规模训练/检查点保存及恢复；
4. 写明实际跑通的命令、依赖、限制、固定测试输入与结果；**运行前只标记源码存在**。

## Phase 2：恢复 RetinaFace 完整谱系

1. 对 `mnet025_v1.onnx`、`mnet025_fix_gamma_v2.onnx`、`R50_onnx.onnx` 和 Caffe 模型检查输入/输出/网络结构与哈希；
2. 查明原始 MXNet/PyTorch 训练项目和可公开再分发的许可证，检查是否本地另存训练代码；
3. 对现有 `retinaface-master` 和 `tensorrtx-master/retinaface` 分别归档转换和推理后端；**不能把转换或 TRT 构建代码当训练源码**；
4. 如训练代码合法可得，新增训练配置和训练入口；与 ONNX/Caffe/TensorRT 推理形成同一模型版本链；
5. 用带授权标签的测试数据做框/关键点结果、吞吐、延迟对比。

## Phase 3：逐家族扩展

CenterFace、UltraFace、FaceBoxes、YuNet、DSFD、YOLOv5-Face、BlazeFace、OpenCV SSD。根据训练源可获得性区分 `training+inference` 和 `inference-only`；不存在的训练部分留待补齐。

CARSDetect、CARS1/2/3 等旧 SDK 的私有封装、解密和许可要求单独记录，禁止未经授权复制上游源码/模型。

## Phase 4：统一评测、去重和权重管理

- 训练方面：数据协议、配置、种子、训练损失、验证 AP/Recall、运行环境、检查点 SHA256。
- 推理方面：模型前后处理、bbox/score/landmarks、输出一致性、速度 P50/P95、峰值内存和硬件。
- 同名文件 SHA256 相同才可视作字节副本；部署格式与训练版本的对应需另外证明。
- 模型权重默认不纳入普通 Git；大型公开权重可在许可适当时采用 LFS/外部制品库；人脸照片、私有 SDK、加密 Engine 不公开。

## 本地私有登记

`catalog/model_candidates.csv`：本次候选索引，无完整私人路径。

`catalog/local_paths.csv`：私有绝对路径表；按模板填写，不提交。

`artifacts/local_hash_report.csv`：哈希报告；不提交。

`catalog/implementation_status.csv`：训练/推理/导出源码及验证状态；更新时记录明确的源码或测试证据。
