# Connect Azure CLI to Azure Stack Hub

Follow the steps below to connect Azure CLI on your local workstation to your Azure Stack Hub environment.

----

## Register ASH Environment

```azurecli
az cloud register -n AzureStackUser --endpoint-resource-manager "https://management.ash-location.cloud.your-domain.com" --suffix-storage-endpoint "ash-location.cloud.your-domain.com" --suffix-keyvault-dns ".vault.ash-location.cloud.your-domain.com" --endpoint-active-directory-graph-resource-id "https://graph.windows.net/"
```

## Set Active Environment (For "User" Environment)

```bash
az cloud set -n AzureStackUser
```

## Update Environment Configuration to Use ASH-Specific API Version Profile

```bash
az cloud update --profile 2019-03-01-hybrid
```

## Sign In to ASH Environment

```bash
az login -u "user@your-domain.com" -p 'Passw0rd123!'
```

NOTE: Authorised guest users from third party organisations  will need to specify your tenant directory in the `az login` command as follows.

```bash
az login -u "user@your-domain.com" -p 'Passw0rd123!' --tenant "your-tenant-directory.onmicrosoft.com"
```

NOTE: If your user account has multi-factor authentication enabled, you can use the `az login` command **without** providing the `-u` parameter. Running the command gives you a URL and a code that you must use to authenticate.

## Verify Set-up

```bash
az cloud list --output table
```

You should see `True - AzureStackUser - 2019-03-01-hybrid` as the last line in the outputted table.

If you do: success!

----

## Return to the Original Cloud Environment

When you need to switch to a different subscription, remember that you've set your active cloud environment to be Azure Stack Hub (see above) so you won't see any subscriptions that are registered with other cloud environments e.g. 'AzureCloud' (AKA Azure Resource Manager)

To see your available cloud environments, run `az cloud list --output table`.

Then switch over to ARM by running `az cloud set --name AzureCloud`.

Then run `az login`.  

After you've authenticated, you should see a JSON list of all the subscriptions associated with your account in the ARM cloud environment.  To verify / view this list in a clear(er) way, run `az account list --output table`.

Switch to the subscription you want to work in by running `az account set --subscription "NameOfSubscription"`.

E.g. `az account set --subscription "My ARM Subscription"`

Job done!

----

Source:

- <https://docs.ukcloud.com/articles/azure/azs-how-configure-cli.html?tabs=tabid-1>

```plaintext
NOTE: The value to use for the 'Azure Stack Hub DNS Suffix' variable is: 'ash-location.cloud.your-domain.com'.
```

----

### Other Resources

- <https://docs.microsoft.com/en-us/azure-stack/user/azure-stack-version-profiles-azurecli2?view=azs-2002#connect-to-azure-stack-hub-1>
- <https://docs.microsoft.com/en-us/cli/azure/manage-clouds-azure-cli?view=azure-cli-latest>
- <https://www.craigforrester.com/posts/azure-cli-basics-logging-in/>
