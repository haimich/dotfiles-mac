# Path to your oh-my-zsh installation.
export ZSH=/Users/michmueller/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# cd .. style like in bash
zstyle ':completion:*' special-dirs true

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="false"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Add wisely, as too many plugins slow down shell startup.
plugins=(node npm brew pip composer colored-man-pages sudo common-aliases fabric)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/michmueller/bin:/usr/local/mysql/bin/"
export CDPATH=$CDPATH:~/dev:~/

source $ZSH/oh-my-zsh.sh

# dont ask for confirmation when deleting with rm
setopt localoptions rmstarsilent

# ssh
if [[ `ssh-add -L` == "The agent has no identities." ]]; then
  portForwarding() 
fi

##### KEYBINDINGS #####

# Multiline editing
bindkey '^x' push-line-or-edit

