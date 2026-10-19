#!/usr/bin/env bash
# Builds the APT source Sileo reads into OUT: the .debs, Packages (plain, .gz, .bz2, .xz),
# Release with its checksums, the icon and the home page. Run by the GitHub Action on every
# push; runs on macOS too with `brew install dpkg`.
#
#   scripts/build-index.sh _site
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="${1:-$ROOT/_site}"
rm -rf "$OUT"
mkdir -p "$OUT"
cp -R "$ROOT/debs" "$ROOT/CydiaIcon.png" "$ROOT/index.html" "$OUT/"
cd "$OUT"

dpkg-scanpackages -m debs /dev/null > Packages 2>/dev/null
gzip -9kf Packages
bzip2 -9kf Packages
xz -9kf Packages

{
  echo "Origin: NOxygen59"
  echo "Label: NOxygen59"
  echo "Suite: stable"
  echo "Version: 1.0"
  echo "Codename: ios"
  echo "Architectures: iphoneos-arm iphoneos-arm64"
  echo "Components: main"
  echo "Description: Tweaks personnels de NOxygen59 (iPad Pro M1, iOS 16, rootless)"
  for algo in MD5Sum:md5 SHA256:sha256; do
    echo "${algo%%:*}:"
    for f in Packages Packages.gz Packages.bz2 Packages.xz; do
      echo " $(openssl dgst -"${algo##*:}" -r "$f" | cut -d' ' -f1) $(wc -c < "$f" | tr -d ' ') $f"
    done
  done
} > Release

echo "$(grep -c '^Package:' Packages) paquet(s) dans la source."
