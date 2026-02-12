#!/usr/bin/env bash

platest=$(curl -s https://api.github.com/repos/PowerShell/PowerShell/releases/latest | grep -oP '"tag_name":\s*"v\K[^"]+')
if [[ -z $(command -v pwsh) ]] || [[ $(pwsh --version | awk '{print $2}') != "$platest" ]]; then
    sudo dnf in https://github.com/PowerShell/PowerShell/releases/download/v$platest/powershell-$platest-1.rh.x86_64.rpm
else
    echo -e "Powershell is at the latest version (\033[32m$platest\033[0m)"
fi
