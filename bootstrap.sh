#!/bin/bash
set -eu

### Install homeshick ###
if [ ! -d $HOME/.homesick/repos/homeshick ]; then
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi
source $HOME/.homesick/repos/homeshick/homeshick.sh

### Deploy dotfiles ###
homeshick clone --batch git@github.com:haimich/dotfiles.git

### Link it all to $HOME ###
homeshick link
