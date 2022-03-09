#!/bin/bash

# The bulk of this script was cribbed from https://trstringer.com/key-vault-certificate-expiration/.

echo "Start bash script..."

echo "Get list of Production Key Vaults..."

KEYVAULTS=$(az keyvault list --query "[?ends_with(name,'-prod')].name" -o tsv)
# KEYVAULTS="<space_delimited_list_of_vault_names>"

echo "$KEYVAULTS"

echo "Get list of certificates plus expiry dates from each Key Vault..."

for KEYVAULT in $KEYVAULTS; 
    do

      for CERT in $(az keyvault certificate list \
              --vault-name "$KEYVAULT" \
              --query "[].name" -o tsv); 
      do

        EXPIRES=$(az keyvault certificate show \
            --vault-name "$KEYVAULT" \
            --name "$CERT" \
            --query "attributes.expires" -o tsv)

        echo "$CERT (Vault: $KEYVAULT) expires on $EXPIRES"

      done

    done

echo "Completed bash script."

# If using Windows, uncomment for user prompt that will keep Git Bash window open to assist with troubleshooting / debugging.
#read -p "Bash script completed.  Press [Enter] key when ready."
