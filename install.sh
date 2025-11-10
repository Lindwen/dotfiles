#!/bin/bash
set -e

# Install packages
sudo apt update && sudo apt install -y zsh git curl lsd btop tmux vim bat zoxide

# Change shell
sudo chsh -s "$(command -v zsh)" "$USER"

# Install FZF (20251110 - I don't use package manager because the version on Ubuntu 24.04 doesn't work with fzf -zsh)
mkdir -p /tmp/fzf-install
curl -L -o /tmp/fzf-install/fzf-0.66.1-linux_arm64.tar.gz \
  https://github.com/junegunn/fzf/releases/download/v0.66.1/fzf-0.66.1-linux_arm64.tar.gz
tar -xzf /tmp/fzf-install/fzf-install/fzf-0.66.1-linux_arm64.tar.gz
sudo mv /tmp/fzf-install/fzf /usr/local/bin/
sudo chmod +x /usr/local/bin/fzf

# Install OhMyZsh
RUNZSH=no zsh -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Copy custom configurations
git clone --depth=1 https://github.com/Lindwen/dotfiles.git /tmp/dotfiles

mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

cp -r /tmp/dotfiles/zsh/* "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/"
cp /tmp/dotfiles/.tmux.conf "$HOME/.tmux.conf"
cp /tmp/dotfiles/.vimrc "$HOME/.vimrc"
cp /tmp/dotfiles/.zshrc "$HOME/.zshrc"
cp /tmp/dotfiles/.p10k.zsh "$HOME/.p10k.zsh"

rm -rf /tmp/dotfiles

# Install zsh plugins
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/fdellwing/zsh-bat.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-bat"
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use"
git clone --depth=1 https://github.com/Pilaton/OhMyZsh-full-autoupdate.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"

echo -e "\e[32m✅ Installation complete!\e[0m \e[33mRun 'zsh' or restart your session for the changes to take effect.\e[0m"
