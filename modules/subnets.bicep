param location string
param prefix string
param number int
param subnetAddressPrefix array

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' existing = {
  name: 'testnsg'
}

resource routeTable 'Microsoft.Network/routeTables@2021-05-01' existing = {
  name: 'routetabletest'
}

resource vnetTest 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'vnet-test'
}

resource subnets 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: 'APP-SUBNET-0${number + 1}'
  parent: vnetTest
  properties: {
    addressPrefix: subnetAddressPrefix[number]
    networkSecurityGroup: {
      id: nsg.id
    }
    routeTable: {
      id: routeTable.id
    }
    serviceEndpoints: [
      {
        locations: [
          'usgovvirginia'
          'usgoviowa'
          'usgovtexas'
        ]
        service: 'Microsoft.Storage'
      }
      {
        locations: [
          'usgovvirginia'
        ]
        service: 'Microsoft.Sql'
      }
    ]
    delegations: [
      {
        name: 'delegation'
        properties: {
          serviceName: 'Microsoft.Web/serverFarms'
        }
      }
    ]
  }
}
