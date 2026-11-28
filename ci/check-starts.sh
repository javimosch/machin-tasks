#!/usr/bin/env bash
# check-starts.sh <binary> — the app must open its window and stay up on every
# Ubuntu we support, using only that system's own libraries.
set -euo pipefail
bin="$(readlink -f "${1:?usage: check-starts.sh <binary>}")"
for image in ubuntu:22.04 ubuntu:24.04; do
    echo "== $image"
    docker run --rm -v "$bin:/app:ro" "$image" bash -c '
        { apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
            libfreetype6 libharfbuzz0b libgl1 libgl1-mesa-dri libsqlite3-0 \
            fonts-dejavu-core xvfb xauth; } >/dev/null 2>&1 || exit 90
        mkdir /tmp/home
        code=0
        HOME=/tmp/home timeout 10 xvfb-run -a /app >/tmp/out 2>&1 || code=$?
        cat /tmp/out
        # "ready" is printed after the first frame; 124 = still running when stopped
        grep -qx ready /tmp/out && [ "$code" -eq 124 ] || { echo "exit $code"; exit 1; }
    ' || { echo "::error::the app did not start on $image (90: the check could not be set up)"; exit 1; }
done
