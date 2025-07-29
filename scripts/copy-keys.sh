#!/bin/bash

set -e

USER="ansible-user"
FILE="servers.txt"

if [ ! -f $FILE ]; then
    echo "$FILE not found!"
    exit 1
fi

while IFS= read -r server; do
    echo "copying key to: $server"
    ssh-copy-id "$USER@$server" -o StrictHostKeyChecking=no
done < "$FILE"

echo "key distribution done!"
