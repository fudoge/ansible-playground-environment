# Ansible Practice Environment with Docker compose

A Simple and repeatable Ansible lab setup using Docker Compose.

> [!WARNING]
> This system does not support systemd,  
> So if you want full access, you have to use vm.

## Overview

This lab creates a basic Ansible environment with the following containers:
- **controller**: Ansible control node (your workspace)
- **server-1**
- **server-2**
- **server-3**

All containers are connected via Docker network that enables DNS-based communication.

## Initial setup

1. Create required directories for bind mount:
    ```bash
    mkdir playbooks
    mkdir controller-ssh
    ```

2. Start the environment:
    ```bash
    docker compose up -d
    ```

3. Access the controller container:
    ```bash
    docker exec -it controller /bin/bash
    ```

4. Generate SSH key pair:
    ```bash
    cd /root/scripts
    ./setup-ssh.sh
    ```

5. Create Ansible config files:
    ```bash
    cd /root/playbooks
    touch ansible.cfg
    touch inventory
    ```

6. Configure them:

    `ansible.cfg` example:
    ```ini
    [defaults]
    inventory = ./inventory
    remote_user = ansible-user
    ask_pass = false

    [privilege_escalation]
    become = true
    become_method = sudo
    become_user = root
    become_ask_pass = false
    ```

    `inventory` example:
    ```plaintext
    [servers]
    server-1
    server-2
    server-3
    ```

## Every time you restart(docker compose up -d)

SSH key distribution is required because servers do not have any persistent volumes.
```bash
docker exec -it controller /bin/bash
cd /root/scripts
./copy-keys.sh
```

## Test setup

In controller:
```yaml
ansible -m ping all
```

## Note

- Default SSH User: `ansible-user`
- Default Password: `1234`
