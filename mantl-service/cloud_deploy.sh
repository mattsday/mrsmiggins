#!/bin/bash
# Marathon servers to use:
serverlist=(
	"control.demo.aws.mrsmiggins.net"
	"control.metapod.mrsmiggins.net"
)

# Username
username="admin"

# App config file
config_file="mrsmiggins.json"

# Password (get from input)
echo 'Enter password:'
read -sr password


for server in ${serverlist[@]}; do
	echo "Deploying to $server";
	output=$(curl -k -X POST -H "Content-Type: application/json" https://$username:$password@$server:8080/v2/apps -d@$config_file 2>/dev/null)
	if [[ $output == *"already exists"* ]]; then
		echo "Failed - application already exists"
	else
		echo "Done";
	fi
done
