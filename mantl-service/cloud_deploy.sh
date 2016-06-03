#!/bin/sh
# Marathon servers to use:
serverlist=(
	"control.demo.aws.mrsmiggins.net"
	"control.metapod.mrsmiggins.net"
)

# Username
username="admin"

# Password (get from input)
echo 'Enter password:'
read -sr password


for server in ${serverlist[@]}; do
	./launch.sh -m $server -u $username -p $password -c mrsmiggins.json;
done
