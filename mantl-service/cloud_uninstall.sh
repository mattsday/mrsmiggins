#!/bin/bash

[[ -z $MANTL_SERVER_LIST ]] && echo "You should set MANTL_SERVER_LIST" && exit
[[ -z $MANTL_USER_NAME ]] && echo "You should set MANTL_USER_NAME" && exit

app_name=mrsmiggins-website

# Password (get from input)
echo 'Enter password:'
read -sr password

for server in ${MANTL_SERVER_LIST[@]}; do
	echo "Deleting from $server"
	output=$(curl -ksu "$MANTL_USER_NAME:$password" -X DELETE https://$server:8080/v2/apps/$app_name 2>/dev/null)
	if [[ $output == *"does not exist"* ]]; then
		echo "Failed - application does not exist"
	else
		echo "Done";
	fi
done

