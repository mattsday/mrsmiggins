#!/bin/bash

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
	echo "Deleting from $server"
	output=$(curl -ksu "$username:$password" -X DELETE https://$server:8080/v2/apps/mrsmiggins-matt 2>/dev/null)
	if [[ $output == *"does not exist"* ]]; then
		echo "Failed - application does not exist"
	else
		echo "Done";
	fi
done

