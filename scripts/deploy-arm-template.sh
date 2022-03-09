#!/bin/bash

# This script is a WIP attempt to combine Azure CLI commands that are currently run separately.
# Needs more work!

# Variables for Azure CLI commands.
deploymentName
resourceGroup
templateFile
parametersFile

# Azure CLI command to validate ARM template deployment to resource group.
az deployment group validate -n test-deployment-999 -g rg-test-999 --template-file .\agw-test.json --parameters .\agw-test.parameters.agw-test-public.json

# Deploy.
az deployment group create -n test-deployment-999 -g rg-test-999 --template-file .\agw-test.json --parameters .\agw-test.parameters.agw-test-public.json
