#requires -Version 7.0
<#
.SYNOPSIS
    Generic, portable, read-only Windows administration dashboard prototype.
.NOTES
    Requires PowerShell 7, Windows desktop, and built-in CIM cmdlets.
    No privileged changes, automatic discovery, installers, or network downloads.
#>
[CmdletBinding()]
param()

if (-not $IsWindows) { throw 'The GUI requires Windows with PowerShell 7.' }

Import-Module (Join-Path $PSScriptRoot 'Modules/Dashboard.Commands.psm1') -Force -ErrorAction Stop
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$form = [System.Windows.Forms.Form]::new()
$form.Text = 'System Administrator Dashboard - Read-Only Prototype'
$form.Size = [System.Drawing.Size]::new(1030, 675)
$form.MinimumSize = [System.Drawing.Size]::new(850, 520)
$form.StartPosition = 'CenterScreen'
$form.BackColor = [System.Drawing.Color]::FromArgb(29, 31, 36)

$heading = [System.Windows.Forms.Label]::new()
$heading.Text = 'SYSTEM ADMINISTRATOR DASHBOARD  |  READ-ONLY'
$heading.ForeColor = [System.Drawing.Color]::Gold
$heading.Font = [System.Drawing.Font]::new('Segoe UI', 14, [System.Drawing.FontStyle]::Bold)
$heading.SetBounds(20, 12, 960, 36)
$heading.Anchor = 'Top,Left,Right'
$form.Controls.Add($heading)

$targetLabel = [System.Windows.Forms.Label]::new()
$targetLabel.Text = 'Target (blank = local):'
$targetLabel.ForeColor = [System.Drawing.Color]::White
$targetLabel.SetBounds(20, 58, 180, 25)
$form.Controls.Add($targetLabel)

$targetBox = [System.Windows.Forms.TextBox]::new()
$targetBox.SetBounds(205, 57, 320, 27)
$targetBox.Anchor = 'Top,Left'
$form.Controls.Add($targetBox)

$commandsList = [System.Windows.Forms.ListBox]::new()
$commandsList.SetBounds(20, 103, 260, 443)
$commandsList.Anchor = 'Top,Bottom,Left'
$commandsList.Font = [System.Drawing.Font]::new('Segoe UI', 10)
$commandsList.DisplayMember = 'Label'
foreach ($item in (Get-DashboardCommands)) { [void]$commandsList.Items.Add($item) }
$form.Controls.Add($commandsList)

$output = [System.Windows.Forms.TextBox]::new()
$output.Multiline = $true
$output.ReadOnly = $true
$output.ScrollBars = 'Both'
$output.WordWrap = $false
$output.BackColor = [System.Drawing.Color]::FromArgb(10, 10, 10)
$output.ForeColor = [System.Drawing.Color]::LightGreen
$output.Font = [System.Drawing.Font]::new('Consolas', 10)
$output.SetBounds(300, 103, 692, 443)
$output.Anchor = 'Top,Bottom,Left,Right'
$form.Controls.Add($output)

function Add-DashboardButton {
    param([string]$Text, [int]$Left, [int]$Width)
    $button = [System.Windows.Forms.Button]::new()
    $button.Text = $Text
    $button.SetBounds($Left, 559, $Width, 37)
    $button.Anchor = 'Bottom,Left'
    $button.BackColor = [System.Drawing.Color]::Gold
    $button.ForeColor = [System.Drawing.Color]::Black
    $button.FlatStyle = 'Flat'
    $form.Controls.Add($button)
    return $button
}

$helpButton = Add-DashboardButton -Text 'AdminHelp' -Left 20 -Width 130
$runButton = Add-DashboardButton -Text 'Run Selected' -Left 165 -Width 135
$clearButton = Add-DashboardButton -Text 'Clear Results' -Left 315 -Width 135
$saveButton = Add-DashboardButton -Text 'Save TXT' -Left 465 -Width 125

$showHelp = {
    $lines = @('AVAILABLE READ-ONLY COMMANDS', 'Double-click a command or select and press Run Selected.', '')
    foreach ($entry in (Get-DashboardCommands)) {
        $lines += ('{0,-23} {1}' -f $entry.Label, $entry.Description)
    }
    $output.ForeColor = [System.Drawing.Color]::Khaki
    $output.Text = ($lines -join [Environment]::NewLine)
}
$runSelected = {
    $entry = $commandsList.SelectedItem
    if ($null -eq $entry) {
        $output.ForeColor = [System.Drawing.Color]::Khaki
        $output.Text = 'Select a command from the left-hand list.'
        return
    }
    try {
        $form.UseWaitCursor = $true
        $output.ForeColor = [System.Drawing.Color]::LightGreen
        $output.Text = "Reading $($entry.Label) from target '$($targetBox.Text)'..."
        $output.Refresh()
        $result = @(Invoke-DashboardCommand -CommandId $entry.Id -Target $targetBox.Text)
        $output.Text = ($result | Format-List * | Out-String -Width 160)
    }
    catch {
        $output.ForeColor = [System.Drawing.Color]::Tomato
        $output.Text = "Read-only operation failed: $($_.Exception.Message)"
    }
    finally { $form.UseWaitCursor = $false }
}
$helpButton.Add_Click($showHelp)
$runButton.Add_Click($runSelected)
$commandsList.Add_DoubleClick($runSelected)
$clearButton.Add_Click({ $output.Clear() })
$saveButton.Add_Click({
    $dialog = [System.Windows.Forms.SaveFileDialog]::new()
    $dialog.Filter = 'Text files (*.txt)|*.txt'
    $dialog.FileName = 'Dashboard-Report.txt'
    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        try { [System.IO.File]::WriteAllText($dialog.FileName, $output.Text) }
        catch { [System.Windows.Forms.MessageBox]::Show($_.Exception.Message, 'Save failed') | Out-Null }
    }
    $dialog.Dispose()
})
& $showHelp
[void]$form.ShowDialog()
$form.Dispose()
