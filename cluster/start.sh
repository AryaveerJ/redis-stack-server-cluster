#!/bin/bash

# Define the configuration files
CONF1=/app/redis1.conf
CONF2=/app/redis2.conf
CONF3=/app/redis3.conf

# Define the Redis ports
PORT1=6379
PORT2=6380
PORT3=6381

# Function to initialize Redis servers
init_servers() {
    redis-stack-server "$CONF1" --daemonize yes
    redis-stack-server "$CONF2" --daemonize yes
    redis-stack-server "$CONF3" --daemonize yes
    # Ensure the system allows memory overcommit
    sysctl vm.overcommit_memory=1
    echo "Redis servers initialized."
}

# Function to create a Redis cluster
create_cluster() {
    init_servers
    echo "Sleeping :)"
    sleep 30
    redis-cli --cluster create 127.0.0.1:$PORT1 127.0.0.1:$PORT2 127.0.0.1:$PORT3 --cluster-yes
    echo "Redis cluster created."
}

# Main script
case "$1" in
    init-servers)
        init_servers
        ;;
    create-cluster)
        create_cluster
        ;;
    *)
        echo "Usage: $0 {init-servers|create-cluster}"
        exit 1
        ;;
esac

# Keep the container alive
tail -f /dev/null
