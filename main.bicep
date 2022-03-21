//Example of using output in modules:
@description('Username for the virtual machine.')
param location string
param appSku string
param webAppNames array
param stgAcctName string
param vnetName string
param subnetName string

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
  }
}

// module virtualMachine 'modules/vm.bicep' = {
//   name: 'virtual-machine'
//   params: {
//     adminUsername: adminUsername
//     adminPassword: adminPassword
//     subnetResourceId: virtualNetwork.outputs.subnetResourceId
//   }
// }
