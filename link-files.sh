#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"
FILES=`ls -a $DIR/files`

for f in $FILES; do
    SOURCE="$DIR/files/$f"
    DEST="$HOME/$f"
    if [ ! -e $DEST ]; then
        echo "ln -s $SOURCE $DEST";
        ln -s $SOURCE $DEST;
    else
        echo "Warning: not making link, file already exists: $DEST"
    fi
done;



