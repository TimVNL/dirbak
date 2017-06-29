#!/bin/bash
# check if useing latest hombrew tar and rsync on mac
if [ "$(uname -s)" == "Darwin" ]; then
  TAR="/usr/local/bin/tar"
  RSYNC="/usr/local/bin/rsync"
elif [ "$(uname -s)" == "Linux" ]; then
  TAR="/bin/tar"
  RSYNC="/usr/bin/rsync"
fi

# Get script dir and load variables
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
source $SCRIPT_PATH/backup.cfg
echo "
===============================================
$0 $*
===============================================
DATETIME:           $DATETIME
TMP_DIR:            $TMP_DIR
SOURCE_DIR:         $SOURCE_DIR
TARGET_DIR:         $TARGET_DIR
BACKUP_RETENTION:   $BACKUP_RETENTION
BACKUP_PASS:        $BACKUP_PASS
IGNORE_GLOBAL:      $IGNORE_GLOBAL
IGNORE_TAG          $IGNORE_TAG
EXTRA_TAR_OPTIONS:  $EXTRA_TAR_OPTIONS
"

echo "backup running..."
$TAR -cvpzf "$TMP_DIR/dirbak-$DATETIME.tgz" $EXTRA_TAR_OPTIONS --exclude-from=$IGNORE_GLOBAL --exclude-tag-all=$IGNORE_TAG $SOURCE_DIR
if [ ! -f "$BACKUP_PASS" ]; then
  echo "Generating $BACKUP_PASS file"
  openssl rand -hex 32 > $BACKUP_PASS
fi
echo "encrypting archive"
openssl aes-256-cbc -salt -in "$TMP_DIR/dirbak-$DATETIME.tgz" -out "$TMP_DIR/dirbak-$DATETIME.tgz.enc" -k $BACKUP_PASS
echo "copying encrypted archive to $TARGET_DIR"
$RSYNC -zvh "$TMP_DIR/dirbak-$DATETIME.tgz.enc" $TARGET_DIR
echo ""
if [ ! -f "$TARGET_DIR/$dirbak-$DATETIME.tgz.enc" ]; then
  echo "backup missing in $TARGET_DIR. Please check the logs."
else
  echo "backup successful stored @ $TARGET_DIR/dirbak-$DATETIME.tgz.enc"
fi
echo "Cleanup temp files, backups and logs older then $BACKUP_RETENTION days."
rm -rf "/tmp/dirbak-*"
rm -f $(ls -1t $TARGET_DIR/dirbak-* | tail -n +$BACKUP_RETENTION)
rm -f $(ls -1t $HOME/.logs/dirbak-* | tail -n +$BACKUP_RETENTION)
echo "backup of $SOURCE_DIR done @ $DATETIME"
