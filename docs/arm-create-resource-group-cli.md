# Create Azure Resource Groups with Azure CLI

## Azure Resource Manager

```bash
$location = 'uk west'
$rg_name = 'rg-test-999'
az group create --location $location --name $rg_name
az group update --resource-group $rg_name --set tags.CostCenter=Undefined tags.Documentation=Undefined tags.Env=TEST tags.InceptionDate=2022-03-08 tags.ITOwner=Undefined tags.ModifiedDate=(timestamp) tags.ProjectName="Test: Undefined" tags.ServiceOwner=Undefined tags.ShutdownOOH=True
```

### New Improved Create RG With A Single Command

```bash
az group create --location ukwest --name rg-test-999 --tags CostCentre=Undefined Documentation=Undefined Env=TEST InceptionDate=2022-03-08 ITOwner=Undefined ModifiedDate=(timestamp) ProjectName="Test: Undefined" ServiceOwner=Undefined ShutdownOOH=False
```

## Azure Stack Hub

```bash
$location = 'my-ash-location'
$rg_name = 'rg-my-ash-location-test-999'
az group create --location $location --name $rg_name
az group update --resource-group $rg_name --set tags.CostCentre=Undefined tags.Documentation=Undefined tags.Env=TEST tags.InceptionDate=Undefined tags.ITOwner=Undefined tags.ServiceOwner=Undefined tags.ShutdownOOH=True
```

----

## PowerShell

Here's the Azure PowerShell equivalent for future reference.

```powershell
$location = 'uk west'
$rg_name = 'rg-test-999'
New-AzResourceGroup -Name $rg_name -location $location
$tags = @{"CostCentre"="Undefined"; "Documentation"="Undefined"; "Env"="TEST"; "InceptionDate"="Undefined"; "ITOwner"="Undefined"; "ServiceOwner"="Undefined"; "ShutdownOOH"="True"}
Set-AzResourceGroup -Name $rg_name -Tag $tags
```
