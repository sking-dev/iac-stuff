# Connect PowerShell to Azure Stack Hub

Follow the steps below to connect PowerShell on your local workstation to your Azure Stack Hub environment.

----

## Connect to Azure Stack Hub with Azure AD

### Connecting For the First Time

Run the PowerShell code below.

```powershell
Add-AzureRMEnvironment -Name "AzureStackUser" -ArmEndpoint "https://management.your-ash-location.cloud.your-domain.com"
# Set your tenant name.
$AuthEndpoint = (Get-AzureRmEnvironment -Name "AzureStackUser").ActiveDirectoryAuthority.TrimEnd('/')
$AADTenantName = "YourTenantDirectory.onmicrosoft.com"
$TenantId = (invoke-restmethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]

# After signing in to your environment, Azure Stack Hub cmdlets can be easily targeted at your Azure Stack Hub instance.
Add-AzureRmAccount -EnvironmentName "AzureStackUser" -TenantId $TenantId
```

Source:

- <https://docs.microsoft.com/en-us/azure-stack/user/azure-stack-powershell-configure-user?view=azs-2002>

----

### Subsequent Connections (Sessions)

Use the code below on an ongoing basis to connect and establish a PowerShell session as required.

```powershell
# Use variable to specify Azure environment to connect to.
$ArmEndpoint = "https://management.your-ash-location.cloud.your-domain.com"

# Add environment by referencing variable.
Add-AzureRmEnvironment -Name "AzureStackUser" -ArmEndpoint $ArmEndpoint

# Connect to environment.
Connect-AzureRmAccount -EnvironmentName "AzureStackUser"
```

Source:

- <https://docs.ukcloud.com/articles/azure/azs-how-list-vm-extensions.html#instructions>
