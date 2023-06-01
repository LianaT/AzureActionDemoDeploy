param location string = resourceGroup().location
param saName string = 'contososa'

var storageAccountName = '${toLower(saName)}${uniqueString(resourceGroup().id)}'

resource contosoStorageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    supportsHttpsTrafficOnly: true
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-08-01' = {
  name: 'default'
  parent: contosoStorageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-08-01' = {
  name: 'media'
  parent: blobServices

}



//output containerUrl string = contosoStorageAccount.properties.primaryEndpoints.blob
