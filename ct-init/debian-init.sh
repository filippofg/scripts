#!/bin/bash
## debian-init.sh: initialize new Debian container

set -e

help() {
cat << EOF
$0 - initialize new Debian container with custom packages and config files.
Usage: $0 [PACKAGES]
    PACKAGES	    extra Debian packages to install

EOF
}

# Print help message
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    help
    exit
fi

# Root check
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Install common useful packages
apt-get update
apt-get dist-upgrade -y
apt-get install -y git make vim unzip zip curl openssh-server rsync neofetch htop "$@"
apt-get autoremove -y

# SSH server
cat > /etc/ssh/sshd_config << "EOF"
#       $OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $
# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.
Include /etc/ssh/sshd_config.d/*.conf
PermitRootLogin yes
PermitEmptyPasswords no
PasswordAuthentication no
ChallengeResponseAuthentication no
PubKeyAuthentication yes
UsePAM yes
PrintMotd no
X11Forwarding no
AcceptEnv LANG LC_*
Subsystem	sftp	/usr/lib/openssh/sftp-server
EOF

systemctl restart ssh.service

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
