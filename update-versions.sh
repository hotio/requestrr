#!/bin/bash
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/thomst08/requestrr/releases/latest" | jq -re .tag_name) || exit 1
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//V/}" \
    '.version = $version' <<< "${json}" | tee VERSION.json
