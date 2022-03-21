param location string
param kvtName string
param sqlPassword string

resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: kvtName
  location: location
  properties: {
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        objectId: '8a3a5a6d-d917-4b9c-83fd-333a5a94184b'
        permissions: {
          certificates: [
            'get'
            'list'
          ]
          keys: [
            'get'
            'list'
          ]
          secrets: [
            'get'
            'list'
            'set'
          ]
          storage: [
            'get'
            'list'
            'set'
          ]
        }
        tenantId: subscription().tenantId
      }
    ]
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    createMode: 'default'
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2021-04-01-preview' = {
  parent: keyVault
  name: 'AWACSSqlAdminPassword'
  properties: {
    value: sqlPassword
  }
}
