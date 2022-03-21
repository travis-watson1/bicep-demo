//Example of using output in modules:
@description('Username for the virtual machine.')
param location string
param appSku string
param webAppNames array
param stgAcctName string
param vnetName string
param subnetName string
param subnetName2 string
param kvtName string

module kvt 'modules/keyVault.bicep' = {
  name: 'kvtDeployment'
  params: {
    location: location
    kvtName: kvtName
  }
}

module appService 'modules/appService.bicep' = [for (name, i) in webAppNames: {
  name: name
  params: {
    location: location
    appSku: appSku
    appName: name
  }
}]

module stgAccount 'modules/storageAccount.bicep' = {
  name: 'stgAcctDeployment'
  params: {
    location: location
    stgAcctName: stgAcctName
    vnetName: vnetName
    subnetName: subnetName
    subnetName2: subnetName2
  }
}
