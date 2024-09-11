#!/bin/bash
GITHUB_OUTPUT=ex_output.txt
  declare -a tf_lint
  rtn_chk=0
  
  which tflint
  
  while read -r tf_dir; do
    if [ -d "$tf_dir" ]; then
      rtn_val="$(tflint -c "/home/runner/work/terraform-modules-monorepo-on-github/terraform-modules-monorepo-on-github/.github/dependencies/tflint.hcl" -f compact --force --call-module-type=none --no-color --chdir "${tf_dir}" 2>&1 || true)"
      tf_lint+=("$rtn_val")
    else
      tf_lint+=("Unable to check directory: '${tf_dir}'")
    fi
  done <<< 'test-module
  test-module1'
  
  output=$(printf "%s\n" "${tf_lint[@]}")
  
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
