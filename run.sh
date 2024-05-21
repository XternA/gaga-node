#!/bin/sh

echo '
   ____          ____         _   _             _
  / ___|  __ _  / ___|  __ _ | \ | |  ___    __| |  ___
 | |  _  / _` || |  _  / _` ||  \| | / _ \  / _` | / _ \
 | |_| || (_| || |_| || (_| || |\  || (_) || (_| ||  __/
  \____| \__,_| \____| \__,_||_| \_| \___/  \__,_| \___|
'

cd ./apphub-linux* || exit 1

sudo ./apphub service remove
sudo ./apphub service install
sudo ./apphub service start

echo
echo "Bootstrapping 30s timeout..."
sleep 30

sudo ./apphub status
sudo ./apps/gaganode/gaganode config set --token="$TOKEN"
sudo ./apphub restart
sleep 15
sudo ./apphub status
sudo ./apphub log
sudo ./apps/gaganode/gaganode log
echo
echo "Token: $TOKEN"
