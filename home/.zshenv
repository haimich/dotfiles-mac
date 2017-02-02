source "$HOME/.homesick/repos/homeshick/homeshick.sh"

keyAgent() {
  ssh-add ~/.ssh/github_id_rsa
}

box () {
  pwd=$(pwd)
  cd $HOME/dev/vbox/vb
  if [ -z $@ ] || [[ $@ == 'up' ]]; then
    vagrant up
    mountSSHFS
    portForwarding 'enable'
  else
    vagrant $@
  fi

  if [[ "$subcommand" == 'halt' ]] || [[ "$subcommand" == 'destroy' ]] || [[ "$subcommand" == 'reload' ]]; then
    umount localhost:/home
    portForwarding 'disable'
  fi
  cd $pwd
}

portForwarding () {
  if [[ ! "$@" == 'disable' ]] && [[ ! "$@" == 'enable' ]]; then
    echo "$0 <enable/disable>"
    return
  fi

  if [[ "$@" == 'disable' ]]; then
    echo '==> Removing Port Forwarding'
    sudo pfctl -df /etc/pf.conf -q > /dev/null 2>&1;
  elif [[ "$@" == 'enable' ]] && ! sudo pfctl -q -s nat | grep "127.0.0.1 port = 80 -> 127.0.0.1 port 9080" > /dev/null; then
    echo "==> Fowarding Ports: 80 -> 9080, 443 -> 9443"
    echo "rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 80 -> 127.0.0.1 port 9080  
    rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 443 -> 127.0.0.1 port 9443" | sudo pfctl -q -f - > /dev/null 2>&1
    sudo pfctl -q -e;
  fi
}

# Mount VBox folder via Samba
__deprecated_mountBox () {
  #volume="//$USER@127.0.0.1:8445/$USER"
  volume="//$USER:blafasel@192.168.1.2/$USER"
  if ! mount|grep "$volume" > /dev/null; then
    mkdir -p /Volumes/devel
    echo "Mounting devel"
    mount_smbfs $volume /Volumes/devel
  fi
}

# Mount VBox folder via ssh fs
mountSSHFS () {
  mkdir -p /Volumes/devel_sshfs
  sshfs -p 2222 localhost:/home /Volumes/devel_sshfs
}

unmountSSHFS () {
  umount -f localhost:/home
}


code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

vb () {
  ssh -p 2222 127.0.0.1 ;
}
