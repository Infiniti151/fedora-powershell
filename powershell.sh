#!/usr/bin/bash

install() {
    sudo dnf in https://github.com/PowerShell/PowerShell/releases/download/v$platest/powershell-$platest-1.rh.x86_64.rpm
}

platest=$(git ls-remote -t https://github.com/PowerShell/PowerShell.git | awk -e '$2 ~ /v[0-9]*.[0-9]*.[0-9]*$/ {sub(/refs\/tags\/v/,"");print $2}' | sort -V | awk 'END {print}')
[[ -z $(command -v pwsh) ]] && install && exit
pver=$(pwsh --version | awk '{print $2}') 
if [[ "$pver" = "$platest" ]];then
    echo -e "Powershell is at the latest version (\033[32m$platest\033[0m)" 
else
    install
fi