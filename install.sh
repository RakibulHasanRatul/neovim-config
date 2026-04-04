#! /bin/bash

rm -rf ~/.config/nvim ~/.local/share/nvim
mkdir -p ~/.config/nvim
tar -C $pwd --exclude '.git' \
	--exclude install.sh \
	--exclude README \
	--exclude preview.png \
	--exclude LICENSE.md \
	-cf - . | tar -C ~/.config/nvim -xfv -
echo "Installed nvim config to ~/.config/nvim"
