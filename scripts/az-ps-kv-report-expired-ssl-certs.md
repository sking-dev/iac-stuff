# Use PowerShell to Report on Expired SSL Certificates in an Azure Key Vault

Notes to accompany [this here PowerShell script](az-ps-kv-report-expired-ssl-certs.ps1) .

----

## Install PowerShell on WSL System

### Take One

Source: <https://www.techlear.com/blog/2021/02/26/how-to-install-and-use-powershell-on-ubuntu-20-04/>

Summary of steps taken.

Update system packages

- `sudo apt-get update -y`

Install PS using Snap

- `sudo apt-get install snap snapd -y`

- `snap install powershell --classic`

BOO!  Snap doesn't work on WSL.

Remove the packages & find another way...

- `sudo apt-get remove snap + sudo apt-get remove snapd`

----

### Take Two

Source: <https://saggiehaim.net/install-powershell-7-on-wsl-and-ubuntu/>

No joy with this either.

----

### Make Life Easier and Use PowerShell in VS Code Terminal

Sources:

- <https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.1>
- <https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.6.0>

----

### PS Commands to Use

Get the relevant KVs.

- `Get-AzKeyVault -VaultName '*-prod'`

Get the certificates from the KVs.

- `Get-AzKeyVaultCertificate`

Get the certificate details via the script sourced from <https://4sysops.com/archives/find-expired-certificates-in-azure-using-powershell/#creating-a-report>

- `$KeyVaultTest=Get-AzKeyVault -VaultName '*-prod'`

- `$KeyVaultTest | Get-AzKeyVaultCertificate`

----

### Output Example

```plaintext
KeyVaultCertName                   KeyVaultName        KeyVaultCertEnabled KeyVaultCertExpiryDate
----------------                   ------------        ------------------- ----------------------
my-app-1-cert                      kv-test1-prod       True                05/21/2021 14:08:00   
my-app-2-cert                      kv-test2-prod       True                06/22/2021 15:42:00   
my-app-3-cert                      kv-test3-prod       True                07/23/2021 16:30:00   
```
