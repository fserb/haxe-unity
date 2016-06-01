#!/bin/bash

set -e

TARGET="$1"

if [ ! -d "$TARGET" ]; then
  echo "Invalid target path: $TARGET"
  exit 1
fi

mkdir -p $TARGET/src
cp -f project/src/build.sh $TARGET/src/
chmod +x $TARGET/src/build.sh

mkdir -p $TARGET/Assets/Editor
cp -f project/Assets/Editor/Autorun.cs $TARGET/Assets/Editor/
