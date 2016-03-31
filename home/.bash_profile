vb () { ssh -p 2222 127.0.0.1 ;}

source ~/.homesick/repos/homeshick/homeshick.sh

# Adding ssh keys
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/github

export PATH=$PATH:~/bin
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"

# Enable Salsa in Typescript (see https://code.visualstudio.com/updates#vscode)
export VSCODE_TSJS=1
