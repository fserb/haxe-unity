#!/bin/bash

set -e

CSLIBGEN="/usr/local/bin/mono tools/CsLibGen.exe"
UNITY="/Applications/Unity/Unity.app/Contents/Frameworks/Managed"

$CSLIBGEN -o out -s -r dotnet -i $UNITY UnityEngine.dll UnityEditor.dll
