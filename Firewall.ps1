# Firewall Configuration Script

# Reset firewall and drop all rules
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh advfirewall firewall delete rule name=all
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

# Configure logging
netsh advfirewall set allprofiles logging filename C:\Windows\fw.log
netsh advfirewall set allprofiles logging maxfilesize 32676
netsh advfirewall set allprofiles logging droppedconnections enable
netsh advfirewall set allprofiles logging allowedconnections enable

# Set loopback rule
netsh advfirewall firewall add rule name="Loop-Out" dir=out action=allow remoteip=127.0.0.1
netsh advfirewall firewall add rule name="Loop-In" dir=in action=allow remoteip=127.0.0.1
netsh advfirewall firewall add rule name="Loop-6-Out" dir=out action=allow remoteip=::1
netsh advfirewall firewall add rule name="Loop-6-In" dir=in action=allow remoteip=::1

# Allow ping (ICMPv4)
netsh advfirewall firewall add rule name="Ping-Out" dir=out action=allow protocol=icmpv4:8
netsh advfirewall firewall add rule name="Ping-In" dir=in action=allow protocol=icmpv4:8

# Allow traffic from specific IP address
netsh advfirewall firewall add rule name="Allow Traffic from 172.20.1.1" dir=in action=allow remoteip=172.20.1.1
netsh advfirewall firewall add rule name="Allow Traffic from 172.20.1.1" dir=out action=allow remoteip=172.20.1.1

# Allow traffic from specific IP address
netsh advfirewall firewall add rule name="Allow Traffic from 172.20.1.1" dir=in action=allow remoteip=10.1.1.5
netsh advfirewall firewall add rule name="Allow Traffic from 172.20.1.1" dir=out action=allow remoteip=10.1.1.5