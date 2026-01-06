#!/bin/bash

# Script to identify Virtual Networks across subscriptions that do *not* have flow logs configured.

# Send output to TXT file with timestamp
output_file="arm-output-vnet-without-flow-logs-$(date +"%Y%m%d-%H%M%S").txt"

echo "Script started."
echo "IMPORTANT: Ensure the current user has signed in to ARM and has access to the relevant subscriptions."
echo ""

# Verify current Azure account context.
echo "Step 1 - Verify current account context."
az account show
echo ""

echo "Step 2 - Identify Virtual Networks without Flow Logs."
echo ""

# Iterate through all accessible subscriptions.
az account list --query "[].{id:id, name:name}" -o tsv | \
  while read -r sub_id sub_name; do 
    echo "Processing Subscription: $sub_name (ID: $sub_id)"
    az account set --subscription "$sub_id"
    
    # Retrieve list of VNets in the current subscription.
    vnets=$(az network vnet list \
      --query "[].{name:name, resourceGroup:resourceGroup, location:location}" \
      -o tsv)
    
    # Skip subscription if no VNets exist.
    if [ -z "$vnets" ]; then
      echo "No VNet resources exist in subscription $sub_name"
      echo ""
      continue
    fi
    
    # Prepare array to store VNets without flow logs.
    vnets_without_flow_logs=()
    
    # Check each VNet for flow log configuration.
    while read -r vnet_name resource_group location; do
      # Assume no flow log exists until proven otherwise.
      has_flow_log=false
      
      # Check for flow logs across all Network Watcher locations.
      for watcher_location in $(az network watcher list --query "[].location" -o tsv); do
        # Search for flow log associated with this VNet.
        flow_log=$(az network watcher flow-log list \
          --location "$watcher_location" \
          --query "[?contains(targetResourceId, '$vnet_name')].id" \
          -o tsv)
        
        # If flow log found, mark as configured and stop searching.
        if [ -n "$flow_log" ]; then
          has_flow_log=true
          break
        fi
      done
      
      # Add to list of VNets without flow logs if no log found.
      if [ "$has_flow_log" = false ]; then
        vnets_without_flow_logs+=("$sub_name $vnet_name $resource_group $location")
      fi
    done < <(echo "$vnets")
    
    # Output VNets without flow logs for this subscription.
    if [ ${#vnets_without_flow_logs[@]} -gt 0 ]; then
      echo "Virtual Networks without Flow Logs in $sub_name:"
      printf "%s\n" "${vnets_without_flow_logs[@]}" | column -t
      echo ""
    else
      echo ""
    fi
  done | tee "$output_file"

echo "Output saved to $output_file."
echo "Script completed."
