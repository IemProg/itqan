#!/usr/bin/env python3
"""
Itqan ML Pipeline — Download & Convert Whisper to ONNX
Downloads tarteel-ai/whisper-base-ar-quran and converts to ONNX for Flutter.

Usage: python3 download_and_convert.py
"""

import os, sys, json
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent
MODELS_DIR = SCRIPT_DIR.parent / "models"
MODEL_ID = "tarteel-ai/whisper-base-ar-quran"
MODEL_DIR = MODELS_DIR / "whisper-base-ar-quran"
ONNX_DIR = MODELS_DIR / "whisper-base-ar-quran-onnx"
ONNX_INT8_PATH = MODELS_DIR / "whisper-base-ar-quran.int8.onnx"
MODELS_DIR.mkdir(parents=True, exist_ok=True)

def step(msg):
    print(f"\n{'='*60}\n  {msg}\n{'='*60}")

# Step 1: Download
step("Step 1: Downloading tarteel-ai/whisper-base-ar-quran from HuggingFace")
try:
    from huggingface_hub import snapshot_download
    snapshot_download(
        repo_id=MODEL_ID,
        local_dir=str(MODEL_DIR),
        ignore_patterns=["*.msgpack", "flax_model*", "tf_model*", "rust_model*"],
    )
    print(f"✅ Downloaded to: {MODEL_DIR}")
except Exception as e:
    print(f"❌ Download failed: {e}"); sys.exit(1)

# Step 2: Convert to ONNX
step("Step 2: Converting to ONNX (optimum)")
try:
    import subprocess
    result = subprocess.run([
        sys.executable, "-m", "optimum.exporters.onnx",
        "--model", str(MODEL_DIR),
        "--task", "automatic-speech-recognition",
        "--opset", "14",
        str(ONNX_DIR)
    ], capture_output=True, text=True, timeout=300)
    print(result.stdout[-2000:] if result.stdout else "")
    if result.returncode != 0:
        print("STDERR:", result.stderr[-1000:])
        raise RuntimeError("Export failed")
    print(f"✅ ONNX saved to: {ONNX_DIR}")
except Exception as e:
    print(f"❌ ONNX conversion failed: {e}")
    print("Run manually: pip install optimum[exporters] && python3 -m optimum.exporters.onnx ...")

# Step 3: Quantize to INT8
step("Step 3: INT8 Quantization (~60% smaller, faster on mobile)")
try:
    from onnxruntime.quantization import quantize_dynamic, QuantType
    encoder_path = next(ONNX_DIR.glob("encoder*.onnx"), None) or next(ONNX_DIR.glob("*.onnx"), None)
    if encoder_path:
        quantize_dynamic(str(encoder_path), str(ONNX_INT8_PATH), weight_type=QuantType.QInt8)
        orig = encoder_path.stat().st_size / 1e6
        quant = ONNX_INT8_PATH.stat().st_size / 1e6
        print(f"✅ {orig:.1f}MB → {quant:.1f}MB saved at {ONNX_INT8_PATH}")
    else:
        print("⚠️  No encoder ONNX found to quantize")
except Exception as e:
    print(f"⚠️  Quantization skipped: {e}")

# Step 4: Manifest
manifest = {
    "model_id": MODEL_ID,
    "model_downloaded": MODEL_DIR.exists(),
    "onnx_converted": ONNX_DIR.exists(),
    "onnx_quantized": ONNX_INT8_PATH.exists(),
    "onnx_int8_path": str(ONNX_INT8_PATH) if ONNX_INT8_PATH.exists() else None,
}
with open(MODELS_DIR / "manifest.json", "w") as f:
    json.dump(manifest, f, indent=2)
print("\n📦 Manifest:", json.dumps(manifest, indent=2))
print("\n✅ Done — ready for Flutter ONNX Runtime integration")
