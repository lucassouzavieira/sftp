FROM ubuntu:22.04

LABEL org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.authors="Lucas S. Vieira <lucasvieira@sciencepub.com.br>" \
    org.opencontainers.image.description="Basic SFTP server for testing" \
    org.opencontainers.image.title="SFTP"


RUN mkdir /var/run/sshd
RUN apt-get update && apt-get install -y ssh openssh-server
RUN systemctl enable ssh

ENV SFTP_USER "user"
ENV SFTP_PASSWD "passwd"
ENV PUBLIC_KEY ""
ENV SFTP_PORT 22
ENV SFTP_ALLOW_PASSWORD ""

EXPOSE $SFTP_PORT

COPY scripts/ scripts/
COPY config/ config/

RUN chmod +x scripts/entrypoint.sh

ENTRYPOINT ["scripts/entrypoint.sh"]