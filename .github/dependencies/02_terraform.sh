#!/bin/bash

VERSION=1.9.5

curl -o /tmp/terraform.zip "https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip"
unzip -j -d "${WS_DIR}/.local/bin" terraform.zip
rm tmp/terraform.zip
mkdir "$TF_PLUGIN_CACHE_DIR"
