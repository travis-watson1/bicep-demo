New-AzResourceGroup -Name "Test" -Location "West US" -Force
$kvtSecretExists = Get-AzKeyVaultSecret -VaultName 'traviskvttest' -Name 'AWACSSqlAdminPassword5'
if ($kvtSecretExists) { $secretExists = $true } else { $secretExists = $false }
Write-Output $secretExists

$prefix = "prefix"

$config = @{
    prefix              = $prefix
    location            = 'West US'
    webAppNames         = @('traviswat45745', 'traviswat68586')
    stgAcctName         = 'stgtravis11383'
    vnetName            = 'vnet-test'
    subnetName          = 'SubnetTest'
    subnetName2         = 'SubnetTest2'
    kvtName             = 'travistest2kvt'
    sqlPassword         = 'newestsecret'
    secretExists        = $secretExists
    subnetAddressPrefix = @('10.0.2.0/28', '10.0.2.48/28')
}

New-AzResourceGroupDeployment -ResourceGroupName "Test" -TemplateFile ".\main.bicep" -TemplateParameterFile ".\params\dev.parameters.json" @config
