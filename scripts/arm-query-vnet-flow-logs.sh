#!/bin/bash

# Script to identify Virtual Networks across subscriptions that have existing flow logs configured.

# Send output to TXT file.
output_file="arm-output-vnet-flow-logs-$(date +"%Y%m%d-%H%M%S").txt"

echo "Script started."
echo "IMPORTANT: Ensure the current user has signed in to ARM and has access to the relevant subscriptions."
echo ""

echo "Step 1 - Verify current account context."
az account show
echo ""

echo "Step 2 - List Virtual Network resources plus flow log associations."
echo ""
echo "Identify accessible subscriptions for current account context."

az account list --query "[].{id:id, name:name}" -o tsv | \
  while read -r sub_id sub_name; do 
    echo "Processing Subscription: $sub_name (ID: $sub_id)"
    az account set --subscription "$sub_id"
    
    # Capture flow log resources in the subscription.
    flow_logs=$(az network watcher list \
      --subscription "$sub_id" \
      --query "[].{Location:location}" \
      -o tsv | \
      xargs -I {} az network watcher flow-log list \
        --location {} \
        --subscription "$sub_id" \
        --query "[].{VNetId:targetResourceId}" \
        -o tsv)
    
    # Store list of VNet resources.
    vnet_list=$(az network vnet list \
      --query "[].{SubscriptionName:'$sub_name', Name:name, ResourceGroup:resourceGroup, Location:location, HasFlowLog:(contains('$flow_logs', id))}" \
      --output table)
    
    # Check if VNet list is empty.
    if [ -z "$vnet_list" ]; then
      echo "No VNet resources exist in subscription $sub_name"
    else
      echo "Listing Virtual Networks for $sub_name"
      echo "$vnet_list"
    fi
    
    # Add a blank line after each subscription.
    echo ""
  done | tee "$output_file"

echo "Output saved to $output_file."
echo ""
echo "Script completed."
