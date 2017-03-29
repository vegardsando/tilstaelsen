#!/bin/bash

# Execute via: ./set-project-perms.sh PROJECT_NAME
# The paradigm is the entire project dir is owned by $CHOWN_USER with the group set to $CHOWN_GROUP
# $CHOWN_USER is an admin or user account that is used to edit files/templates, etc.
# $CHOWN_GROUP is the group of the webserver (e.g.: 'apache', 'nginx', 'httpd', etc.)
# The project dir permissions are set to 755 (-rwxr-xr-x) for directories and to 644 (-rw-r--r--) for files
# The permissions to $DIRS[] that need to be writeable are set to 775 (-rwxrwxr-x) for directories and
# 664 (-rw-rw-r--) for files.  Add any assets directories, etc. as necessary.
# Change $BASE_DIR to the absolute path where your websites are stored (leaving it appended with '/$1')
# The $1 shell variable is your user parameter PROJECT_NAME

CHOWN_USER="admin"
CHOWN_GROUP="apache"

BASE_DIR="/htdocs/$1"

# Directories & files that should be writeable by the $CHOWN_GROUP

DIRS[0]="$BASE_DIR/craft/app"
DIRS[1]="$BASE_DIR/craft/config"
DIRS[2]="$BASE_DIR/craft/storage"
DIRS[3]="$BASE_DIR/public/assets"

# CHECKING START
if [ -z "$1" ];then
    echo "Please provide project name."
    exit 1
fi
if [ ! -d $BASE_DIR ];then
    echo "Error when fixing file permissions. $BASE_DIR does not exist."
    exit 1
fi
# CHECKING END

ERROR="Not found, did nothing:"

echo "Settings base permissions for the project $BASE_DIR"
chown -R $CHOWN_USER:$CHOWN_GROUP $BASE_DIR
chmod -R 755 $BASE_DIR
find $BASE_DIR -type f -exec chmod 644 {} \;

for DIR in ${DIRS[@]}
    do
        if [ -d $DIR ]
        then
            echo "Fixing permissions for $DIR"
            chmod -R 775 $DIR
            find $DIR -type f -exec chmod 664 {} \;
        else
            echo "$ERROR $DIR\n"
        fi
    done
