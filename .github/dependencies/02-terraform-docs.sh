#!/bin/bash

VERSION=v0.18.0

curl -sL -o - "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/tags/$VERSION | jq -r '.assets[] | select(.name | endswith("-linux-amd64.tar.gz")) | .browser_download_url')" | \
    tar -C /usr/local/bin -xzf - terraform-docs

which terraform-docs
