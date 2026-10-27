#requires -Version 7.0
# Non-destructive tests; do not contact remote systems.
$ErrorActionPreference = 'Stop'
Import-Module (Join-Path $PSScriptRoot '../src/Modules/Dashboard.Commands.psm1') -Force

$commands = @(Get-DashboardCommands)
if ($commands.Count -ne 4) { throw "Expected 4 commands; found $($commands.Count)" }
if (@($commands.Id | Sort-Object -Unique).Count -ne $commands.Count) { throw 'Duplicate command IDs' }
foreach ($value in @('', '.', 'localhost', 'host01', 'host01.example.test', '192.0.2.10', '2001:db8::1')) {
    if (-not (Test-DashboardTarget -Target $value)) { throw "Valid target rejected: $value" }
}
foreach ($value in @('host name', ';', '*', 'host;calc', '10.0.0.999', '1.2.3', '-host', 'host/secret', 'foo..bar')) {
    if (Test-DashboardTarget -Target $value) { throw "Unsafe target accepted: $value" }
}
Write-Host 'PASS: command allowlist, IDs, and target validation.'
