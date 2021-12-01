@{
    # navnet på din ressursgruppe sandbox
    resourceGroupName  = 'martin-workshop-ukjdlxupxgiyi' 
    # navnet til storage account som skal opprettes, globalt unikt
    storageAccountName = 'strbj' + (New-Guid).ToString().Substring(0,8) 
    # navnet til function app som skal opprettes - globalt unikt
    functionAppName    = 'bj-martin-larsen-oppg13' #globalt unikt
    location           = 'Norway East'
}