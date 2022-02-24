#!/bin/bash
# rsync incremental backup script

#set -o errexit
set -o nounset

#exec 2>&1

# Directory to backup
readonly SOURCE_DIR="/home/phil"
# Receiver information
readonly REMOTE_HOST="fefnir"
readonly REMOTE_USER="root"
readonly REMOTE_DIR="/backup/nidhogg"
# Receiver complete path
readonly TARGET_DIR="${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}"
# SSH identity file
readonly IDENTITY="/home/phil/.ssh/id_fefnir"
# rsync filter ("--files-from" option)
readonly FILTER_FILE="/usr/local/etc/backup-fefnir/rsync-filter"

# Check if identity file actually exists
if ! test -e ${IDENTITY}; then
    echo "Identity file ${IDENTITY} does not exist. Aborting..."
    exit 1
fi

eval "$(ssh-agent)" >/dev/null
ssh-add -q ${IDENTITY}

# Check if the remote host is up and reachable
if ! ping -q -c 1 -W 20 ${REMOTE_HOST} >/dev/null; then
    echo "Remote host ${REMOTE_HOST} unreachable. Aborting..."
    exit 1
fi

# Check if remote target path actually exists
if ! ssh "${REMOTE_USER}@${REMOTE_HOST}" -- "test -e ${REMOTE_DIR}"; then
    ssh "${REMOTE_USER}@${REMOTE_HOST}" -- "mkdir -p ${REMOTE_DIR}"
fi

# rsync options:
# --archive, -a: archive mode; equals -rlptgoD (no -H,-A,-X)
#	--recursive: recurse into directories
#	--links:    copy symlinks as symlinks
#	--perms:    preserve permissions
#	--times:    preserve modification times
#	--group:    preserve group
#	--owner:    preserve owner
#	-D:	    --devices --specials
#	--devices:  preserve device files (super-user only)
#	--specials: preserve special files
# --update, -u:		skip files that are newer on the receiver
#			NOTE: needs an explicit '-r'
# --copy-links, -L:	transform symlink into referent file/dir
# --delete:		delete extraneous files from dest dirs
# --exclude-from=FILE:	read exclude patterns from FILE
if ! rsync -rauL --files-from="${FILTER_FILE}" --delete-before "${SOURCE_DIR}/./" ${TARGET_DIR} --info=progress2; then
    echo "Unexpected error. Aborting..."
    exit 1
fi
