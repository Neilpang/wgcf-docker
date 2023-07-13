# wgcf-docker
CloudFlare warp in docker


1. Run a single container:

```

docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    -v /lib/modules:/lib/modules \
    -v $(pwd)/wgcf:/wgcf \
    neilpang/wgcf-docker



The above command will enable both ipv4 and ipv6, you can enable ipv4 or ipv6 only like following:


#enable ipv4 only:



docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    -v /lib/modules:/lib/modules \
    -v $(pwd)/wgcf:/wgcf \
    neilpang/wgcf-docker  -4 



#enable ipv6 only:



docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    -v /lib/modules:/lib/modules \
    -v $(pwd)/wgcf:/wgcf \
    neilpang/wgcf-docker  -6 



```

or:

```
docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    -v /lib/modules:/lib/modules \
    -v $(pwd)/wgcf:/wgcf \
    neilpang/wgcf-docker:alpine





The above command will enable both ipv4 and ipv6, you can enable ipv4 or ipv6 only like following:


#enable ipv4 only:


docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    -v /lib/modules:/lib/modules \
    -v $(pwd)/wgcf:/wgcf \
    neilpang/wgcf-docker:alpine  -4



#enable ipv6 only:


docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    -v /lib/modules:/lib/modules \
    -v $(pwd)/wgcf:/wgcf \
    neilpang/wgcf-docker:alpine  -6




```




2. If another container needs to use the wgcf network, run it like:

```

docker run --rm  -it  --network container:wgcf  curlimages/curl curl ipinfo.io

```


3. Docker-compose example:

```
Enable both ipv4 and ipv6 by default:


version: "2.4"
services:
  wgcf:
    image: neilpang/wgcf-docker:latest
    volumes:
      - ./wgcf:/wgcf
      - /lib/modules:/lib/modules
    privileged: true
    sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    

  test:
    image: curlimages/curl
    network_mode: "service:wgcf"
    depends_on:
      - wgcf
    command: curl ipinfo.io




Enable ipv6 only:

version: "2.4"
services:
  wgcf:
    image: neilpang/wgcf-docker:latest
    volumes:
      - ./wgcf:/wgcf
      - /lib/modules:/lib/modules
    privileged: true
    sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    command: "-6"
    

  test:
    image: curlimages/curl
    network_mode: "service:wgcf"
    depends_on:
      - wgcf
    command: curl ipv6.ip.sb





Enable ipv4 only:



version: "2.4"
services:
  wgcf:
    image: neilpang/wgcf-docker:latest
    volumes:
      - ./wgcf:/wgcf
      - /lib/modules:/lib/modules
    privileged: true
    sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    command: "-4"
    

  test:
    image: curlimages/curl
    network_mode: "service:wgcf"
    depends_on:
      - wgcf
    command: curl ipinfo.io



```

or:

```

Enable both ipv4 and ipv6 by default:



version: "2.4"
services:
  wgcf:
    image: neilpang/wgcf-docker:alpine
    volumes:
      - ./wgcf:/wgcf
      - /lib/modules:/lib/modules
    privileged: true
    sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    

  test:
    image: curlimages/curl
    network_mode: "service:wgcf"
    depends_on:
      - wgcf
    command: curl ipinfo.io

    
    





Enable ipv6 only:



version: "2.4"
services:
  wgcf:
    image: neilpang/wgcf-docker:alpine
    volumes:
      - ./wgcf:/wgcf
      - /lib/modules:/lib/modules
    privileged: true
    sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    command: "-6"
    

  test:
    image: curlimages/curl
    network_mode: "service:wgcf"
    depends_on:
      - wgcf
    command: curl ipv6.ip.sb






Enable ipv4 only:



version: "2.4"
services:
  wgcf:
    image: neilpang/wgcf-docker:alpine
    volumes:
      - ./wgcf:/wgcf
      - /lib/modules:/lib/modules
    privileged: true
    sysctls:
      net.ipv6.conf.all.disable_ipv6: 0
    cap_add:
      - NET_ADMIN
    command: "-4"
    

  test:
    image: curlimages/curl
    network_mode: "service:wgcf"
    depends_on:
      - wgcf
    command: curl ipinfo.io





```
