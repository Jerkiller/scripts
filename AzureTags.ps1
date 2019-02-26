# This script creates a csv file in the user desktop with a list of resources and all the product and function tags
# Configuration part
$TenantId = '55555555-2222-4444-9999-ffffffffffff' # Tenant ID
$Subscription = '55555555-2222-4444-6666-ffffffffffff' # Subscription ID
$OutputFile = $env:systemdrive+'\users\'+$env:username+'\Desktop\tags.csv' # Where the output will be written

# Some Azure Resources are virtual and should not appear in the csv file
$TypesToExclude = 'Microsoft.Portal/dashboards','microsoft.insights/alertrules','microsoft.insights/scheduledqueryrules','microsoft.insights/webtests'
Login-AzureRmAccount -TenantId $TenantId

# Get-AzureRmSubscription
Select-AzureRmSubscription -SubscriptionId $Subscription
Set-AzureRmContext -Tenant $TenantId -Subscription $Subscription

# Output Headers to file
"""Name"";""GroupName"";""Type"";""Product"";""Function""" | Out-File -FilePath $OutputFile -Append

foreach($Resource in Get-AzureRmResource)
{
    # Coalesce Values
    $Name = if ($Resource.Name -eq $null) { "" } else { $Resource.Name }
    $GroupName = if ($Resource.ResourceGroupName -eq $null) { "" } else { $Resource.ResourceGroupName }
    $Type = if ($Resource.ResourceType -eq $null) { "" } else { $Resource.ResourceType }
    $Product = if ($Resource.Tags.Product -eq $null) { "" } else { $Resource.Tags.Product }
    $Function = if ($Resource.Tags.Function -eq $null) { "" } else { $Resource.Tags.Function }

    # If the resource type is virtual, skip it
    if($TypesToExclude.Contains($Type)) { continue }
    # Output to file
    """$Name"";""$GroupName"";""$Type"";""$Product"";""$Function""" | Out-File -FilePath $OutputFile -Append
}
