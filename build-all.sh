#!/bin/bash -ex

set -o xtrace

args="-O1 -v -dverbose-core2core -ddump-to-file -ddump-simpl-stats -dsuppress-idinfo -dsuppress-coercions -dshow-passes -ddump-ds"

for i in $(seq $m $n); do
    n=$i ./build.sh $args $@
    rm -Rf dump-$i/test/Spec-core2core.split || true
    ./split-core2core.py dump-$i/test/Spec.verbose-core2core
done
