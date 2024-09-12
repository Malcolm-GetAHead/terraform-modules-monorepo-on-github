declare -A test

test["abc"]=$(terraform-docs markdown table --sort-by required --sort-by name ./test-module)
test["def"]=$(terraform-docs markdown table --sort-by required --sort-by name ./test-module1)
test["ghi"]='"g789h'

# Prepare the input for jq
json=$(for key in "${!test[@]}"; do
  jq -n --arg key "$key" --arg value "${test[$key]}" \
    '{($key): $value}'
done | jq -s 'add')

echo "$json"
