#!/usr/bin/env bash

set -e

LOGIN="$1"
MAIL="$2"

if [ -z "$LOGIN" ] || [ -z "$MAIL" ]; then
	echo "Usage:"
	echo "  ./scripts/install.sh yourLogin yourLogin@student.42.fr"
	echo
	echo "Example:"
	echo "  ./scripts/install.sh marvin marvin@student.42.fr"
	exit 1
fi

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$HOME/.vim42/plugin"

cp "$REPO_DIR/plugin/stdheader.vim" "$HOME/.vim42/plugin/stdheader.vim"

sed \
	-e "s/let g:user42 = 'yourLogin'/let g:user42 = '$LOGIN'/" \
	-e "s/let g:mail42 = 'yourLogin@student.42.fr'/let g:mail42 = '$MAIL'/" \
	"$REPO_DIR/config/vimrc_42.example" > "$HOME/.vimrc_42"

if [ -n "$ZSH_VERSION" ] || [ "$(basename "$SHELL")" = "zsh" ]; then
	SHELL_RC="$HOME/.zshrc"
else
	SHELL_RC="$HOME/.bashrc"
fi

touch "$SHELL_RC"

if ! grep -q "alias vim42='vim -u ~/.vimrc_42'" "$SHELL_RC"; then
	echo "" >> "$SHELL_RC"
	echo "# vim42 for 42 projects" >> "$SHELL_RC"
	echo "alias vim42='vim -u ~/.vimrc_42'" >> "$SHELL_RC"
fi

echo "vim42 installed successfully."
echo
echo "Installed:"
echo "  ~/.vim42/plugin/stdheader.vim"
echo "  ~/.vimrc_42"
echo
echo "Alias added to:"
echo "  $SHELL_RC"
echo
echo "Reload your shell:"
echo "  source $SHELL_RC"
echo
echo "Use:"
echo "  vim42 main.c"
