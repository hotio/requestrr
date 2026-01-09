#!/bin/bash
set -exuo pipefail

version=$(curl -fsSL "https://api.github.com/repos/thomst08/requestrr/releases/latest" | jq -re .tag_name)
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//V/}" \
    '.version = $version' <<< "${json}" | tee VERSION.json
