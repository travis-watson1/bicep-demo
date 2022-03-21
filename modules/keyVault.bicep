param location string
param kvtName string

resource symbolicname 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
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
            'set'
          ]
          keys: [
            'get'
            'list'
            'set'
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