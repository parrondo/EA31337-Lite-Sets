#!/usr/bin/env bash
# Initialize variables and settings.
: ${1?"Usage: $0 (dir)"} || exit 1
set -ex
cd -P -- "$(dirname -- "$0")" && pwd -P
ROOT="$(git rev-parse --show-toplevel)"

# Find, parse configuration and run the tests.
find "$ROOT/$1" -type f -name "test.ini" -print0 | while IFS= read -r -d '' file; do
  . <(grep = "$file" | sed "s/;/#/g") # Load ini values.
  dir="$(dirname "$file")"
  for curr_deposit in ${deposits[@]}; do
    for curr_year in ${years[@]}; do
      for curr_bt_source in ${bt_sources[@]}; do
        for curr_spread in ${spreads[@]}; do
          report_name="${pair}-${curr_deposit}${currency}-${curr_year}year-${curr_spread}spread-${curr_bt_source}"
          run_backtest.sh -x -v -t -e $name -f "$dir/$setfile" -c $currency -p $pair -d $curr_deposit -y $curr_year -s $curr_spread -b $curr_bt_source -r "$report_name" -D "$dir"
        done
      done
    done
  done
done
