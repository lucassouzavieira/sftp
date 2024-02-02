# SFTP

SFTP server using OpenSSH. For testing purposes only.

## Usage

```(bash)
	docker run --rm -p 22:22 --name sftp-server \
		-e "SFTP_USER=test" -e "SFTP_PASSWD=testpasswd" \
		-e "PUBLIC_KEY=$(cat ~/.ssh/id_rsa_test.pub)" \
		-e "SFTP_ALLOW_PASSWORD=1" lssvieira/sftp:v1.0.0
```

`PUBLIC_KEY` will added to `/home/$SFTP_USER/.ssh/authorized_keys`, so you can login via SSH using your public key.

You can use `sftp test@localhost` to access the SFTP server.

Options:

* `SFTP_USER`: Name of the SSH/SFTP user
* `SFTP_PASSWD`: Password for the SSH/SFTP user
* `SFTP_PORT`: Port to expose the SSH connection.
* `PUBLIC_KEY`: Your public key contents. This parameter is optional.
* `SFTP_ALLOW_PASSWORD`: Allow to connect by using username/password only. This parameter is optional.
