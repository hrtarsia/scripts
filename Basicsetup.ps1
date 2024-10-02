# Look for recently created files in System32
Write-Host "Looking for recently created files in System32"
Get-ChildItem C:\Windows\System32 | Sort-Object LastWriteTime

# Clear scheduled tasks
Write-Host "Clearing all scheduled tasks"
schtasks /delete /tn * /f

# Remove permissions from C:\Windows\Temp
Write-Host "Removing permissions from C:\Windows\Temp"
icacls C:\Windows\Temp /inheritance:r /deny "Everyone:(OI)(CI)(F)"

# Setting Registry Keys

# Disable SMBv1
Write-Host "Disabling SMBv1"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'SMB1' -Value 0 -Force

# Enable LSASS Protection
Write-Host "Enabling LSASS Protection"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'RunAsPPL' -Value 1 -Force

# Disable LM hashes
Write-Host "Disabling LM Hashes"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'NoLMHash' -Value 1 -Force

# Force NTLMv2
Write-Host "Forcing NTLMv2"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'LMCompatibilityLevel' -Value 5 -Force

# Restrict anonymous access
Write-Host "Restricting anonymous access"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'restrictanonymous' -Value 1 -Force

# Disable RDP if not needed
Write-Host "Disabling RDP if not needed"
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 1 -Force

# Disable sticky keys
Write-Host "Disabling Sticky Keys"
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Value 506 -Force

# Disable toggle keys
Write-Host "Disabling Toggle Keys"
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\ToggleKeys' -Name 'Flags' -Value 58 -Force

# Disable filter keys
Write-Host "Disabling Filter Keys"
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'Flags' -Value 122 -Force

# Disable on-screen keyboard
Write-Host "Disabling On-Screen Keyboard"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI' -Name 'ShowTabletKeyboard' -Value 0 -Force

