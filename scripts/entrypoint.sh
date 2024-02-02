#!/bin/bash

# SFTP group
addgroup sftp

# Create user and set necessary permissions
useradd -m $SFTP_USER -s /bin/bash -g sftp -g root -G sudo
echo "$SFTP_USER:$SFTP_PASSWD" | chpasswd

chmod 700 "/home/$SFTP_USER"

mkdir "/home/$SFTP_USER/.ssh/"
mkdir "/home/$SFTP_USER/.ssh/keys"
touch "/home/$SFTP_USER/.ssh/authorized_keys"

if [ "$PUBLIC_KEY" != "" ]; then
  echo "$PUBLIC_KEY" >> "/home/$SFTP_USER/.ssh/authorized_keys"
fi

# Configure SFTP access
echo "$(cat /config/sshd_config)" >> "/etc/ssh/sshd_config"

if [ "$SFTP_ALLOW_PASSWORD" == "1" ]; then
  echo "PasswordAuthentication yes" >> "/etc/ssh/sshd_config"
fi

# Start SSH server
/usr/sbin/sshd -p $SFTP_PORT -D
