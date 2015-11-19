source "$HOME/.homesick/repos/homeshick/homeshick.sh"

box () {
  pwd=$(pwd)
  cd $HOME/dev/vbox/vb
  if [ -z $@ ] || [[ $@ == 'up' ]]; then
    vagrant up
    mountBox
    #portForwarding 'enable'
  else
    vagrant $@
  fi

  if [[ "$subcommand" == 'halt' ]] || [[ "$subcommand" == 'destroy' ]]; then
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
    sudo pfctl -df /etc/pf.conf  -q > /dev/null 2>&1;
  elif [[ "$@" == 'enable' ]] && ! sudo pfctl -q -s nat | grep "127.0.0.1 port = 80 -> 127.0.0.1 port 8080" > /dev/null; then
    echo "==> Fowarding Ports: 80 -> 8080, 443 -> 8443"
    echo "rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 80 -> 127.0.0.1 port 8080  
    rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 443 -> 127.0.0.1 port 8443" | sudo pfctl -q -f - > /dev/null 2>&1
    sudo pfctl -q -e;
  fi
}

mountBox () {
  volume="//$USER@127.0.0.1:8445/$USER"
  if ! mount|grep "$volume" > /dev/null; then
    mkdir -p /Volumes/devel
    echo "Mounting devel"
    mount_smbfs $volume /Volumes/devel
  fi
}

vpn () {
  if [ "$(/opt/cisco/anyconnect/bin/vpn stats | grep '>> state: Disconnected')" ]; then
    /opt/cisco/anyconnect/bin/vpn connect gw-ma-vpn.bs.kae.de.oneandone.net
  else 
    /opt/cisco/anyconnect/bin/vpn disconnect
  fi
}

