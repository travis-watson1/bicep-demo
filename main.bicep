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
param sqlPassword string
param secretExists bool
param prefix string
param subnetAddressPrefix array

module appSubnets 'modules/subnets.bicep' = [for i in range(0, 2): {
  name: 'appSubnets${i}'
  params: {
    prefix: prefix
    location: location
    number: i
    subnetAddressPrefix: subnetAddressPrefix
  }
}]

// module kvt 'modules/keyVault.bicep' = {
//   name: 'kvtDeployment'
//   params: {
//     location: location
//     kvtName: kvtName
//     sqlPassword: sqlPassword
//     secretExists: secretExists
//   }
// }

// resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
//   scope: resourceGroup('Test2')
//   name: kvtName
// }

// module appService 'modules/appService.bicep' = [for (name, i) in webAppNames: {
//   name: name
//   params: {
//     prefix: prefix
//     location: location
//     appSku: appSku
//     appName: name
//     number: i + 1
//   }
// }]

// module stgAccount 'modules/storageAccount.bicep' = {
//   name: 'stgAcctDeployment'
//   params: {
//     location: location
//     stgAcctName: stgAcctName
//     vnetName: vnetName
//     subnetName: subnetName
//     subnetName2: subnetName2
//   }
// }
