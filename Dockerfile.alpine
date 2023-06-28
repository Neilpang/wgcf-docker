FROM alpine:3.17


RUN apk update -f \
  && apk --no-cache add -f \
  curl ca-certificates \
  iproute2 net-tools iptables \
  wireguard-tools openresolv \
  && rm -rf /var/cache/apk/*
  
  
RUN curl -fsSL git.io/wgcf.sh | bash && mkdir -p /wgcf

WORKDIR /wgcf

VOLUME /wgcf


COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]


