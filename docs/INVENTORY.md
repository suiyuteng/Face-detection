# 人脸检测模型资产盘点

## 范围及证据等级

来源：本地 `model_search.csv` 搜索快照（2026-10-10），共 16,617 条路径；其中经文件名、目录和大小筛选出 **524 条人脸检测相关路径**：
- **365** 条权重/推理引擎/私有模型候选；
- **159** 条结构、参数或配置文件；
- **15** 个扫描子类，归入 **11** 个主要检测算法家族，另有 2 条用途未确认文件。

**注意：524 是路径数，不是 524 个独立模型。** 这些文件可能被复制到多个 SDK 中，且部分属于同一模型的不同部署格式。CSV 路径、大小仅为线索，不等于已经读取模型内部结构。

## 扫描子类统计

| 扫描子类 | 家族 | 骨干/变体 | 权重或引擎候选 | 结构/配置 |
|---|---|---|---:|---:|
| RetinaFace R50 | RetinaFace | ResNet-50 | 2 | 0 |
| RetinaFace MNet | RetinaFace | MobileNet-0.25 | 9 | 3 |
| RetinaFace SDK | RetinaFace | FaceX-Zoo 内置 | 2 | 0 |
| CARSDetect | CARS SDK | 封装检测模型 | 29 | 29 |
| CARS1-3 老版SDK | CARS SDK / 待确认 | 三级检测候选 | 21 | 21 |
| MTCNN | MTCNN | PNet/RNet/ONet | 219 | 93 |
| CenterFace | CenterFace | 标准版 / BN merged | 23 | 6 |
| FaceBoxes | FaceBoxes | standard / without-dense | 3 | 3 |
| YuNet / YuFaceDetect | YuNet / YuFaceDetect | v1/v2 | 7 | 3 |
| UltraFace | UltraFace | Slim/RFB | 28 | 0 |
| DSFD | DSFD | R152/R18/Light | 6 | 0 |
| YOLOv5-Face | YOLOv5-Face | s/m/l | 3 | 0 |
| BlazeFace | BlazeFace | short/full | 9 | 0 |
| OpenCV SSD | OpenCV SSD | ResNet-10 | 2 | 1 |
| 其他未确认 | unknown | 待判定 | 2 | 0 |

## 推荐的第一批对照模型

| 模型 | 代表文件 | 快照大小 | 现状 |
|---|---|---:|---|
| RetinaFace R50 | `R50_onnx.onnx` | 112.59 MB | 本地存在；骨干/输出待解析 |
| RetinaFace MNet025 | `mnet025_v1.onnx` | 1.97 MB | 本地存在；需核对解码 |
| YOLOv5s-Face | `yolov5s-face.onnx` | 26.97 MB | 本地存在；关键点解码待测 |
| CenterFace | `centerface.onnx` | 7.18 MB | 本地存在；后端可比性待测 |
| UltraFace Slim 320 | `version-slim-320.onnx` | 1.14 MB | 本地存在；轻量基线 |
| YuFaceDetect v2 | `yufacedetectnet-open-v2.caffemodel` | 3.34 MB | 本地存在；需配套 prototxt |
| MTCNN | `pnet_20181218_final.pkl` 等 3 个 | 多文件 | 现有仓库代码与权重 |
| CARSDetect | `CARSDetect.bin` + `.para.bin` | ~1.68 MB + 配置 | 本地封装 SDK；解密依赖待核对 |
| DSFD R152 | `WIDERFace_DSFD_RES152.pth` | 458.72 MB | 本地存在；大模型对照 |

## 不应误分类的资源

- `RetinaNet R50` 不等同 `RetinaFace R50`。
- DenseNet CARSFace、MobileFaceNet/CASIA-WebFace 属于**人脸识别/特征提取**，并非检测。
- 56 点 Landmark 文件通常属于**检测后的关键点细化**，不是独立检测器。
- `mobile.trt`、`small_detect.model`、`res.txt` 仅凭名字不能认定为人脸检测器。
- `.cache` 和 TensorRT `.plan/.trt` 可能与构建设备、CUDA、TensorRT 版本绑定；不能直接当跨设备标准权重。

## 下一步需要补充的证据

1. 在用户本地读取模型输入、输出和结构（ONNX/Caffe/NCNN），确认检测头、五点关键点、NMS 与预处理。
2. 对同名同大小的路径逐文件计算 SHA256；识别相同文件与不同训练版本。
3. 记录原始源码、下载来源、许可证/再分发权限、精度基线和目标硬件。
4. 只有在以上完成后，才安排代码迁移、必要的模型分发方式与端到端评测。

完整 524 条路径留在用户本地盘点表中；**公开 GitHub 仅提交脱敏代表索引，不公开完整 Windows 路径**。
