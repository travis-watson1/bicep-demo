//Example of using output in modules:
@description('Username for the virtual machine.')
param appServiceName string
param location string
param appSku string
param webAppNames array

module appService 'modules/appService.bicep' = [for (name, i) in webAppNames: {
  name: '${appServiceName}${i}'
  params: {
    location: location
    appSku: appSku
    appName: name
  }
}]

// module virtualMachine 'modules/vm.bicep' = {
//   name: 'virtual-machine'
//   params: {
//     adminUsername: adminUsername
//     adminPassword: adminPassword
//     subnetResourceId: virtualNetwork.outputs.subnetResourceId
//   }
// }
