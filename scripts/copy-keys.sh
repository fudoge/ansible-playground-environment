#!/bin/bash

set -e

USER="ansible-user"
FILE="servers.txt"

if [ ! -f $FILE ]; then
    echo "$FILE not found!"
    exit 1
fi

while IFS= read -r server || [ -n "$server" ]; do
    server=$(echo "$server" | xargs)
    target="$USER@$server"
    echo "copying key to: $target"
    ssh-copy-id -o StrictHostKeyChecking=no "$target" 
done < "$FILE"

echo "key distribution done!"
