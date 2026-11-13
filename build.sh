#!/usr/bin/env bash
# build.sh — build the Tasks desktop app via a machin-desktop checkout.
#
#   ./build.sh                      → build/machin-tasks (release binary)
#   MDK_DESKTOP=/path/to/machin-desktop ./build.sh
#   ./mdk-dev.sh                    → hot-reload dev mode (see below)
#
# machin-desktop provides the framework (framework/*.src), the SDL3/OpenGL
# host and the mdk tool. Default location is a sibling checkout; override
# with MDK_DESKTOP. Requires: machin on PATH, SDL3 build deps (mdk vendors
# SDL itself), freetype2/harfbuzz via pkg-config.
set -euo pipefail
cd "$(dirname "$0")"
MDK_DESKTOP="${MDK_DESKTOP:-$HOME/ai/machin-desktop}"
[[ -f "$MDK_DESKTOP/mdk" ]] || {
    echo "build: machin-desktop not found at $MDK_DESKTOP (set MDK_DESKTOP)" >&2
    exit 1
}
mkdir -p build
exec "$MDK_DESKTOP/mdk" build app/ -o "$PWD/build/machin-tasks"
