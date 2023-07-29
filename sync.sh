#!/bin/sh

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"

script_dir=$(cd "$(dirname "$0")/files" && pwd)

json_file="config.json"
paths=()

while IFS= read -r path; do
  label=$(jq -r --arg path "$path" '.dotfiles[] | select(.path == $path) | .label' "$json_file")
  abs_path=${path/__config/$XDG_CONFIG_HOME}
  abs_path=${abs_path/__data/$XDG_DATA_HOME}
  abs_path=${abs_path/__cache/$XDG_CACHE_HOME}
  abs_path=${abs_path/__state/$XDG_STATE_HOME}
  abs_path=${abs_path/__home/$HOME}
  paths+=("$label => $abs_path")
done <<EOF
$(jq -r '.dotfiles[] | .path' "$json_file")
EOF

echo "\nDotfiles to sync:"
for path in "${paths[@]}"; do
  echo "* $path"
done

echo "\n"

# Prompt the user to continue
read -p "Continue? [y/n]: " answer

echo "\n"

if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  # Loop again and rsync the paths
  for path in "${paths[@]}"; do
    abs_path=$(echo "$path" | cut -d ' ' -f 3)

    if [ -e "$abs_path" ]; then
      rsync -a --progress "$abs_path" "$script_dir"
    else
      echo "\nSkipping: $abs_path (Path not found)\n"
    fi
  done
  echo "Synced!\n"
else
  echo "Aborted by user.\n"
fi
