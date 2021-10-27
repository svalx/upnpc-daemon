#!/bin/bash

HOST=`uname -n`
I=0

while [ -v EXT_PORT$I ];
do
	EXT_PORT="EXT_PORT$I"
       	INT_PORT="INT_PORT$I"
       	PROTO="PROTO$I"
	SERVICE="SERVICE$I"

	upnpc -e "${!SERVICE} on $HOST" -r "${!INT_PORT}" "${!EXT_PORT}" "${!PROTO}"

	I=$(( $I + 1 ))
done
