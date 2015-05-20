FROM ubuntu-debootstrap:14.04

ENV APP_VERSION 1.8.0-0

RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -qy wget && \
    wget -q --no-check-certificate https://downloads.bitnami.com/files/download/nginxstandalonestack/bitnami-nginxstandalonestack-${APP_VERSION}-linux-x64-installer.run -O /tmp/installer.run && \
    chmod +x /tmp/installer.run && \
    /tmp/installer.run --mode unattended --prefix /opt/bitnami && \
    rm /opt/bitnami/ctlscript.sh /opt/bitnami/use_nginxstandalonestack && \
    DEBIAN_FRONTEND=noninteractive apt-get --purge autoremove -qy wget && apt-get clean && rm -rf /var/lib/apt && rm -rf /var/cache/apt/archives/*

RUN mv /opt/bitnami/nginx/conf /opt/bitnami/nginx/conf.defaults && \
 ln -s /opt/bitnami/nginx/conf/ /config && \
 ln -s /opt/bitnami/nginx/logs/ /logs


ENV PATH /opt/bitnami/nginx/sbin:/opt/bitnami/common/bin:$PATH

EXPOSE 80 443
VOLUME ["/logs", "/config"]

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]