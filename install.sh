#! /bin/bash

rm -rf ~/.config/nvim ~/.local/share/nvim
mkdir -p ~/.config/nvim
cp -rfv ./* ~/.config/nvim
echo "Installed nvim config to ~/.config/nvim"