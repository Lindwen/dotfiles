#!/bin/bash
set -e

sudo apt update
sudo apt install -y zsh git curl lsd btop tmux vim bat

sudo chsh -s "$(command -v zsh)" "$USER"

RUNZSH=no zsh -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
sed -i 's|^ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc"

mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
curl -fsSL https://raw.githubusercontent.com/Lindwen/dotfiles/refs/heads/main/aliases.zsh -o "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/aliases.zsh"
curl -fsSL https://raw.githubusercontent.com/Lindwen/dotfiles/refs/heads/main/.tmux.conf -o "$HOME/.tmux.conf"
curl -fsSL https://raw.githubusercontent.com/Lindwen/dotfiles/refs/heads/main/.vimrc -o "$HOME/.vimrc"

sed -i '/^# HIST_STAMPS="mm\/dd\/yyyy"/a HIST_STAMPS="%d-%m-%Y %H:%M:%S"' "$HOME/.zshrc"

git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/fdellwing/zsh-bat.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat"
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use"

sed -i 's/^plugins=(\(.*\))/plugins=(\1 docker zsh-autosuggestions zsh-syntax-highlighting zsh-bat you-should-use)/' "$HOME/.zshrc"

exec zsh
