#! /bin/bash

rm -rf ~/.config/nvim
cp -rfv ./* ~/.config/nvim
echo "Installed nvim config to ~/.config/nvim"