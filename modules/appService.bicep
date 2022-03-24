param location string
param appSku string
param appName string
param prefix string
param number int

var appServicePLanName = '${prefix}-ASP-0${number}'

resource appInsightPlan 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appName${number}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    ImmediatePurgeDataOn30Days: false
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    RetentionInDays: 270
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: appServicePLanName
  location: location
  sku: {
    name: appSku
  }
}

resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      netFrameworkVersion: '4.0'
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
      appSettings: [
        {
          'name': 'APPINSIGHTS_INSTRUMENTATIONKEY'
          'value': appInsightPlan.properties.InstrumentationKey
        }
        {
          'name': 'ApplicationInsightsAgent_EXTENSION_VERSION'
          'value': '~2'
        }
        {
          'name': 'XDT_MicrosoftApplicationInsights_Mode'
          'value': 'recommended'
        }
      ]
    }
  }
}

resource vnetTest 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'vnet-test'

  resource managementSubnet 'subnets' existing = {
    name: 'sub1'
  }
}

resource webAppVnet 'Microsoft.Web/sites/networkConfig@2021-03-01' = {
  parent: appServiceApp
  name: 'virtualNetwork'
  properties: {
    subnetResourceId: vnetTest.properties.subnets[0].id
    swiftSupported: true
  }
}

// resource webAppConfig 'Microsoft.Web/sites/config@2021-03-01' = {
//   name: 'appsettings'
//   kind: 'string'
//   parent: appServiceApp
//   properties: {
//     netFrameworkVersion: '4.0'
//   }
// }

// resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
//   name: 'test'
//   location: location
//   tags: {
//     'hidden-link:${appServiceApp.id}': 'Resource'
//     displayName: 'AppInsightsComponent'
//   }
//   kind: 'web'
//   properties: {
//     Application_Type: 'web'
//   }
// }

// output appServiceAppHostName string = appServiceApp.properties.defaultHostName
