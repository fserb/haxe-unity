#!/bin/bash

UNITY="dll"

# export HAXE_STD_PATH="/Users/fserb/haxe/haxe/std"

haxe \
  -D dll \
  -net-lib "$UNITY/UnityEngine.dll" \
  -net-lib "$UNITY/UnityEditor.dll" \
  -lib unity \
  -lib vault \
  -cs code \
  -main ImportAll
