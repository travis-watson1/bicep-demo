New-AzResourceGroup -Name "Test" -Location "West US" -Force

$config = @{
    location    = 'West US'
    webAppNames = @('traviswat45745', 'traviswat68586')
    stgAcctName = 'stgtravis11383'
    vnetName    = 'vnet-test'
    subnetName  = 'SubnetTest'
    subnetName2 = 'SubnetTest2'
    kvtName     = 'traviskvttest'
    sqlPassword = 'test46'
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config
