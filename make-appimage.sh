#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=PATH_OR_URL_TO_ICON

quick-sharun ./AppDir/bin/*

# Turn the AppDir into an AppImage
quick-sharun --make-appimage

