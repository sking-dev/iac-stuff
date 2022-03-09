# NOTES
#Connect-AzAccount
#Get-AzContext  # Check which subscription you're signed in to.
#Get-AzSubscription
#Set-AzContext -SubscriptionName "MySubscription"

$KeyVaultProd = Get-AzKeyVault -VaultName '*-prod'

$AllKeyVaultCerts = $KeyVaultProd | Get-AzKeyVaultCertificate

$result = @()
$result += "KeyVaultCertName, KeyVaultName, KeyVaultCertEnabled, KeyVaultCertExpiryDate"

foreach ($KeyVaultCert in $AllKeyVaultCerts) {
    $KeyVaultName = $KeyVaultCert.VaultName
    $KeyVaultCertName = $KeyVaultCert.Name
    $KeyVaultCertEnabled = $KeyVaultCert.Enabled
    $KeyVaultCertExpiryDate = $KeyVaultCert.expires
    if ($KeyVaultCertExpiryDate -lt ((Get-Date).AddDays(30))) {
        $result += "$KeyVaultCertName, $KeyVaultName, $KeyVaultCertEnabled, $KeyVaultCertExpiryDate"
    }
}

$result | ConvertFrom-Csv
