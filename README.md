# fedora-powershell
A simple Bash script for installing/updating PowerShell 7 on Fedora. Installs completions for Bash, Fish, and Zsh.

**Note**: Completions don't include -MTA, -STA, and -WindowStyle flags as they don't work in Linux.

## Install PowerShell
```
git clone https://github.com/Infiniti151/fedora-powershell.git
cd fedora-powershell
chmod +x ./powershell.sh
./powershell.sh
```

## Update PowerShell
Run the script again to update PowerShell.

## Run PowerShell
```
pwsh
```
