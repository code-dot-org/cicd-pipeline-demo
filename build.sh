#!/bin/sh

mkdir dist
cp -r src/* dist

sed -i '' 's/❌/✅/' ./dist/index.html
