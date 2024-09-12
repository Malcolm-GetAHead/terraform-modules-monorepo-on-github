GITHUB_OUTPUT="ex_output.txt"

  declare -A trivy_scan
  declare -A trivy_ignored
  rtn_chk=0
  
  which checkov
  
  while read -r tf_dir; do
    if [ -d "$tf_dir" ]; then
      rtn_val="$(trivy config --quiet --cache-dir "/home/runner/work/terraform-modules-monorepo-on-github/terraform-modules-monorepo-on-github/.cache/trivy" "${tf_dir}" 2>&1 || true)"
      trivy_ignored["$tf_dir"]="$(echo "$rtn_val" | grep 'Ignore finding' | sed 's/^.*\]/   /g' || true)"
      trivy_scan["$tf_dir"]="$(echo "$rtn_val" | grep -v 'INFO' | sed 's/\(.*\.tf\) (terraform)/<h4>\1 (terraform)<\/h4>/g' | sed 's/^=*$//g' | sed 's/^  [0-9]+ .*//g' || true)"
    else
      trivy_scan["$tf_dir"]="  Unable to check directory"
    fi
  done <<< 'test-module
  test-module1'
  
  output=""
  for key in "${!trivy_scan[@]}"; do
    if [ "$(echo "${trivy_scan[$key]}" | tr -d '\s' | tr -d '\n')" != "" ]; then
      output+="<h3>Module: $key</h3> \n${trivy_scan[$key]}\n\n"
    fi
  done
  ignored=""
  for key in "${!trivy_ignored[@]}"; do
    if [ "$(echo "${trivy_ignored[$key]}" | tr -d '\s' | tr -d '\n')" != "" ]; then
      ignored+="<h3>Module: <u>$key</u></h3> \n<pre>${trivy_ignored[$key]}</pre>\n\n"
    fi
  done
  
  if [ "$(echo "$output" | tr -d '\s' | tr -d '\n')" != "" ]; then
    rtn_chk=1
  fi
  
  echo "exit=${rtn_chk}"  >> "$GITHUB_OUTPUT"
  {
    echo "output<<EOF"
    echo -e "$output"
    echo "EOF"
  
    echo "ignored<<EOF"
    echo -e "$ignored"
    echo "EOF"
  }  >> "$GITHUB_OUTPUT"
  
  echo "Exit: ${rtn_chk}"
  echo -e "Ignored: ${ignored}"
  echo "Output: ${output}"
