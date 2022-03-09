# Use Azure CLI to Report on Expired SSL Certificates in an Azure Key Vault

Notes to accompany [this here script](az-cli-kv-report-expired-ssl-certs.sh) .

----

Source: <https://www.trendmicro.com/cloudoneconformity/knowledge-base/azure/KeyVault/sufficient-auto-renewal-period.html#>

----

## List Key Vaults within Current Subscription

`az keyvault list  --query '[*].name'`

[
  "random-kv-1",
  "kv-test1-prod",
  "kv-test2-prod",
  "kv-test3-prod",
  "kv-test4-prod",
  "kv-test5-prod"
]

## Filter out "random-kv-1" Key Vault (not in scope)

`az keyvault list  --query "[?starts_with(name,'kv-')].name"`

## Filter by name suffix (better option)

`az keyvault list  --query "[?ends_with(name,'-prod')].name"`

----

## List Active Certificates within Individual Key Vault

`az keyvault certificate list  --vault-name "kv-test1-prod" --query '[?(attributes.enabled==`true`)].id'`

----

## Return Expiry Date of Individual Certificate

`az keyvault certificate show --id "https://kv-test1-prod.vault.azure.net/certificates/my-app-1-cert" --query 'attributes.expires'`

----
