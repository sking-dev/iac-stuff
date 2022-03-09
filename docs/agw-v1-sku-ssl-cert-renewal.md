# Renew SSL Certificate on V1 SKU Application Gateway

## Commands to Work With ARM Templates

```bash
az deployment group validate -n agw-deployment-999 -g rg-test-999 --template-file .\agw-v1-sku.json --parameters .\agw-v1-sku.parameters.agw-v1-test-999.json

az keyvault secret set --vault-name kv-test-999 --encoding base64 --description application/x-pkcs12 --name test-999-cert --file my-certificate.pfx
```

----

## Commands to Work With Application Gateway Instances

### List AGW

Show a list of Application Gateway instances, and show the running state of these instances.

```bash
az network application-gateway list -o table
```

### Stop AGW

Stop an Application Gateway instance.

```bash
az network application-gateway stop -g rg-test-999 -n agw-v1-test-999
```

To verify that it's stopped via the ARM Portal, go to Overview > Sum current connection graph.

### Start AGW

Start an Application Gateway instance.

```bash
az network application-gateway start -g rg-test-999 -n agw-v1-test-999
```
