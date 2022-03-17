New-AzResourceGroup -Name "Test" -Location "West US" -Force


$config = @{
    appServiceName = 'ConfigName'
    location       = 'West US'
    webAppNames    = @('adkjhfds7823', 'gjhgjh4532')
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config