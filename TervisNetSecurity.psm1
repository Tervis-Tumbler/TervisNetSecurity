$ModulePath = if ($PSScriptRoot) {
    $PSScriptRoot
} else {
    (Get-Module -ListAvailable TervisNetSecurity).ModuleBase
}
. $ModulePath\NetSecurityDefinition.ps1

function Get-TervisNetFirewallGroup {
    param (
        $Name
    )
    $FirewallRuleGroups | where Name -EQ $Name
}

function Enable-TervisNetFirewallRuleGroup {
    param (
        $Name,
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]$ComputerName,
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    process {
        $FirewallRuleNames = $Name |
        Get-TervisNetFirewallGroupRule |
        Sort-Object -Unique

        Enable-NetFirewallRule -ComputerName $ComputerName -Credential $Credential -Name $FirewallRuleNames
    }
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
        $RemoteAddress,
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
