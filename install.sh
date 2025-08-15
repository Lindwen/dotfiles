#!/bin/bash

sudo apt update
sudo apt install zsh git curl lsd btop tmux vim bat -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s "$(command -v zsh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
cat <<'EOF' > "$ZSH_CUSTOM/aliases.zsh"
alias ls='lsd -lah'
alias cls='clear'
EOF
sed -i '/^# HIST_STAMPS="mm\/dd\/yyyy"/a HIST_STAMPS="%d-%m-%Y %H:%M:%S"' ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
sed -i 's/^plugins=(\(.*\))/plugins=(\1 docker zsh-autosuggestions zsh-syntax-highlighting zsh-bat you-should-use)/' ~/.zshrc
source ~/.zshrc
