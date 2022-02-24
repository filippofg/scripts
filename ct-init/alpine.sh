#!/bin/ash

help() {
cat << EOF
$0 - initalize new Alpine Linux container with custom packages and config files.
Usage: $0 [PACKAGES]
    PACKAGES	    extra Alpine Linux packages to install

EOF
}

# Print help message

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    help
    exit
fi

# Package installation
apk -U upgrade
apk add openssh-server git mae vim unzip zip curl rsync neofetc htop "$@"

rc-update add sshd
rc-service sshd start # may be useless

# ~/.bashrc aliases
cat >> ~/.bashrc << "EOF"
# Prompt
export PS1="\[\033[38;5;1m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\] \\$\[$(tput sgr0)\]"
# ls
export LS_OPTIONS='--color=auto -hF'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias la='ls $LS_OPTIONS -lA'
alias lt='ls $LS_OPTIONS -lt'

# Other useful aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

function mkcd {
    mkdir -p -- "$1" && cd -P -- "$1"
}

[[ ! -f $(which neofetch) ]] || neofetch

EOF

echo "All done!"

