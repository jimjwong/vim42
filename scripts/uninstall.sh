#!/usr/bin/env bash

set -e

rm -f "$HOME/.vimrc_42"
rm -f "$HOME/.vim42/plugin/stdheader.vim"

for SHELL_RC in "$HOME/.zshrc" "$HOME/.bashrc"; do
	if [ -f "$SHELL_RC" ] && grep -q "alias vim42=" "$SHELL_RC"; then
		if sed --version >/dev/null 2>&1; then
			sed -i "/alias vim42=/d" "$SHELL_RC"
		else
			sed -i '' "/alias vim42=/d" "$SHELL_RC"
		fi
	fi
done

echo "vim42 removed."
echo "Reload your shell: source ~/.zshrc"
