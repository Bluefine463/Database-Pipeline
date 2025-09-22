#!/usr/bin/env bash
set -euo pipefail

RG="$1"            # resource group
ACR_NAME="$2"      # registry name (login server = <ACR_NAME>.azurecr.io)
PREFIX="${3:-msdemo}"

# build & push using az acr build (runs in Azure, no local docker needed)
az acr build -r "$ACR_NAME" -t database-service:latest ./services/database-service
az acr build -r "$ACR_NAME" -t user-service:latest ./services/user-service

echo "Images pushed to ${ACR_NAME}.azurecr.io"
