#!/bin/bash
set -e

sudo apt update
sudo apt install -y zsh git curl lsd btop tmux vim bat fzf zoxide

sudo chsh -s "$(command -v zsh)" "$USER"

RUNZSH=no zsh -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
sed -i 's|^ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc"

git clone --depth=1 https://github.com/Lindwen/dotfiles.git /tmp/dotfiles

mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

cp -r /tmp/dotfiles/zsh/* "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/"
cp /tmp/dotfiles/.tmux.conf "$HOME/.tmux.conf"
cp /tmp/dotfiles/.vimrc "$HOME/.vimrc"

rm -rf /tmp/dotfiles

git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/fdellwing/zsh-bat.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat"
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use"

sed -i 's/^plugins=(\(.*\))/plugins=(\1 docker zsh-autosuggestions zsh-syntax-highlighting zsh-bat you-should-use)/' "$HOME/.zshrc"

echo -e "\e[32m✅ Installation complete!\e[0m \e[33mRun 'zsh' or restart your session for the changes to take effect.\e[0m"
