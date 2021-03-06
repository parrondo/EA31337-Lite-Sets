#!/usr/bin/env bash
set -ex
type git
[ $# -ne 2 ] && { echo "Usage: $0 (branch) (message)"; exit 1; }
ROOT="$(git rev-parse --show-toplevel)"
CHK="$1"
MSG="$2"
AUTHOR="EA Tester <kenorb+ea@gmail.com>"

cd "$ROOT"
git checkout -mB "$CHK" master
git add -vA *.txt *.gif *.md
git commit -vm "$MSG" --author="$AUTHOR" -a && git push -fv origin "$CHK"
git checkout master
echo "$0 done."
