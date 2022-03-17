New-AzResourceGroup -Name "Test" -Location "West US" -Force


$config = @{
    appServiceName = 'ConfigName'
    location       = 'West US'
    webAppNames       = @{'App1', 'App2'}
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config