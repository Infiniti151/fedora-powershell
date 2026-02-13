#!/usr/bin/env bash

# Color codes
TEAL="\033[36m"
GREEN="\033[32m"
RESET="\033[0m"

copy_completions(){
    mkdir -p $1
    cp ./completions/$2 $1
}

set_completions(){
    echo -e "${TEAL}Setting up completions for PowerShell...${RESET}"

    #Bash
    copy_completions $HOME/.local/share/bash-completion/completions pwsh

    #Fish
    if [[ $(command -v fish) ]]; then
        copy_completions $HOME/.config/fish/completions pwsh.fish
    fi

    #Zsh
    if [[ $(command -v zsh) ]]; then
        copy_completions $HOME/.zsh/completions _pwsh
        grep -Fxq "fpath=(~/.zsh/completions \$fpath)" $HOME/.zshrc || sed -i '1i fpath=(~/.zsh/completions $fpath)\nautoload -Uz compinit\ncompinit\n' $HOME/.zshrc
        rm -f $HOME/.zcompdump*
    fi

    echo -e "${GREEN}Done!${RESET}"
}

platest=$(curl -s https://api.github.com/repos/PowerShell/PowerShell/releases/latest | grep -oP '"tag_name":\s*"v\K[^"]+')

if [[ -z $(command -v pwsh) ]] || [[ $(pwsh --version | awk '{print $2}') != "$platest" ]]; then
    if [[ -z $(command -v pwsh) ]]; then
        echo -e "${TEAL}Installing PowerShell $platest...${RESET}"
    else
        echo -e "${TEAL}Updating PowerShell to $platest...${RESET}"
    fi
    sudo dnf in https://github.com/PowerShell/PowerShell/releases/download/v$platest/powershell-$platest-1.rh.x86_64.rpm
    set_completions
else
    echo -e "PowerShell is at the latest version (${GREEN}$platest${RESET})"
fi
