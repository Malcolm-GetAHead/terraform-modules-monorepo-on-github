#!/bin/bash

VERSION=v0.55.0

curl -sL -o - "$(curl -s "https://api.github.com/repos/aquasecurity/trivy/releases/tags/$VERSION" | jq -r '.assets[] | select(.name | endswith("_Linux-64bit.tar.gz")) | .browser_download_url')" | \
    tar -C "${WS_DIR}/.local/bin" -xzf - trivy

trivy fs --cache-dir "$WS_DIR/.cache/trivy" --download-db-only

which trivy
