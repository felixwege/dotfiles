#!/bin/bash

# get directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
OLDDIR=$DIR/old

# name of all dotfiles
FILES="
    .config/i3/config
    .config/termite/config
    .fehbg
    .xinitrc
    .Xresources
    .zshrc
    "

# create dir for old dotfiles
mkdir -p $OLDDIR

for FILE in $FILES; do
    # move old files
    echo "move $FILE into $OLDDIR"
    mv $HOME/$FILE $OLDDIR
    # create symlinks
    echo "create symlink to $FILE in $HOME"
    ln -s $DIR/$FILE $HOME/$FILE
done

# copy background image
cp $DIR/pictures/arch.png $HOME/Pictures/arch.png
