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

##########################################
# Other Useful commands about Azure Tags #
##########################################

# Get all tagged resources
# Get-AzureRmTag

# Drill down into the "Product" tag
# Get-AzureRmTag -Name "Product"

# All the resources with a specific tag
# Get-AzureRmResource -Tag @{Function="CEP"} | ft -Property Name

# Export a command into CSV
# <Command> | Export-Csv "c:\path\a.csv"

# All the resources without any tag
# foreach($resource in Get-AzureRmResource)
# {
#     if (($resource.Tags -eq $null) -or ($resource.TagName -ne "Product"))
#     { echo $resource.Name, $resource.ResourceType }
# }

# Remove every tag of a certain type
# foreach($r in Get-AzureRmResource)
# {
# 	$resourcetags=(Get-AzureRmResource -ResourceId $r.ResourceId).Tags
#	
# 	if(($resourcetags) -AND ($resourcetags.ContainsKey("Product"))) {
# 	 	$resourcetags.Remove("Product") 
# 	 	Set-AzureRmResource -Tag $resourcetags -ResourceId $r.ResourceId -Force
# 	 }
#     echo ---------------------------
# }
