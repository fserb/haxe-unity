#!/bin/bash

UNITY="/Applications/Unity/Unity.app/Contents/Frameworks/Managed"

export PATH="$PATH:/usr/local/bin"
echo `find . -name \*.hx | sed 's|./||'`

haxe \
  -D no-compilation \
  -net-lib "$UNITY/UnityEngine.dll" \
  -net-lib "$UNITY/UnityEditor.dll" \
  -lib unity \
  -lib vault \
  -cs ../Code $@ \
  `find . -name \*.hx | sed 's|./||'`
