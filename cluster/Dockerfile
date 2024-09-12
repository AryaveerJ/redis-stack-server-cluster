# Use an official Ubuntu base image
FROM ubuntu:22.04

# Install necessary packages and Redis Stack
RUN set -e && apt-get update && apt-get install -y \
    lsb-release \
    curl \
    gpg \
    procps \
    && curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg \
    && chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list \
    && apt-get update && apt-get install -y redis-stack-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create an app directory
RUN mkdir /app

# COPY Redis conf files
COPY redis1.conf redis2.conf redis3.conf /app/

# COPY the start.sh script
COPY start.sh /app/start.sh 

# Make start.sh executable
RUN chmod +x /app/start.sh

# Expose Redis ports
EXPOSE 6379
EXPOSE 6380
EXPOSE 6381

# Set the entrypoint to start.sh with the default action create-cluster
ENTRYPOINT ["/app/start.sh", "create-cluster"]
