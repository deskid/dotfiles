#!/bin/bash

function say {
	str=$1
	echo -e "\033[32m$1\033[0m\n"
}

kcptun_client=$HOME/.kcptun/client_darwin_amd64
say $kcptun_client

${kcptun_client} -l :20000 -r 23.83.248.110:29900 -key "" -crypt none -datashard 10 -parityshard 3 -autoexpire 60 -mode fast2
