//Example of using output in modules:
@description('Username for the virtual machine.')
param location string
param appSku string
param webAppNames array

module appService 'modules/appService.bicep' = {
  name: 'test'
  params: {
    location: location
    appSku: appSku
    appName: 'test'
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
