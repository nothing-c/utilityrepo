#!/bin/sh

if $1 == "help" do
  echo "Procedure for setting proxy (bash):\nAdd this line to the /etc/profile file: export HTTP(S)_PROXY http(s)://proxyname/IP:portnum"
done

echo "Proxies as of " date

wget syps.one/en/ > dailyprox.html

lynx dailyprox.html
