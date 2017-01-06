#!/bin/bash
set -eu

### Install homeshick ###
if [ ! -d $HOME/.homesick/repos/homeshick ]; then
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi
source $HOME/.homesick/repos/homeshick/homeshick.sh

### Link it all to $HOME ###
homeshick link
