#!/bin/bash

declare -a tf_fmt
exit_code=0
while read -r tf_dir; do
  tf_fmt+=(terraform fmt -write=false -diff -check -no-color "$tf_dir")
  rtn_chk=$?
  if [ "$rtn_chk" -gt "$exit_code" ]; then exit_code=$rtn_chk; fi
done <<<  '
a
b
c
d
e
f
g'
