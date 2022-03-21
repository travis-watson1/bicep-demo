New-AzResourceGroup -Name "Test" -Location "West US" -Force


$config = @{
    location    = 'West US'
    webAppNames = @('traviswat45745', 'traviswat68586')
    stgAcctName = 'stgtravis11383'
    vnetName    = 'vnet-test'
    subnetName  = 'SubnetTest'
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config
