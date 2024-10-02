# WinRM Configuration Script

# Enable WinRM
Enable-PSRemoting -Force

# Delete existing HTTP/HTTPS listeners
winrm delete winrm/config/Listener?Address=*+Transport=HTTP
winrm delete winrm/config/Listener?Address=*+Transport=HTTPS

# Create new listener on specific IP
winrm create winrm/config/Listener?Address=IP:10.1.1.5+Transport=HTTP

# Disable Basic and Digest Authentication
winrm set winrm/config/service/auth @{Basic="false"}
winrm set winrm/config/service/auth @{Digest="false"}

# Enable Kerberos and NTLM Authentication
winrm set winrm/config/service/auth @{Kerberos="true"}
winrm set winrm/config/service/auth @{NTLM="true"}

# Enforce TLS and Require Encryption
winrm set winrm/config/service @{Auth="TLS"}
winrm set winrm/config/service @{AllowUnencrypted="false"}

# Set maximum session timeout to 30 minutes
winrm set winrm/config @{MaxTimeoutms="1800000"}

# Configure Windows Firewall Rules
New-NetFirewallRule -DisplayName "Allow WinRM from Trusted IP" -Direction Inbound -Protocol TCP -LocalPort 5985,5986 -RemoteAddress 10.1.1.5 -Action Allow
New-NetFirewallRule -DisplayName "Allow WinRM from Trusted IP" -Direction Inbound -Protocol TCP -LocalPort 5985,5986 -RemoteAddress 172.20.1.1 -Action Allow
New-NetFirewallRule -DisplayName "Block All Other WinRM" -Direction Inbound -Protocol TCP -LocalPort 5985,5986 -RemoteAddress Any -Action Block
