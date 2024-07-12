#!/bin/bash

# Get the script folder
script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

# Get project root folder
rootfolder=$(dirname "$script_dir")

current_project_name=prova

if [ -z "$1" ];
    then
    # Get project name from the user
        echo "Insert the name of the business solution"
        read parametro
        if [[ -z "$parametro" ]]; then
            echo "Invalid name or not provided"
            exit 1
        fi
else
    parametro=$1
fi

substitution=s/$current_project_name/$parametro/g

echo "Replacing all occurences of $current_project_name inside '$rootfolder' with $parametro"

read -p "Are you sure you want to continue? (y/n) " conferma

if [[ $conferma =~ ^[Yy]$ ]]; then
  find $rootfolder -type f ! -path "$script_path" ! -path "*/.git/*" ! -path "*/dist/*" ! -path "*/resources/*" ! -path "*/node_modules/*"  -exec sed -i "$substitution" {} +
  # Function to rename recursively files and folders
  rename_occurrences() {
    local dir="$1"
    find "$dir" -depth -name "*$current_project_name*" | while read path; do
      new_path=$(echo "$path" | sed "$substitution")
      if [ "$path" != "$new_path" ]; then
        mv "$path" "$new_path"
      fi
    done
  }

  # Renaming file and folders
  rename_occurrences "$rootfolder"

  # Renaming rootfolder
  parent_dir=$(dirname "$rootfolder")
  new_rootfolder="$parent_dir/$parametro"

  if [ "$rootfolder" != "$new_rootfolder" ]; then
    mv "$rootfolder" "$new_rootfolder"
    echo "Root folder renamed to '$new_rootfolder'"
  fi

   # Deleting template .git folder
  if [ -d "$rootfolder/.git" ]; then
    rm -rf "$rootfolder/.git"
    echo ".git folder removed"
  fi
  echo "Replacing finished!"
else
  echo "Replacing canceled."
fi

