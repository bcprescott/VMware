<#

  =============================================================================================

                 ** This script needs to be ran from a vCenter server...** 

                         It does not matter which vCenter server..

             If running from PowerCLI directly, exclude the Add-PSSnapin line.

  =============================================================================================
#>


# Adding the PowerCLI snap-in for running from a .ps1
Add-PSSnapin VMware.VimAutomation.Core

# Connects to the two vSphere servers. Add more here if you want to query more in the future.
Connect-VIserver -server server1,server2

# General commenting
Write-Host ""
Write-Host "***** CSV files are being created in #LOCATION#  *****"
Write-Host ""

# Queries ESX hosts and what cluster and datacenter they belong to, then sorts descending by cluster and datacenter. Exports to CSV.
get-vmhost | Select Name, @{N=”Cluster”;E={Get-Cluster -VMHost $_}},@{N=”Datacenter”;E={Get-Datacenter -VMHost $_}} | `
Sort-Object Cluster,Datacenter -Descending | Export-Csv -path c:\Clusters_Datacenters.csv

# Queries ESX hosts and what VMs are running on those hosts. Exports to CSV.
Get-VM | Select Name,VMHost | Sort-Object name -Descending| Export-Csv -path c:\\VMs_Hosts.csv

# More commenting
Write-host "***** CSV files successfully created! *****"

# Pends closure for 3 seconds to show completion
Start-Sleep -Seconds 3