#!/bin/sh

basedir="$(dirname "$0")"
[ "$(echo "$basedir" | cut -c1)" = '/' ] || basedir="$PWD/$basedir"

basedir="$basedir/.."

set -e

if ! [ -x "$basedir/pilc-bootstrap.sh" ]; then
	echo "basedir sanity check failed"
	exit 1
fi

cd "$basedir"

rm -f "$basedir"/*.html

find "$basedir/deb" \( \
	\( -name '*.debhelper' \) -o \
	\( -name '*.log' \) -o \
	\( -name '*.substvars' \) -o \
	\( -name 'debhelper-build-stamp' \) \
       \) -print0 | xargs -0 rm -Rf

for pkg in "$basedir/deb/pilc-system"; do
	rm -f "$pkg/debian/files"
	rm -Rf "$pkg/debian/pilc-system"
	rm -f "$pkg"*.deb
	rm -f "$pkg"*.build
	rm -f "$pkg"*.buildinfo
	rm -f "$pkg"*.changes
	rm -f "$pkg"*.dsc
	rm -f "$pkg"*.tar.xz
done
