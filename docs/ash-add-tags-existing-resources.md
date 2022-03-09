# Add Tags to Existing Resources in Azure Stack Hub

Source: <https://buildvirtual.net/add-resource-tags-to-azure-virtual-machines-using-powershell/>

----

```powershell
Get-AzVM -ResourceGroupName "rg-test-999" -Name test-vm-*

$resources = Get-AzureRmResource -ResourceGroupName "rg-test-999" -Name test-vm-*

foreach ($r in $resources)
{
  Set-AzureRmResource -Tag @{ CostCentre="Undefined"; Documentation="Undefined"; Environment="TEST"; InceptionDate="20220309T000000Z"; ModifiedDate="Undefined"; ITOwner="Undefined"; ProjectName="Undefined"; ServiceOwner="Undefined"; ShutdownOOH="False" } -ResourceId $r.ResourceId -Force  
}

Set-AzureRmResource -Tag @{ CostCentre="Undefined"; Documentation="Undefined"; Environment="TEST"; InceptionDate="20220309T000000Z"; ModifiedDate="Undefined"; ITOwner="Undefined"; ProjectName="Undefined"; ServiceOwner="Undefined"; ShutdownOOH="False" } -ResourceId $r.ResourceId -Force

$groups = Get-AzureRmResourceGroup "rg-test-001"

foreach ($g in $groups)
{
    Find-AzureRmResource -ResourceGroupNameEquals $g.ResourceGroupName | ForEach-Object {Set-AzureRmResource -ResourceId $_.ResourceId -Tag $g.Tags -Force }
}
```
