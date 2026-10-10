# RetinaFace: triage of local source trees

Evidence: user-supplied `retinaface_files.csv` generated from four nominated roots (2026-10-10). Exactly 55 rows were present: 3 ONNX candidates, 2 Caffe weights, 2 Caffe prototxt, an MXNet symbol JSON, and multiple C++/Python/support files across three roots. The fourth nominated root (historically holding `mnet.txt`) contributed **zero rows to this scan**; this is not proof that it is absent.

## Classification, not migration

1. **`onnx_models`**: three ONNX files, with no inference code in that root. `R50_onnx.onnx` has a matching-named `.cache` mentioned in an earlier search but the `.cache` extension was not part of the current scan.
2. **`legacy_retinaface`**: `model/mnet25.{caffemodel,prototxt}`, `model/mnet-deconv-0517.{caffemodel,prototxt}`, `retinaface/RetinaFace.{cpp,h}`, `retinaface/tensorrt/trtretinafacenet.{cpp,h}`, `MXNet2Caffe/`, and `INT8-Calibration-Tool/`. This is a historical project containing multiple functions; do not flatten into the new repository.
3. **`tensorrtx_retinaface`**: `retina_mnet.cpp`, `retina_r50.cpp`, `decode.h`, `calibrator.cpp`, `retinaface_trt.py`, and `CMakeLists.txt`. A separate TensorRT implementation. Its expected weights could be `.wts` or another format: inspect code before assuming it will load the ONNX file.
4. **Engine candidates not in this CSV**: a prior disk inventory contained `mnet.txt`, `R50_onnx.cache`, and `mnet-deconv-0517.table.int8`. These may be encrypted engines or caches; **no contents were inspected here** and names alone are insufficient evidence.

## Minimal source review package (no weights needed)

From the historical `legacy_retinaface` root:

- `README.md`, `CMakeLists.txt`
- `retinaface/RetinaFace.cpp` and `retinaface/RetinaFace.h`
- `retinaface/tensorrt/trtretinafacenet.cpp` and `.h`
- `model/mnet25.prototxt` and `model/mnet-deconv-0517.prototxt`

From the `tensorrtx_retinaface` root:

- `README.md`, `CMakeLists.txt`
- `retina_mnet.cpp`, `retina_r50.cpp`, `decode.h`

**Do not upload model weights, encrypted engines, AES keys, vendor SDK binaries, private test images, or proprietary source to a public repo.** Shared sources should be reviewed for credentials, third-party licenses, and redistribution permission before being committed.

## Decision gates

| Gate | Required evidence | Outcome |
|---|---|---|
| Identity | SHA256 + graph comparison | Separate training versions from mere exports |
| Inference | Input/output names and shapes, resize, normalization, NMS, 5-point decoder | Specify one working reference implementation |
| Runtime | Runtime dependencies (OpenCV/Caffe/ONNXRuntime/CUDA/TensorRT), version, GPU, custom plugins | Decide backend support |
| Provenance | Source repo/commit/license and model redistribution rights | Decide what can be published |
| Benchmark | Fixed image/test set, bbox convention, thresholds, latency P50/P95 | Compare only validated detectors |

Before proposing a public code migration, review these files; avoid copying an entire historical CARS/SDK directory with encrypted components.

## Extension-filter caveat

The snapshot was created with a restricted suffix set. The following may be missing even when they exist: `.wts`, `.cache`, `.table.int8`, `.params`, `.weights`, `.pt`, `.pth`, and `.mxnet` files. The Windows drive `G:` yielded no matching entry in this scan. Any additional discovery should be targeted and should save results to a CSV, not print thousands of lines.
