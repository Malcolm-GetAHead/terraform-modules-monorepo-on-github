#!/bin/bash

VERSION=3.2.250

python -m env "$WS_DIR/.cache/checkov"
"$WS_DIR/.cache/checkov/bin/pip" install "checkov==$VERSION"

ln -s "$WS_DIR/.cache/checkov/bin/checkov" "${WS_DIR}/.local/bin"

which checkov
