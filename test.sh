#!/bin/bash
GITHUB_OUTPUT=ex_output.txt
# declare -a tf_fmt
# rtn_chk=0
# while read -r tf_dir; do
#   tf_fmt+=("$(terraform fmt -write=false -diff -no-color "$tf_dir")")
# done <<< 'test-module
# test-module1'

# output=$(printf "%s\n" "${tf_fmt[@]}")

# if [ "$(echo $output | tr -d '\s' | tr -d '\n')" != "" ]; then
#   rtn_chk=1
# fi

# echo "exit=${rtn_chk}"  >> $GITHUB_OUTPUT
# echo "output=${output}"  >> $GITHUB_OUTPUT

# echo "Output: ${output}"


# declare -a tf_val
# rtn_chk=0
# init_dir=$(pwd)

# while read -r tf_dir; do
#   if [ -d "$init_dir/$tf_dir" ]; then
#     cd "$init_dir/$tf_dir" || exit 1
  
#     rtn_val="$(terraform validate -no-color || true)"
#     if ! grep -q 'The configuration is valid' <<< "$rtn_val"; then
#       tf_val+=("$rtn_val")
#     fi
#   else
#     tf_val+=("Unable to check directory: '${tf_dir}'")
#   fi
# done <<< 'test-module
# test-module1'

# output=$(printf "%s\n" "${tf_val[@]}")

# if [ "$(echo "$output" | tr -d '\s' | tr -d '\n')" != "" ]; then
#   rtn_chk=1
# fi

# echo "exit=${rtn_chk}"  >> "$GITHUB_OUTPUT"
# {
#   echo "output<<EOF"
#   echo "$output"
#   echo "EOF"
# }  >> "$GITHUB_OUTPUT"

# echo "Exit: ${rtn_chk}"
# echo "Output: ${output}"


declare -a tf_val
rtn_chk=0
init_dir=$(pwd)

while read -r tf_dir; do
  if [ -d "$init_dir/$tf_dir" ]; then
    cd "$init_dir/$tf_dir" || exit 1
  
    rtn_val="$(terraform validate -no-color 2>&1 || true)"
    if ! grep -q 'The configuration is valid' <<< "$rtn_val"; then
      tf_val+=("$rtn_val")
    fi
  else
    tf_val+=("Unable to check directory: '${tf_dir}'")
  fi
done <<< 'test-module
test-module1'

output=$(printf "%s\n" "${tf_val[@]}")

if [ "$(echo "$output" | tr -d '\s' | tr -d '\n')" != "" ]; then
  rtn_chk=1
fi

echo "exit=${rtn_chk}"  >> "$GITHUB_OUTPUT"
{
  echo "output<<EOF"
  echo "$output"
  echo "EOF"
}  >> "$GITHUB_OUTPUT"

echo "Exit: ${rtn_chk}"
echo "Output: ${output}"
