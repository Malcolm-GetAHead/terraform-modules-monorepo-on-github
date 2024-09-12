#!/bin/bash

VERSION=1.3.48

python -m venv "$WS_DIR/.cache/terraform-compliance"
"$WS_DIR/.cache/terraform-compliance/bin/pip" install "terraform-compliance==$VERSION"

ln -s "$WS_DIR/.cache/terraform-compliance/bin/terraform-compliance" "${WS_DIR}/.local/bin"

which terraform-compliance
