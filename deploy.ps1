Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
New-AzResourceGroup -Name "Test" -Location "West US" -Force


$config = @{
    appServiceName = 'ConfigName'
    location       = 'West US'
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\_bicep-test\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config