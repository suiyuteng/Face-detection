# Face-detection

**人脸检测：训练 + 推理 + 模型导出 + 统一评测**（Face Detection: Training, Inference & Benchmarking）

> 仓库目标不是只收集推理权重：每个算法家族都希望最终保留可复现的训练配置、训练实现、推理实现及评测记录。但**代码已发现**、**已提交**和**已验证可运行**是三种不同状态；请查看 [实现状态表](catalog/implementation_status.csv)。

## 目前已有的训练和推理代码

| 家族 | 训练 | 推理 | 导出/部署 | 当前状态 |
|---|---|---|---|---|
| MTCNN PyTorch | [三个训练入口](MTCNN-pytorch/) + [数据生成](MTCNN-pytorch/data_gen/) | [MTCNN.py](MTCNN-pytorch/MTCNN.py) | 未验证 | 代码和 P/R/O 三阶段权重已在仓库；**本仓库没有配套完整训练数据，训练/推理端到端尚未复现** |
| RetinaFace MNet / R50 | 本次本地清单尚未发现完整训练入口 | 本地 C++/TensorRT 实现（**未迁入**） | 本地 MXNet→Caffe、ONNX 文件、INT8 校准（**未迁入**） | [文件盘点](detectors/retinaface/)，尚需源码、来源许可和输入输出验证 |
| 其他算法 | 待排查 | 待迁入 | 待排查 | 当前只登记模型及算法来源，不算完整实现 |

## 计划采用的工程布局

```text
Face-detection/
  MTCNN-pytorch/                 # 原有完整历史目录：先不移动
  detectors/
    mtcnn/                       # 当前指向历史目录
    retinaface/
      README.md                  # 当前只有文档和模型索引
      train/                     # 后续：训练入口、模型结构、loss/配置
      inference/                 # 后续：PyTorch/ONNX/Caffe/TensorRT 推理
      export/                    # 后续：导出、校验、量化
      tests/                     # 后续：前后处理与数值一致性
    centerface/ ...              # 其他算法将逐步采用同一规范
  datasets/                      # 只存数据说明和适配器，不存人脸照片
  catalog/                       # 模型版本、源码来源、SHA256 和实现状态
  docs/                          # 训练/推理规范、迁移和实验
  benchmarks/                    # 统一评测协议与未来的脚本、结果
  scripts/                       # 本地只读权重核验
```

**注意：**上图中 `train/`、`inference/`、`export/` 等是**目标布局**；对于 RetinaFace 尚未实际创建和填入代码，不能视为已经实现。

## 模型家族

- [MTCNN](detectors/mtcnn/)
- [RetinaFace R50 / MobileNet](detectors/retinaface/)
- [CenterFace](detectors/centerface/)
- [UltraFace](detectors/ultraface/)
- [FaceBoxes](detectors/faceboxes/)
- [YuNet / YuFaceDetect](detectors/yunet/)
- [DSFD](detectors/dsfd/)
- [YOLOv5-Face](detectors/yolov5-face/)
- [BlazeFace](detectors/blazeface/)
- [OpenCV SSD](detectors/opencv-ssd/)
- [CARS SDK 旧模型](detectors/cars-sdk/)（来源与训练权属待确认）

## 文档导航

- **[训练、推理及导出约定](docs/TRAINING_INFERENCE.md)**：每个家族的训练/推理/测试资料放哪里
- [迁移计划](docs/MIGRATION.md)：分阶段补齐缺失实现
- [模型盘点](docs/INVENTORY.md)：来自本地快照的模型线索
- [RetinaFace 本地源码检查](docs/RETINAFACE_REVIEW.md)：已发现哪些，尚缺什么
- [统一检测评测](docs/BENCHMARK.md)：精度与部署性能对比
- [模型候选清单](catalog/model_candidates.csv) 和 [实现状态](catalog/implementation_status.csv)
- [本地 SHA256 只读检查](scripts/verify_local_assets.ps1)

## 代码和数据管理原则

1. **以算法家族为单位**：培训和推理共享模型定义、预处理和配置来源；ONNX/Caffe/TensorRT 是部署方式，不应被误当独立算法。
2. 训练代码必须有可复现配置、数据格式说明、模型输出/检查点约定；推理代码必须有可跑的单张图片验证与可比输出。
3. **先保留旧项目**：原 `MTCNN-pytorch/` 路径、代码与权重未移动或删除，避免破坏原相对导入。
4. **不能只复制权重却声称训练代码齐全**：无源训练实现的模型明确标识为 `inference-only` 或 `weights-only`。
5. 不公开私有人脸数据、未获授权的第三方源码、加密 SDK 或私有模型；大型/许可受限权重只登记校验和、来源与获取方式。
6. [本地路径映射模板](catalog/local_paths.template.csv) 可复制为 `catalog/local_paths.csv` 仅用于本机，该文件被 Git 忽略。
