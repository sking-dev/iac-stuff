#!/bin/bash

# Script to identify Network Security Groups across subscriptions that have existing "old school" flow logs configured.

# Send output to TXT file.
output_file="arm-output-nsg-flow-logs-$(date +"%Y%m%d-%H%M%S").txt"

echo "Script started."
echo "IMPORTANT: Ensure the current user has signed in to ARM and has access to the relevant subscriptions."
echo "" # Blank line to improve readability of output.

echo "Step 1 - Verify current account context."
az account show

echo "Step 2 - List Network Security Groups plus flow log associations."
echo ""
echo "Identify accessible subscriptions for current account context."

az account list --query "[].{id:id, name:name}" -o tsv | \
  while read -r sub_id sub_name; do 
    echo "Processing Subscription: $sub_name (ID: $sub_id)"
    az account set --subscription "$sub_id"
    
    # Store NSG list in a variable.
    nsg_list=$(az network nsg list \
      --query "[].{SubscriptionName:'$sub_name', Name:name, ResourceGroup:resourceGroup, Location:location, FlowLogs:(networkWatcherFlowLogs[0].id != null)}" \
      --output table)
    
    # Check if NSG list is empty.
    if [ -z "$nsg_list" ]; then
      echo "No NSG resources exist in subscription $sub_name"
    else
      echo "Listing Network Security Groups for $sub_name"
      echo "$nsg_list"
    fi
    
    # Add a blank line after each subscription.
    echo ""
  done | tee "$output_file"

echo "Output saved to $output_file ."
echo ""
echo "Script completed."
