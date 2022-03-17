//Example of using output in modules:
@description('Username for the virtual machine.')
param appServiceName string
param location string

module appService 'modules/appService.bicep' = {
  name: appServiceName
  params: {
    appServiceName: appServiceName
    location: location
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
