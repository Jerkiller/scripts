Import-Module Az.Billing

$TenantId = '33333333-6666-4444-aaaa-777799999999' # My Tenant
$Subscription = '33333333-6666-4444-aaaa-777799999999' #MyVisualStudioSub

Connect-AzAccount -TenantId $TenantId
Select-AzSubscription -SubscriptionId $Subscription
Get-AzBillingInvoice -Latest


# Export all the usage data and billing info into a csv file
# https://blogs.technet.microsoft.com/keithmayer/2015/06/30/export-azure-subscription-usage-to-csv-with-new-billing-api-and-powershell/
