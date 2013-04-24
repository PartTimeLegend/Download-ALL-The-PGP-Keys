#!/bin/bash
URL=$1
DIRPATH=$(echo "$URL" | sed s-ftp://--)
BASEURL=$(echo "$DIRPATH" | cut -d '/' -f1)
wget -r -N $URL
SYMLINKS=$(find $DIRPATH -type l)
for SYMLINK in $SYMLINKS
do
    TARGET=$(readlink $SYMLINK)
    if [ "${TARGET:0:1}" == "/" ]
    then
        URI="ftp://$BASEURL/$(readlink $SYMLINK)"
    else
        URI="ftp://$DIRPATH/$(readlink $SYMLINK)"
    fi
    wget -r -N $URI
done