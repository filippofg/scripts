#!/bin/bash
## debian.sh: initialize new Debian-based container

set -e

help() {
cat << EOF
$0 - initialize new Debian-based container with custom packages and config files.
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
apt-get install -y git make vim unzip zip curl openssh-server rsync neofetch htop tmux sudo tree fd-find "$@"
apt-get autoremove -y
apt-get autoclean -y

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

# ~/.bashrc aliases
cat >> ~/.bashrc << "EOF"
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
alias fd='fdfind'

function mkcd {
    mkdir -p -- "$1" && cd -P -- "$1"
}

EOF

cat >> /etc/tmux.conf << "EOF"
# Set prefix keybind to Ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Enable mouse scrolling
set -g mouse on
set -g history-limit 100000
bind -T root WheelUpPane   if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
bind-key p run "wl-paste | tmux load-buffer - ; tmux paste-buffer"
EOF

systemctl restart sshd

echo "All done!"
