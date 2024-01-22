#!/bin/bash

# 提取certificate-authority-data
cat /root/.kube/config | grep "certificate-authority-data" | awk '{print $2}' | base64 -d > ca.crt

# 提取client-certificate-data
cat /root/.kube/config | grep "client-certificate-data" | awk '{print $2}' | base64 -d > client.crt

# 提取client-key-data
cat /root/.kube/config | grep "client-key-data" | awk '{print $2}' | base64 -d > client.key

# 生成认证文件cert.pfx
openssl pkcs12 -export -out cert.pfx -inkey client.key -in client.crt -certfile ca.crt

echo "证书文件已生成：ca.crt、client.crt、client.key、cert.pfx"

