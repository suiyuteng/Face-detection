# RetinaFace model family

**State: source and weight discovery only. No new RetinaFace weights or external source trees are committed here.**

## Local scan snapshot (2026-10-10)

The user-supplied `retinaface_files.csv` contains **55 file records**, from three existing local source groups:

| Source alias | Records | What is present |
|---|---:|---|
| `onnx_models` | 3 | Two MobileNet-0.25 ONNX variants and one R50 ONNX candidate |
| `legacy_retinaface` | 41 | Two Caffe weights and prototxt pairs; C++ inference; MXNet-to-Caffe conversion; an INT8 calibration project |
| `tensorrtx_retinaface` | 11 | `retina_mnet.cpp`, `retina_r50.cpp`, decode, calibrator, build files |

The complete **path-sanitized** file list is in [catalog/retinaface_snapshot.csv](../../catalog/retinaface_snapshot.csv). A path record is not a model, and rounded MB sizes are not precise integrity checks.

## Current weight candidates

| Variant | Local filename | Size (rounded) | Graph/runtime |
|---|---|---:|---|
| MNet025 v1 | `mnet025_v1.onnx` | 1.97 MB | ONNX |
| MNet025 gamma-v2 | `mnet025_fix_gamma_v2.onnx` | 1.97 MB | ONNX |
| R50 | `R50_onnx.onnx` | 112.59 MB | ONNX, graph unverified |
| MNet25 Caffe | `mnet25.caffemodel` + `mnet25.prototxt` | 1.69 MB | Caffe |
| MNet deconv 0517 | `mnet-deconv-0517.caffemodel` + `mnet-deconv-0517.prototxt` | 1.69 MB | Caffe |

Five model-weight files were found across these roots. It is **not yet established** whether the paired MNet variants are independent trained models, exact exports, or graph transformations; verify structural correspondence and outputs before merging identities.

## Current organization plan

- `models/`: planned manifest of training version, provenance, input/output, checksum, and authorized download location; **not a place to blindly commit large/private weights**.
- `backends/onnx/`: future ONNX Runtime implementation.
- `backends/caffe/`: future Caffe/OpenCV DNN implementation.
- `backends/tensorrt/`: future TensorRT implementation, **subject to original source licenses and environment compatibility**.
- `tests/`: future standard I/O and numeric benchmark.

These directories are only proposed until each implementation and license are verified. Existing original code remains in its original local directories for now.

See [RetinaFace review and migration](../../docs/RETINAFACE_REVIEW.md) and [general migration policy](../../docs/MIGRATION.md).

**Not yet verified:** actual R50 backbone, landmark output, preprocessing, plugin dependencies, encryption, license suitability, TensorRT compatibility, SHA256, and WIDER FACE performance. Existing `.cache` and `.wts` files were not captured by the extension filter in this scan.
