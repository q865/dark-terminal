#!/bin/sh

# This is a preview script for lf, based on the official examples.
# It uses bat for syntax highlighting, and other tools for other file types.

set -C -f -u
IFS=$'\n'

# Get the absolute path of the preview script's directory
preview_script_dir="$(cd "$(dirname "$0")" && pwd)"

case "$1" in
    *.tar*) tar tf "$1";;
    *.zip) unzip -l "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *.pdf) pdftotext "$1" -;;
    # Use bat for syntax highlighting of text files
    *) 
        if [ -f "$1" ]; then
            bat --color=always --style=numbers --line-range=:500 "$1"
        elif [ -d "$1" ]; then
            # Use ls or exa if available for directory previews
            ls -lA --color=always "$1"
        fi
        ;; 
esac