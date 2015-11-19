code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}
vb () { ssh -p 2222 127.0.0.1 ;}

export PATH=$PATH:~/bin
