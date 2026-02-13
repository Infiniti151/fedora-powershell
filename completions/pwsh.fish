function _pwsh_completions
    set -l ct (commandline -ct)
    set -l prev (commandline -opc)
    
    set -l opts -Command -CommandWithArgs -ConfigurationFile -ConfigurationName \
                 -CustomPipeName -EncodedCommand -ExecutionPolicy -File -Help \
                 -InputFormat -Interactive -Login -NoExit -NoLogo \
                 -NonInteractive -NoProfile -NoProfileLoadTime -OutputFormat \
                 -SettingsFile -SSHServerMode -Version -WorkingDirectory

    if test (count $prev) -gt 0
        switch (string lower -- $prev[-1])
            case -inputformat -outputformat
                printf "%s\n" Text XML | string match -ri "^$ct.*"
                return
            case -executionpolicy
                printf "%s\n" AllSigned Bypass Default RemoteSigned Restricted Undefined Unrestricted | string match -ri "^$ct.*"
                return
            case -file -settingsfile -configurationfile
                set -l ext "*"
                if test "$prev[-1]" = "-ConfigurationFile"; set ext "pssc"; end
                
                find . -maxdepth 1 -name "$ct*" -type d | string replace -r '([^\/])$' '$1/'
                find . -maxdepth 1 -name "$ct*.$ext" -type f
                return
            case -workingdirectory
                find . -maxdepth 1 -name "$ct*" -type d | string replace -r '([^\/])$' '$1/'
                return
        end
    end

    string match -ri "^$ct.*" -- $opts
end

complete -c pwsh -e
complete -c pwsh -f -a "(_pwsh_completions)"

