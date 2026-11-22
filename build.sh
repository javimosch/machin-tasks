#!/usr/bin/env bash
# build.sh — build the Tasks desktop app via a machin-desktop checkout.
#
#   ./build.sh                      → build/machin-tasks (release binary)
#   MDK_DESKTOP=/path/to/machin-desktop ./build.sh
#   ./mdk-dev.sh                    → hot-reload dev mode (see below)
#
# machin-desktop provides the framework (framework/*.src), the SDL3/OpenGL
# host and the mdk tool. Default location is a sibling checkout; override
# with MDK_DESKTOP. Requires: machin >= v0.141.0 on PATH — framework/ui.src
# uses the poke_i64 builtin (javimosch/machin#680); an older compiler dies at
# typecheck with "call to undefined function" on a generated identifier, so
# the version is checked up front. Also needs SDL3 build deps (mdk vendors
# SDL itself), freetype2/harfbuzz via pkg-config.
set -euo pipefail
cd "$(dirname "$0")"

# numeric >= on dotted versions like 0.141.0 (missing parts count as 0)
version_ge() {
    local IFS=.
    local -a a b
    read -ra a <<< "$1" || true
    read -ra b <<< "$2" || true
    local i x y
    for i in 0 1 2; do
        x=${a[i]:-0}; y=${b[i]:-0}
        x=${x%%[!0-9]*}; y=${y%%[!0-9]*}
        x=$((10#${x:-0})); y=$((10#${y:-0}))
        if (( x > y )); then return 0; fi
        if (( x < y )); then return 1; fi
    done
    return 0
}

MACHIN="${MACHIN:-machin}"
MIN_MACHIN="0.141.0"
command -v "$MACHIN" >/dev/null 2>&1 || {
    echo "build: machin not found on PATH (need >= v$MIN_MACHIN): $MACHIN" >&2
    echo "build: https://github.com/javimosch/machin" >&2
    exit 1
}
mver="$("$MACHIN" guide 2>/dev/null | sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' | head -1)" || true
if ! version_ge "${mver:-0.0.0}" "$MIN_MACHIN"; then
    echo "build: machin >= v$MIN_MACHIN required, found ${mver:-unknown} — framework/ui.src uses poke_i64 (javimosch/machin#680)" >&2
    echo "build: upgrade: https://github.com/javimosch/machin/releases/latest" >&2
    exit 1
fi

MDK_DESKTOP="${MDK_DESKTOP:-$HOME/ai/machin-desktop}"
[[ -f "$MDK_DESKTOP/mdk" ]] || {
    echo "build: machin-desktop not found at $MDK_DESKTOP (set MDK_DESKTOP)" >&2
    exit 1
}
mkdir -p build
exec "$MDK_DESKTOP/mdk" build app/ -o "$PWD/build/machin-tasks"
