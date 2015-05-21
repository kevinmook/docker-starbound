#!/bin/bash
set -e

if [[ ! -f /data/steam/starbound_server/appmanifest_211820.acf ]]; then
  mkdir -p /data/steam/starbound_server
  chown -R starbound:starbound /data/steam

  echo "Execute these commands in steamcmd:"
  echo "> login <your_account>"
  echo "enter your pw (warning: will be visible)"
  echo "enter your steamguard (if applicable)"
  echo "> force_install_dir /data/steam/starbound_server"
  echo "> app_update 211820"
  echo "> exit"
  /sbin/setuser starbound /home/starbound/steamcmd/steamcmd.sh
fi
