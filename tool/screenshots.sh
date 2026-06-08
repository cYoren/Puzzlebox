#!/usr/bin/env bash
# Capture + frame PuzzleBox store screenshots locally.
#
# Usage:
#   tool/screenshots.sh                 # uses the first available device
#   tool/screenshots.sh <device_id>    # e.g. emulator-5554, or a simulator UDID
#
# Needs a running emulator, Android device, or `-d chrome`. Output:
#   screenshots/raw/      raw PNGs from the device
#   screenshots/store/    framed, store-sized images
set -euo pipefail
cd "$(dirname "$0")/.."

DEVICE="${1:-}"
DEVICE_ARGS=()
if [[ -n "$DEVICE" ]]; then
  DEVICE_ARGS=(-d "$DEVICE")
fi

echo "==> flutter pub get"
flutter pub get

echo "==> generating code (riverpod / freezed)"
dart run build_runner build --delete-conflicting-outputs

echo "==> capturing screenshots"
rm -rf screenshots/raw
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/screenshot_test.dart \
  "${DEVICE_ARGS[@]}"

echo "==> framing for stores"
python3 tool/frame_screenshots.py

echo "==> done. Framed images:"
find screenshots/store -type f | sort
