#! /bin/bash

rm -rfv ~/.config/nvim ~/.local/share/nvim
mkdir -p ~/.config/nvim
tar --exclude '.git' \
	--exclude install.sh \
	--exclude README \
	--exclude preview.png \
	--exclude LICENSE.md \
	--exclude .gitignore \
	-cf - . | tar --verbose -C ~/.config/nvim -xf -
echo "Installed nvim config to ~/.config/nvim"
