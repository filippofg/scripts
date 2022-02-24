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

echo "All done!"
