New-AzResourceGroup -Name "Test" -Location "West US" -Force


$config = @{
    location       = 'West US'
    webAppNames    = @('traviswatsontestapp1', 'traviswatsontestapp2')
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config