#!/bin/bash

VERSION=v0.53.0

curl -sL -o /tmp/tflint.zip "$(curl -s "https://api.github.com/repos/terraform-linters/tflint/releases/tags/$VERSION" | jq -r '.assets[] | select(.name == "tflint_linux_amd64.zip") | .browser_download_url')" \
  && unzip -qo /tmp/tflint.zip -d "${WS_DIR}/.local/bin" \
  && rm /tmp/tflint.zip

tflint --init -c "${WS_DIR}/.github/dependencies/tflint.hcl"

which tflint
