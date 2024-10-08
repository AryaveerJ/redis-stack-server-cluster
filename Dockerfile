# Container image that runs your code
FROM docker:stable

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY start.sh /app/start.sh

RUN chmod +x /app/start.sh

# Code file to execute when the docker container starts up (`start.sh`)
ENTRYPOINT ["/app/start.sh"]