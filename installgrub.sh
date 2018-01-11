#!/bin/sh
set -ex

GRUB_PREFIX="${GRUB_PREFIX-${PWD}/grub-bin}"
UNIFONT_VERSION='10.0.05'

brew install mtools xorriso curl git

if [ -d grub ]; then
  (
    cd grub
    git fetch
  )
else
  git clone git://git.savannah.gnu.org/grub.git
fi

(
  cd grub
  ./autogen.sh
)

rm -rf grub-build/
mkdir grub-build/
(
  cd grub-build
  ../grub/configure \
    --disable-werror \
    --with-platform=pc \
    --prefix="$GRUB_PREFIX"
  make
  rm -rf "$GRUB_PREFIX"
  make install
)

mkdir "$GRUB_PREFIX/share/locale"

if [ -d "unifont-${UNIFONT_VERSION}" ]; then
  :
else
  curl -LO http://unifoundry.com/pub/unifont-${UNIFONT_VERSION}/unifont-${UNIFONT_VERSION}.tar.gz
  tar xf unifont-${UNIFONT_VERSION}.tar.gz
fi
"$GRUB_PREFIX"/bin/grub-mkfont \
  -o "$GRUB_PREFIX"/share/grub/unicode.pf2 \
  unifont-${UNIFONT_VERSION}/font/precompiled/unifont-${UNIFONT_VERSION}.ttf
