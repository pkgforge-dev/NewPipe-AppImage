#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/TeamNewPipe/NewPipe/89d2423692918653134e79a841d96e065175e976/assets/NP%20logo%20v2.svg

quick-sharun ./AppDir/bin/*

# Turn the AppDir into an AppImage
quick-sharun --make-appimage

