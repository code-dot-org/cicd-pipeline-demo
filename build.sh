#!/bin/sh -xe

mkdir -p dist
cp -r src/* dist

sed -i '' 's/❌/✅/' ./dist/index.html
