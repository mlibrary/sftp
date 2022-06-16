#!/bin/bash

#clear out any current ssh keys
rm server/ssh/ssh_*
rm ssh_*


#generate the host ssh keys for the sftp service
ssh-keygen -t ed25519 -f ssh_host_ed25519_key < /dev/null
ssh-keygen -t rsa -b 4096 -f ssh_host_rsa_key < /dev/null


#move the keys into the sftp/ssh directory so they can be picked up
#by docker-compose bind mounts for the sftp service
mv ssh_host_ed25519_key server/ssh/
mv ssh_host_rsa_key server/ssh/
#this seems to be necessary
mv ssh_host_rsa_key.pub .ssh/known_hosts

#remove the unnecessary files
rm ssh_host*

#generate actual host login keys
ssh-keygen -t rsa -b 4096 -f ssh_client_rsa_key < /dev/null

mv ssh_client_rsa_key.pub server/ssh/
mv ssh_client_rsa_key server/ssh/
