# dirbak

dirbak uses cron, openssl, rsync and tar to make daily backups

## installation on MacOS

```bash
# move to dirbak repo to you home folder
git clone git@github.com:TimVNL/dirbak.git $HOME/.dirbak

# Install the latest version of gnu-tar and rsync with Homebrew
brew install gnu-tar rsync --with-default-names

# Edit the backup.cfg file
nano ~/.dirbak/backup.cfg

# Make a .logs folder to save logs
mkdir $HOME/.logs

# Make a crontab
crontab -e

# Add the following line and edit it
00  17  *  *  1-5  /Users/<user>/.dirbak/backup.sh > /Users/<user>/.logs/dirbak-$(date +'%Y%m%d%H%M') 2>&1
```

## installation on Linux

```bash
# move to dirbak repo to you home folder
git clone git@github.com:TimVNL/dirbak.git $HOME/.dirbak

# Edit the backup.cfg file
nano ~/.dirbak/backup.cfg

# Make a .logs folder to save logs
mkdir $HOME/.logs

# Make a crontab
crontab -e

# Add the following line and edit it
00  17  *  *  1-5  /home/<user>/.dirbak/backup.sh > /home/<user>/.logs/dirbak-$(date +'%Y%m%d%H%M') 2>&1
```

## decypt backups

```bash
# Do the following command in the .dirbak folder
./decypt.sh <name-of-encrypted-file> <name-of-decrypted-file> <location-to-tarpass-file>
```
