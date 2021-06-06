#!/usr/bin/env bash

set -e



runwgcf() {

  if [ ! -e "wgcf-account.toml" ]; then
    wgcf register --accept-tos
  fi

  if [ ! -e "wgcf-profile.conf" ]; then
    wgcf generate
  fi
  
  cp wgcf-profile.conf /etc/wireguard/wgcf.conf

  DEFAULT_GATEWAY_NETWORK_CARD_NAME=`route  | grep default  | awk '{print $8}' | head -1`
  DEFAULT_ROUTE_IP=`ifconfig $DEFAULT_GATEWAY_NETWORK_CARD_NAME | grep "inet " | awk '{print $2}' | sed "s/addr://"`
  
  echo ${DEFAULT_GATEWAY_NETWORK_CARD_NAME}
  echo ${DEFAULT_ROUTE_IP}
  
  sed -i "/\[Interface\]/a PostDown = ip rule delete from $DEFAULT_ROUTE_IP  lookup main" /etc/wireguard/wgcf.conf
  sed -i "/\[Interface\]/a PostUp = ip rule add from $DEFAULT_ROUTE_IP lookup main" /etc/wireguard/wgcf.conf



  wg-quick up wgcf
  
  curl --max-time 2  ipinfo.io
  
  echo "OK, wgcf is up."
  while true; do
    sleep 1000000;
  done
  
  
}






if [ -z "$@" ]; then
  runwgcf "$@"
else
  exec "$@"
fi


