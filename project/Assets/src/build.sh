#!/bin/bash

UNITY="/Applications/Unity/Unity.app/Contents/Frameworks/Managed"

export PATH="$PATH:%%HAXEPATH%%"
export NEKOPATH="%%NEKOPATH%%"
export HAXE_STD_PATH="%%HAXESTDPATH%%"

cd ..

haxe \
  -D no-compilation \
  -net-lib "$UNITY/UnityEngine.dll" \
  -net-lib "$UNITY/UnityEditor.dll" \
  -lib unity \
  -lib vault \
  -cp src \
  -cs Code "$@"
