#!/bin/bash

export existing_envs=$(printenv | awk -F= '{print $1}' | sed 's/^/\$/g' | paste -sd,);
js_files=$(find $PWD -type f -name "*.js")
IFS=',' read -r -a VAR_ARRAY <<< "$existing_envs"

for file in $js_files; do
  for var in "${VAR_ARRAY[@]}"; do
    var_name="${var:1}"
    var_value=$(printenv "$var_name")
    sed -i "s|$var|$var_value|g" "$file"
  done
done

nginx -g 'daemon off;'
