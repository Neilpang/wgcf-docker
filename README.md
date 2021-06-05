# wgcf-docker
Wireguard in docker


```

docker run --rm -it \
    --name wgcf \
    --sysctl net.ipv6.conf.all.disable_ipv6=0 \
    --privileged --cap-add net_admin \
    neilpang/wgcf-docker


```