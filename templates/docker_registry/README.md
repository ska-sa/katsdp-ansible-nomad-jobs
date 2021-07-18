# Docker Registry Services
## Docker Registry Proxy
### See upstream for more details
https://github.com/rpardini/docker-registry-proxy

### To make use of the docker-registry proxy
Perform the following on each host
#### Configure Docker
```
mkdir -p /etc/systemd/system/docker.service.d
cat << EOD > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://docker-registry-proxy.service.consul:3128/"
Environment="HTTPS_PROXY=http://docker-registry-proxy.service.consul:3128/"
EOD
systemctl daemon-reload
```

#### Load certificate
```
curl http://docker-registry-proxy.service.consul:3128/ca.crt > /usr/share/ca-certificates/docker_registry_proxy.crt
echo "docker_registry_proxy.crt" >> /etc/ca-certificates.conf
update-ca-certificates --fresh
```
#### Restart Docker
```
systemctl restart docker
```

