#!/bin/bash

basedir=$(pwd)
nic="ens33"

function replace()
{
   sed -ie "s/$1/$2/g" $3
}

# 提取certificate-authority-data
cadata=$(cat $basedir/ca.crt | base64 | tr -d '\n\r')
echo '\n------\n'
echo $cadata

# 提取client-certificate-data
# cat /root/.kube/config | grep "client-certificate-data" | awk '{print $2}' | base64 -d > client.crt
cedata=$(cat $basedir/client.crt | base64 | tr -d '\n\r')
echo '\n------\n'
echo $cedata

# 提取client-key-data
ckdata=$(cat $basedir/client.key | base64 | tr -d '\n\r')
echo '\n------\n'
echo $ckdata

# 提取Server
server=$(ip a | grep $nic | grep inet | awk '{print$2}' | awk -F"/" '{print$1}')

mkdir /root/.kube/
\cp config /root/.kube/config
replace '#CA_DATA#' $cadata /root/.kube/config
replace '#CE_DATA#' $cedata /root/.kube/config
replace '#CK_DATA#' $ckdata /root/.kube/config
replace '#SERVER#' $server /root/.kube/config
