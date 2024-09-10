#!/bin/bash
GITHUB_OUTPUT=ex_output.txt
declare -a tf_fmt
rtn_chk=0
while read -r tf_dir; do
  tf_fmt+=("$(terraform fmt -write=false -diff -no-color "$tf_dir")")
done <<< 'test-module
test-module1'

output=$(printf "%s\n" "${tf_fmt[@]}")

if [ "$(echo $output | tr -d '\s' | tr -d '\n')" != "" ]; then
  rtn_chk=1
fi

echo "exit=${rtn_chk}"  >> $GITHUB_OUTPUT
echo "output=${output}"  >> $GITHUB_OUTPUT

echo "Output: ${output}"
