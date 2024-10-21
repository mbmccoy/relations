#!/bin/bash

# Check if UID and GID are provided
if [[ -z "$UID" || -z "$GID" ]]; then
  echo -e "\e[31m[ERROR] UID and GID environment variables are not set.\e[0m"
  echo -e "\e[33mTo run this container properly, you need to pass your user and group IDs.\e[0m"
  echo -e "\e[33mYou can do this in one of the following ways:\e[0m"
  echo -e "\e[32m1. Pass UID and GID when calling docker-compose, e.g.,\e[0m"
  echo -e "\e[32m   UID=$(id -u) GID=$(id -g) docker-compose up\e[0m"
  echo -e "\e[32m2. Create an .env file in the project directory with the following contents:\e[0m"
  echo -e "\e[32m   UID=$(id -u)\e[0m"
  echo -e "\e[32m   GID=$(id -g)\e[0m"
  echo -e "\e[31mExiting now.\e[0m"
  exit 1
fi

# Create a user with the provided UID and GID
USER_ID=${UID:-1000}
GROUP_ID=${GID:-1000}

# Add group and user with UID/GID passed in from docker-compose
groupadd -g $GROUP_ID usergroup
useradd -m -u $USER_ID -g usergroup -s /bin/bash user

# Set permissions for the workspace directory
chown -R $USER_ID:$GROUP_ID /workspace

# Set Jupyter runtime, config, and data directories to locations writable by the user
export JUPYTER_RUNTIME_DIR=/workspace/.jupyter/runtime
export JUPYTER_CONFIG_DIR=/workspace/.jupyter/config
export JUPYTER_DATA_DIR=/workspace/.jupyter/data
mkdir -p $JUPYTER_RUNTIME_DIR $JUPYTER_CONFIG_DIR $JUPYTER_DATA_DIR
chown -R $USER_ID:$GROUP_ID /workspace/.jupyter

# Run the command as the specified user, preserving the environment
exec sudo -E -u user env JUPYTER_RUNTIME_DIR=$JUPYTER_RUNTIME_DIR JUPYTER_CONFIG_DIR=$JUPYTER_CONFIG_DIR JUPYTER_DATA_DIR=$JUPYTER_DATA_DIR "$@"
