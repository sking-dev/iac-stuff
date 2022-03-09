$resources = Get-AzureRmResource -ResourceGroupName "rg-test-999" -Name test-vm-*
foreach ($r in $resources)
{
  Set-AzureRmResource -Tag @{ CostCentre="Undefined"; Documentation="Undefined"; Env="TEST"; InceptionDate="20220309T000000Z"; ModifiedDate="Undefined"; ITOwner="Undefined"; ProjectName="TEST: Undefined"; ServiceOwner="Undefined"; ShutdownOOH="False" } -ResourceId $r.ResourceId -Force  
}
