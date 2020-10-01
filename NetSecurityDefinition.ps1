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
    Name = "HyperVReplica"
    FirewallRule = @"
VIRT-HVRHTTPL-In-TCP-NoScope
VIRT-HVRHTTPSL-In-TCP-NoScope
"@ -split "`r`n" 
},
[PSCustomObject][Ordered] @{
    Name = "BartenderCommander"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "BartenderIntegrationService"
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
    Name = "ScheduledTasks"
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
    Name = "OracleDBA Remote Desktop"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "StoresRemoteDesktop"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RMSHQManagerRemoteApp"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "KeyscanRemoteApp"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "WCSRemoteApp"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RemoteDesktopGateway"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCDPM2016FileServer"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCDPM2016SQL"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCDPMOraBackups"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "DataLoadClassic"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster5"
    FirewallRuleGroupsToImport = "BasicVM","HyperVReplica"
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster6"
    FirewallRuleGroupsToImport = "BasicVM","HyperVReplica"
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster5Evergreen"
    FirewallRuleGroupsToImport = "BasicVM","HyperVReplica"
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster6Evergreen"
    FirewallRuleGroupsToImport = "BasicVM","HyperVReplica"
},
[PSCustomObject][Ordered] @{
    Name = "VDICluster1"
    FirewallRuleGroupsToImport = "BasicVM","HyperVReplica"
},
[PSCustomObject][Ordered] @{
    Name = "StandaloneHyperVServer"
    FirewallRuleGroupsToImport = "BasicVM","HyperVReplica"
},
[PSCustomObject][Ordered] @{
    Name = "WindowsApps"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "EBSRemoteApp"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "EBSBusinessIntelligenceRemoteApp"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "EBSDiscovererRemoteApp"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "EMC Storage Integrator for Windows Suite"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "iSNS"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SQL Anywhere"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RemoteDesktopLicensing"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "ADFS"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "ADFSProxy"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "DomainController"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SilverlightIE"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "FedExShipManager"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCCM2016"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "ZeroTier Router"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "UnifiController"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "AzureBackupServer"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SMTPRelay"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "ITToolbox"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "WindowsAdminCenterGateway"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "AzureADConnector"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "UniversalDashboard"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "CertificateAuthority"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject]@{
    Name = "nChannelSyncManager"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "Passwordstate"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "NestedHyperVCluster"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "Windows Subsystem for Linux Server"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "Sylint"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "InDesign"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "MFANPS"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "MFANPSRDGateway"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "MFANPSRDBroker"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "AzureMFANPS"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "StoresRegister"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "Exchange"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "VPNTest"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "AlwaysOn"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "VendorVPN"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "ExcelTask"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "DomainJoin"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "ShopifyInterface"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RemoteDesktopGateway"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RemoteDesktopBroker"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RemoteDesktopWebAccess"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "RDPJumpBox"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "FedExShipManagerServer"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "HyperVCluster7"
    FirewallRuleGroupsToImport = "BasicVM","HyperVReplica"
},
[PSCustomObject][Ordered] @{
    Name = "RiminiSupport"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "OracleDR"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "AcronisFileServer"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCOM2019"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "ChannelAdvisor"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCVMM2019"
    FirewallRuleGroupsToImport = "BasicVM"
},
[PSCustomObject][Ordered] @{
    Name = "SCDPM2019"
    FirewallRuleGroupsToImport = "BasicVM"
}