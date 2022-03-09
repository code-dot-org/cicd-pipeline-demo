#!/bin/sh -xe

mkdir -p dist
cp -r src/* dist

# sed works differently in OSX vs Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' 's/❌/✅/' ./dist/index.html
else
  sed -i 's/❌/✅/' ./dist/index.html
fi
