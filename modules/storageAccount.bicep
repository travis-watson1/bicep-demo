param location string
param stgAcctName string
param vnetName string
param subnetName string

resource vnetTest 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: vnetName

  resource managementSubnet 'subnets' existing = {
    name: subnetName
  }
}

output managementSubnetResourceId string = vnetTest::managementSubnet.id

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: stgAcctName
  location: location
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        file: {
          enabled: true
        }
        blob: {
          enabled: true
        }
      }
    }
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: [
        {
          action: 'Allow'
          value: '154.21.114.0/24'
        }
      ]
      // virtualNetworkRules: [
      //   {
      //     action: 'Allow'
      //     id: vnetTest::managementSubnet.properties.
      //     state: 'Succeeded'
      //   }
      // ]
    }
    supportsHttpsTrafficOnly: true
  }
}
