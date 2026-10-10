# Face-detection

人脸检测算法与模型资产目录（Face Detection Model Collection）。

> **状态说明**：当前仓库已有一套 MTCNN PyTorch 代码与 PNet/RNet/ONet 权重；其他检测器暂时只建立**本地文件索引和整理位置**，并非全部已上传或已验证可运行。

## 已有实现

- [MTCNN-pytorch/](MTCNN-pytorch/)：保留原有代码、训练脚本和 3 个 `.pkl` 权重；不改变旧工程路径。
- [detectors/mtcnn/](detectors/mtcnn/)：统一算法目录入口，指向上述现有实现。

## 检测算法目录

- [RetinaFace](detectors/retinaface/) — ResNet-50；MobileNet-0.25；FaceX-Zoo SDK
- [MTCNN](detectors/mtcnn/) — PNet / RNet / ONet；det1–det4；历史检查点
- [CARS SDK detectors](detectors/cars-sdk/) — CARSDetect（58 路径）；CARS1/2/3（42 路径，类型待确认）
- [CenterFace](detectors/centerface/) — 原版、BN merged；ONNX/NCNN/TensorRT
- [FaceBoxes](detectors/faceboxes/) — 标准版、without-dense
- [YuNet / YuFaceDetect](detectors/yunet/) — v1、v2、ONNX 变体
- [UltraFace](detectors/ultraface/) — Slim/Tiny、RFB，320/640
- [DSFD](detectors/dsfd/) — ResNet-152、R18、Light DSFD
- [YOLOv5-Face](detectors/yolov5-face/) — Small、Medium、Large
- [BlazeFace / MediaPipe face detection](detectors/blazeface/) — short-range / full-range；TFLite/ONNX/TRT
- [OpenCV SSD face detector](detectors/opencv-ssd/) — ResNet-10 SSD

## 资产盘点与实验约定

- [docs/INVENTORY.md](docs/INVENTORY.md)：本地扫描结果、家族分布和证据等级
- [catalog/model_candidates.csv](catalog/model_candidates.csv)：代表性文件索引（**不是已加入 Git 的权重清单**）
- [docs/MIGRATION.md](docs/MIGRATION.md)：按来源、版本和授权逐步迁入
- [docs/BENCHMARK.md](docs/BENCHMARK.md)：统一精度、速度、内存评测标准
- [scripts/verify_local_assets.ps1](scripts/verify_local_assets.ps1)：在本地只读检查文件和 SHA256

本地位置映射填写到 `catalog/local_paths.csv`（仓库忽略、不公开），格式见 [catalog/local_paths.template.csv](catalog/local_paths.template.csv)。

## 整理原则

1. **按算法家族归档**，区分训练版本和 ONNX/Caffe/NCNN/TRT 等部署格式。
2. **原始项目先保留**；确认来源、运行方式、许可证后再迁移其他代码。
3. **不默认提交本地模型权重、第三方 SDK 或私有人脸数据**。超过 GitHub 单文件限制的权重应在授权许可后使用 Git LFS 或外部制品库。
4. **不使用文件名/文件大小判定重复**。SHA256 相同才是字节级副本；结构/特征行为是否相同须单独验证。
5. **不混淆检测与识别**：DenseNet CARSFace、MobileFaceNet 人脸特征模型继续留在识别项目，不纳入本检测仓库。

本次目录盘点基于 2026-10-10 的 `model_search.csv` 文件搜索快照（16,617 条记录）。它不是全盘内容证明，也不是模型性能测试结果。
