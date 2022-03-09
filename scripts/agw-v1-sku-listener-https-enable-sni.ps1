# Enable SNI on a V1 SKU Application Gateway Listener
$appgw = Get-AzApplicationGateway -Name "agw-v1-test-999" -ResourceGroupName "rg-test-999"
$list = Get-AzApplicationGatewayHttpListener -Name "my-app-listener-https" -ApplicationGateway $appgw 
$list.RequireServerNameIndication = $true
 
Set-AzApplicationGateway -ApplicationGateway $appgw
