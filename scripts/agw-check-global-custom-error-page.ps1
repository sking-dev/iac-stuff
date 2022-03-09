# Check configuration of global custom error page for 502 status.
$resourceGroupName = "rg-test-999"
$AppGWName = "agw-test-999-public"
$AppGw = Get-AzApplicationGateway -Name $AppGWName -ResourceGroup $resourceGroupName
$ce = Get-AzApplicationGatewayCustomError -ApplicationGateway $appgw -StatusCode HttpStatus502

# Output $ce to display the result.
$ce
