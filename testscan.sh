#!/bin/sh

#create output file to check at leisure
touch scanout.txt

#check open ports and connections
#need to install net-tools before using though
netstat > scanout.txt

#who is logged in and for how long
w > scanout.txt

#login history
last > scanout.txt

#list of users
cat /etc/passwd > scanout.txt

#list of sudoers
cat /etc/sudoers > scanout.txt

#command history
cat ~./bash_history > scanout.txt

#currently running commands
ps > scanout.txt

#optional: use auditd for command history
#unknown if this will work because I don't have auditd installed (VM)
#auditd > scanout.txt
