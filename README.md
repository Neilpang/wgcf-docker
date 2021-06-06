# wgcf-docker
Wireguard in docker


1. Run single container:

```

docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    -v $(pwd):/wgcf
    neilpang/wgcf-docker


```


2. If aonther container needs to use the wgcf network, run it like:

```

docker run --rm  -it  --network container:wgcf  curlimages/curl curl ipinfo.io

```


3. Docker-compose example:

```

version: "2.4"
services:
  wgcf:
    image: neilpang/wgcf-docker:latest
    volumes:
      - ~/wgcf:/wgcf
    privileged: true
    sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    

  test:
    image: curlimages/curl
    depends_on:
      - wgcf
    command: curl ipinfo.io && sleep 10000
    network_mode: "service:wgcf"
    
    

```