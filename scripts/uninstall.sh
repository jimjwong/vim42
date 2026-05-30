#!/usr/bin/env bash

set -e

echo "Removing vim42 files..."

rm -f "$HOME/.vimrc_42"
rm -f "$HOME/.vim42/plugin/stdheader.vim"

echo
echo "vim42 files removed."
echo
echo "Optional manual cleanup:"
echo "  1. Open ~/.zshrc or ~/.bashrc"
echo "  2. Remove this line:"
echo "     alias vim42='vim -u ~/.vimrc_42'"
echo
echo "Reload your shell after editing:"
echo "  source ~/.zshrc"
