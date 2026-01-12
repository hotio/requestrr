#!/bin/bash
set -exuo pipefail

version=$(curl -fsSL "https://api.github.com/repos/thomst08/requestrr/releases/latest" | jq -re .tag_name)
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//V/}" \
    '.version = $version' <<< "${json}" | tee meta.json
