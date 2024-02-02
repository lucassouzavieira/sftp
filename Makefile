BUILD:=$(shell git log -1 --pretty=format:"%H")

SSH_PUB_KEY:=$(shell cat ~/.ssh/id_rsa_test.pub)

.PHONY: docker-build
docker-build:
	docker build --platform=linux/amd64 --rm -t lssvieira/sftp:${BUILD} -t lssvieira/sftp:latest .

docker-run:
	docker run --rm -p 22:22 --name sftp-server \
		-e "SFTP_USER=test" -e "SFTP_PASSWD=testpasswd" \
		-e "SFTP_ALLOW_PASSWORD=1" lssvieira/sftp:${BUILD}

docker-bash:
	docker exec -it sftp-server /bin/bash
