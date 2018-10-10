#!/bin/bash

## Shell Opts ----------------------------------------------------------------
# Exit on any non-zero exit code
set -o errexit

# Exit on any unset variable
set -o nounset

# Pipeline's return status is the value of the last (rightmost) command
# to exit with a non-zero status, or zero if all commands exit successfully.
set -o pipefail

## Variables -----------------------------------------------------------------
GPG=$(command -v gpg)
BACKUP_DIR="$HOME/gpg_backup"

HOSTNAME=$(hostname -s)
PROGNAME=$(basename "$0")

## Functions -----------------------------------------------------------------
err() {
  echo "$(date +'%Y-%m-%dT%H:%M:%S%z') ${HOSTNAME} ${PROGNAME}[$$]: $*" >&2
}

log() {
  echo "$(date +'%Y-%m-%dT%H:%M:%S%z') ${HOSTNAME} ${PROGNAME}[$$]: $*" >&2
}

## Main ----------------------------------------------------------------------
if [ $# -ne 1 ]; then
  err "Missing GPG Key Email Argument"
  exit 1
fi

for i in "$@"
do
case $i in
  -e=*|--email=*)
    EMAIL="${i#*=}"
    shift
    ;;
  *)
    err "Unknown Argument Provided, Exiting..."
    exit 1
  ;;
esac
done

log "Backing Up $(whoami)'s GPG Key: $EMAIL"

# Check to see if key exists
if ! gpg --list-keys | grep "${EMAIL}" ; then
  err "Unable to find GPG Key for ${EMAIL}"
  exit 1
fi

cd "$HOME"

# Remove Existing Backup Dir if Exists
log "Removing ${BACKUP_DIR} if exists"
[ -d "$BACKUP_DIR" ] && rm -rf "$BACKUP_DIR"

# Create Clean Backup Directory
log "Creating ${BACKUP_DIR}"
mkdir -m 0700 "$BACKUP_DIR"

log "Exporting Ownertrust DB"
if ! $GPG --export-ownertrust > "$BACKUP_DIR/$(whoami)-ownertrust-gpg.txt"; then
  err "Failed to Export Ownertrust DB"
  exit 1
fi
chmod 0400 "$BACKUP_DIR/$(whoami)-ownertrust-gpg.txt"

log "Exporting Public Key"
if ! $GPG --export --armor "$EMAIL" > "${BACKUP_DIR}/${EMAIL}-public-gpg.key"; then
  err "Failed to Export Public Key"
  exit 1
fi
chmod 0400 "$BACKUP_DIR/$EMAIL-public-gpg.key"

log "Exporting Secret Key"
if ! $GPG --export-secret-keys --armor "$EMAIL" > "${BACKUP_DIR}/${EMAIL}-secret-gpg.key"; then
  err "Failed to Export Secret Key"
  exit 1
fi
chmod 0400 "${BACKUP_DIR}/${EMAIL}-secret-gpg.key"

# Compress and Remove Backup Dir
log "Compress ${BACKUP_DIR} and remove ${BACKUP_DIR}"
if ! tar -czf gpg_backup.tar.gz "$BACKUP_DIR"; then
  err "Failed to Compress ${BACKUP_DIR}"
  exit 1
fi
rm -rf "$BACKUP_DIR"
