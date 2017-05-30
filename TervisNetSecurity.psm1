$FirewallRuleGroups = [PSCustomObject][Ordered] @{
    Name = "BasicVM"
    FirewallRule = @"
vm-monitoring-dcom
vm-monitoring-icmpv4
vm-monitoring-icmpv6
vm-monitoring-nb-session
vm-monitoring-rpc
SNMPTRAP-In-UDP
SNMPTRAP-In-UDP-NoScope
Wininit-Shutdown-In-Rule-TCP-RPC
Wininit-Shutdown-In-Rule-TCP-RPC-EPMapper
EventForwarder-In-TCP
EventForwarder-RPCSS-In-TCP
Netlogon-NamedPipe-In
Netlogon-TCP-RPC-In
RemoteTask-In-TCP
RemoteTask-RPCSS-In-TCP
RemoteDesktop-UserMode-In-TCP
RemoteDesktop-UserMode-In-UDP
RemoteDesktop-Shadow-In-TCP
RVM-VDS-In-TCP
RVM-VDSLDR-In-TCP
RVM-RPCSS-In-TCP
RemoteEventLogSvc-In-TCP
RemoteEventLogSvc-NP-In-TCP
RemoteEventLogSvc-RPCSS-In-TCP
PerfLogsAlerts-PLASrv-In-TCP
PerfLogsAlerts-DCOM-In-TCP
PerfLogsAlerts-PLASrv-In-TCP-NoScope
PerfLogsAlerts-DCOM-In-TCP-NoScope
FPS-NB_Session-In-TCP
FPS-SMB-In-TCP
FPS-NB_Name-In-UDP
FPS-NB_Datagram-In-UDP
FPS-SpoolSvc-In-TCP
FPS-RPCSS-In-TCP
FPS-ICMP4-ERQ-In
FPS-ICMP6-ERQ-In
FPS-LLMNR-In-UDP
RemoteSvcAdmin-In-TCP
RemoteSvcAdmin-NP-In-TCP
RemoteSvcAdmin-RPCSS-In-TCP
WMI-ASYNC-In-TCP
WMI-RPCSS-In-TCP
WMI-WINMGMT-In-TCP
RemoteFwAdmin-In-TCP
RemoteFwAdmin-RPCSS-In-TCP
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "BartenderCommander"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "BartenderLicenseServer"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "Progistics"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "WCSJavaApplication"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "PrintServer"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "DirectAccess"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCDPM2016"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "WindowsFileserver"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "KafkaBroker"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "Phishing"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RemoteWebBrowserApp"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "OraDBARMTDkt"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "StoresRemoteDesktop"
    FirewallRuleGroupsToImport = "BasicVM"
}

function Get-TervisNetFirewallGroup {
    param (
        $Name
    )
    $FirewallRuleGroups | where Name -EQ $Name
}

function Enable-TervisNetFirewallRuleGroup {
    param (
        $Name,
        [Parameter(Mandatory)]$ComputerName,
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    $FirewallRuleNames = $Name |
    Get-TervisNetFirewallGroupRule |
    Sort-Object -Unique

    Enable-NetFirewallRule -ComputerName $ComputerName -Credential $Credential -Name $FirewallRuleNames
}

function Get-TervisNetFirewallGroupRule {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]$Name
    )
    process {
        $FirewallGroup = Get-TervisNetFirewallGroup -Name $Name
        if ($FirewallGroup.FirewallRuleGroupsToImport) {
            $FirewallGroup.FirewallRuleGroupsToImport | Get-TervisNetFirewallGroupRule
        }
        $FirewallGroup.FirewallRule
    }
}

function Enable-NetFirewallRule {
    param (
        [Parameter(Mandatory)]$ComputerName,
        $Credential = [System.Management.Automation.PSCredential]::Empty,
        [Parameter(Mandatory)]$Name
    )
    Invoke-Command -ComputerName $ComputerName -Credential $Credential {
        $Using:Name | foreach {
            Get-NetFirewallRule -Name $_ |
            Set-NetFirewallRule -Enabled True
        }
    }
}

function Compare-NetFirewallRuleBetweenComputers {
    param (
        $ReferenceComputer,
        $DifferenceComputer
    )
    $ReferenceRules = invoke-command -ScriptBlock {get-netfirewallrule} -ComputerName $ReferenceComputer
    $DifferenceRules = invoke-command -ScriptBlock {get-netfirewallrule} -ComputerName $DifferenceComputer
    Compare-Object -ReferenceObject $ReferenceRules -DifferenceObject $DifferenceRules -Property Name,Enabled
}

function New-TervisFirewallRule {
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$ComputerName,
        [Parameter(Mandatory)]$DisplayName,
        [Parameter(Mandatory)]$LocalPort,
        [Parameter(Mandatory)]$Name,
        [Parameter(Mandatory)]$Group,
        [ValidateSet("Inbound","Outbound")]$Direction = "Inbound",
        [ValidateSet("Allow","Block","NotConfigured")]$Action = "Allow",
        $Protocol = "TCP",
        [Switch]$Force
    )
    begin {
        $FirewallSplatVariable = New-SplatVariable -Invocation $MyInvocation -Variables (Get-Variable) -ExcludeProperty ComputerName,Force
    }
    process {
        $CimSession = New-CimSession -ComputerName $ComputerName
        $FirewallRule = Get-NetFirewallRule -DisplayName $DisplayName -ErrorAction SilentlyContinue -CimSession $CimSession
        if (-not $FirewallRule -or $Force) {
            Remove-NetFirewallRule -Name $Name -ErrorAction SilentlyContinue -CimSession $CimSession
            New-NetFirewallRule @FirewallSplatVariable -CimSession $CimSession
        }
        Remove-CimSession -CimSession $CimSession
    }
}
