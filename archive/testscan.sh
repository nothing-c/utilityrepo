#!/bin/sh

#this way is so much simpler and actually works
#direct to a txt file if necessary

#dependencies: auditd (if using auditd), net-tools
#if you want the /etc/ outputs, you have to run as SU
echo "Logged in:"

w

echo "Login History:"

last

echo "Userlist:"

cat /etc/passwd

echo "Sudoers:"

cat /etc/sudoers

echo "Currently running commands:"

ps

#echo "Command history:"

#auditd

echo "Network info:"

netstat
