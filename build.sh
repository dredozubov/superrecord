#!/bin/bash -e

set -o xtrace

if [ -z "$n" ]; then
  echo "Please set \$n"
  exit 1
fi

rm -f test/Spec.hs.o test/Spec.hs.hi
cpp -DN=$n test/Spec.hs.in > test/Spec.hs
mkdir -p dump-$n
sed -i '/^#/d' test/Spec.hs
$ghc -isrc -itest Spec \
  -XTypeOperators -XKindSignatures -XDataKinds -XFlexibleInstances -XConstraintKinds \
  -XFlexibleContexts -XMultiParamTypeClasses -XTypeFamilies \
  -XOverloadedStrings -XOverloadedLabels -XDeriveGeneric \
  -dumpdir dump-$n $@ >| dump-$n/log 2>&1
