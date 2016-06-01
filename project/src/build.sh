#!/bin/bash

UNITY="/Applications/Unity/Unity.app/Contents/Frameworks/Managed"

echo "working?"

haxe \
  -D no-compilation \
  -net-lib "$UNITY/UnityEngine.dll" \
  -net-lib "$UNITY/UnityEditor.dll" \
  -lib unity \
  -lib vault \
  -cs ../Assets/Code $@ \
  `find . -name \*.hx | sed 's|./||'`
