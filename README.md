# dirbak

dirbak uses cron, openssl, rsync and tar to make daily backups

## Installation on OS X

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
00  17  *  *  1-5  /Users/<user>/.dirbak/backup.sh > /Users/<user>/.logs/dirbak-$(date +\%Y\%m\%d) 2>&1
```

## Installation on Linux

```bash
# move to dirbak repo to you home folder
git clone git@github.com:TimVNL/dirbak.git ~/.dirbak

# Edit the backup.cfg file
nano ~/.dirbak/backup.cfg

# Make a .logs folder to save logs
mkdir $HOME/.logs

# Make a crontab
crontab -e

# Add the following line and edit it
00  17  *  *  1-5  /Users/<user>/.dirbak/backup.sh > /Users/<user>/.logs/dirbak-$(date +\%Y\%m\%d) 2>&1
```

## Decypt backups

```bash
# Do the following command in the .dirbak folder
./decypt <name-of-encrypted-file> <name-of-decrypted-file> <location-to-tarpass-file>
```
