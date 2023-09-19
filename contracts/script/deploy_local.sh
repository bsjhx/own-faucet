#!/bin/bash

# needed to always get absolute path
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
echo "$parent_path"
cd "$parent_path"

source ../.env

forge script DeployTokenScript.sol:DeployTokenScript \
    --private-key $LOCAL_PRIVATE_KEY \
    --fork-url $LOCAL_URL \
    --broadcast
