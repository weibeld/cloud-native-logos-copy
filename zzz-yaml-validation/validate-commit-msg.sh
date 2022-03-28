#!/bin/bash

commit=${1:-HEAD}
file=$(mktemp -d)/tmp.yaml
git log --format=%B -n 1 "$commit" | sed -n '/^---$/ { :a; n; p; ba; }' >"$file"
echo -e "Validating commit $commit:\n---"
cat "$file"
ajv validate -s .schemas/commit-message.schema.json -d "$file"

