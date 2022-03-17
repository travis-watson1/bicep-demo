New-AzResourceGroup -Name "Test" -Location "West US" -Force


$config = @{
    location       = 'West US'
    #webAppNames    = @('traviswat45745', 'traviswat68586')
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config
