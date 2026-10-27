Set-StrictMode -Version Latest

function Test-DashboardTarget {
    [CmdletBinding()]
    param([AllowEmptyString()][string]$Target = '')

    $name = $Target.Trim()
    if ($name -in @('', '.', 'localhost')) { return $true }
    if ($name.Length -gt 253 -or $name -match '[^a-zA-Z0-9.:-]') { return $false }

    if ($name.Contains(':')) {
        $parsed = $null
        return [System.Net.IPAddress]::TryParse($name, [ref]$parsed)
    }

    if ($name -match '^[0-9.]+$') {
        $pieces = $name.Split('.')
        if ($pieces.Count -ne 4) { return $false }
        foreach ($piece in $pieces) {
            $octet = 0
            if ($piece -notmatch '^\d{1,3}$' -or
                -not [int]::TryParse($piece, [ref]$octet) -or
                $octet -gt 255) { return $false }
        }
        return $true
    }

    foreach ($label in $name.Split('.')) {
        if ($label.Length -gt 63 -or $label -notmatch '^[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$') {
            return $false
        }
    }
    return $true
}

function Get-DashboardCommands {
    [CmdletBinding()]
    param()
    @(
        [pscustomobject]@{ Id='system';       Label='System Information'; Description='OS, build, boot time, model and memory (CIM)' }
        [pscustomobject]@{ Id='services';     Label='Windows Services';   Description='Read-only service status (CIM)' }
        [pscustomobject]@{ Id='network';      Label='Network Configuration'; Description='Enabled network interfaces, IP and DNS (CIM)' }
        [pscustomobject]@{ Id='reachability'; Label='Ping Target'; Description='Single ICMP availability check' }
    )
}

function Get-DashboardCimData {
    param(
        [Parameter(Mandatory)][string]$ClassName,
        [AllowNull()][Microsoft.Management.Infrastructure.CimSession]$Session
    )
    if ($null -eq $Session) {
        return Get-CimInstance -ClassName $ClassName -ErrorAction Stop
    }
    return Get-CimInstance -CimSession $Session -ClassName $ClassName -ErrorAction Stop
}

function Invoke-DashboardCommand {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][ValidateSet('system','services','network','reachability')][string]$CommandId,
        [AllowEmptyString()][string]$Target = ''
    )

    if (-not (Test-DashboardTarget -Target $Target)) {
        throw 'Invalid target. Specify one approved hostname, FQDN, or IP address; no commands, wildcards, or ranges.'
    }
    $name = $Target.Trim()
    $local = $name -in @('', '.', 'localhost', [Environment]::MachineName)
    $displayName = if ($local) { [Environment]::MachineName } else { $name }

    if ($CommandId -eq 'reachability') {
        $reachable = if ($local) { $true } else {
            Test-Connection -TargetName $name -Count 1 -Quiet -ErrorAction Stop
        }
        return [pscustomobject]@{ Target=$displayName; Reachable=[bool]$reachable; Method='ICMP'; Checks=1 }
    }

    $session = $null
    try {
        # Remote CIM uses WinRM/WSMan and the current Windows logon credentials.
        # No remote command execution, registry edits, service changes or discovery.
        if (-not $local) {
            $session = New-CimSession -ComputerName $name -OperationTimeoutSec 15 -ErrorAction Stop
        }

        switch ($CommandId) {
            'system' {
                $os = Get-DashboardCimData -ClassName Win32_OperatingSystem -Session $session
                $cs = Get-DashboardCimData -ClassName Win32_ComputerSystem -Session $session
                $caption = [string]$os.Caption
                if ([int]$os.ProductType -eq 1 -and [int]$os.BuildNumber -ge 22000) {
                    $caption = $caption -replace 'Windows 10', 'Windows 11'
                }
                return [pscustomobject]@{
                    Target      = $displayName
                    OS          = $caption
                    OSVersion   = $os.Version
                    Build       = $os.BuildNumber
                    LastBoot    = $os.LastBootUpTime
                    Model       = $cs.Model
                    MemoryGB    = [math]::Round([double]$cs.TotalPhysicalMemory / 1GB, 1)
                }
            }
            'services' {
                return Get-DashboardCimData -ClassName Win32_Service -Session $session |
                    Sort-Object Name |
                    Select-Object Name, DisplayName, State, StartMode
            }
            'network' {
                return Get-DashboardCimData -ClassName Win32_NetworkAdapterConfiguration -Session $session |
                    Where-Object { $_.IPEnabled } |
                    Select-Object Description, IPAddress, IPSubnet, DefaultIPGateway, DNSServerSearchOrder
            }
        }
    }
    finally {
        if ($null -ne $session) { Remove-CimSession -CimSession $session }
    }
}

Export-ModuleMember -Function Test-DashboardTarget, Get-DashboardCommands, Invoke-DashboardCommand
