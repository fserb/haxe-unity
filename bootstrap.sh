#!/bin/bash

set -e

TARGET="$1"

if [ ! -d "$TARGET" ]; then
  echo "Invalid target path: $TARGET"
  exit 1
fi

mkdir -p $TARGET/Assets/src
cp -f project/Assets/src/build.sh $TARGET/Assets/src/
chmod +x $TARGET/Assets/src/build.sh

mkdir -p $TARGET/Assets/Editor
cp -f project/Assets/Editor/Autorun.cs $TARGET/Assets/Editor/
