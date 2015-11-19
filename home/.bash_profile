code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
vb () { ssh -p 2222 127.0.0.1 ;}

source ~/.homesick/repos/homeshick/homeshick.sh

# Adding ssh keys
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/github

export PATH=$PATH:~/bin
