#!/bin/bash
## rhel.sh: initialize new Red Hat Enterprise Linux based container

set -e

help() {
cat << EOF
$0 - initialize new Red Hat Enterprise Linux based container with custom packages and config files.
Usage: $0 [PACKAGES]
    PACKAGES	    extra Red Hat Enterprise Linux packages to install

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
dnf -y upgrade --refresh
dnf -y install epel-release elrepo-release
dnf -y upgrade --refresh
dnf -y install git make vim unzip zip curl openssh-server rsync htop "$@"
dnf -y autoremove

# SSH server
cat > /etc/ssh/sshd_config << "EOF"
#       $OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $
# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

AuthorizedKeysFile	.ssh/authorized_keys

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

systemctl enable sshd.service
systemctl restart sshd.service


# ~/.bashrc aliases
cat >> ~/.bashrc << "EOF"
# Prompt
export PS1="\[\033[38;5;1m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;3m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\]\\$\[$(tput sgr0)\] "
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

EOF

echo "All done!"
