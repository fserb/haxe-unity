#!/bin/bash

set -e

TARGET="$1"

if [ ! -d "$TARGET" ]; then
  echo "Invalid target path: $TARGET"
  exit 1
fi

rsync -r project/ $TARGET/

# Add haxe/haxelib binary path to build path.
HP=`dirname $(which haxe)`
sed -i "" -e "s#%%HAXEPATH%%#${HP}#" $TARGET/Assets/src/build.sh
sed -i "" -e "s#%%NEKOPATH%%#${NEKOPATH}#" $TARGET/Assets/src/build.sh
sed -i "" -e "s#%%HAXESTDPATH%%#${HAXE_STD_PATH}#" $TARGET/Assets/src/build.sh
chmod +x $TARGET/Assets/src/build.sh
