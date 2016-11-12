#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
FILES=`ls -a $DIR/files`

for f in $FILES; do
    SOURCE="$DIR/files/$f"
    DEST="$HOME/$f"
    #if [ -f $SOURCE ]; then
    if [ ! -e $DEST ]; then
        echo "ln -s $SOURCE $DEST";
        ln -s $SOURCE $DEST;
    fi
    #else
    #fi
done;



