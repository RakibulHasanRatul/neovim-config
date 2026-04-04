#! /bin/bash

rm -rf ~/.config/nvim ~/.local/share/nvim
cp -rfv ./* ~/.config/nvim
echo "Installed nvim config to ~/.config/nvim"