GITHUB_OUTPUT="ex_output.txt"

   set -o xtrace
  declare -a trivy_scan
  declare -A trivy_ignored
  rtn_chk=0
  
  which trivy
  
  while read -r tf_dir; do
    echo $tf_dir
    if [ -d "$tf_dir" ]; then
      rtn_val="$(trivy config "${tf_dir}" 2>&1 || true)"
      trivy_ignored["$tf_dir"]="$(echo "$rtn_val" | grep 'Ignore finding' | sed 's/^.*\]/   /g')"
      trivy_scan+=("$(echo "$rtn_val" | grep -v 'INFO')")
    else
      trivy_scan+=("Unable to check directory: '${tf_dir}'")
    fi
  done <<< 'test-module
  test-module1'
  
  output=$(printf "%s\n" "${trivy_scan[@]}")
  ignored=""
  for key in "${!trivy_ignored[@]}"; do
    if [ "$(echo "${trivy_ignored[$key]}" | tr -d '\s' | tr -d '\n')" != "" ]; then
      ignored+="Module: $key \n${trivy_ignored[$key]}\n\n"
    fi
  done
  
  if [ "$(echo "$output" | tr -d '\s' | tr -d '\n')" != "" ]; then
    rtn_chk=1
  fi
  
  echo "exit=${rtn_chk}"  >> "$GITHUB_OUTPUT"
  {
    echo "output<<EOF"
    echo "$output"
    echo "EOF"
  
    echo "ignored<<EOF"
    echo -e "$ignored"
    echo "EOF"
  }  >> "$GITHUB_OUTPUT"
  
  echo "Exit: ${rtn_chk}"
  echo "Ignored: ${ignored}"
  echo "Output: ${output}"
