#Installing Domain Controller

1. Use "Sconfig" For
    - Changing HostName
    - Changing IP Address To The Static
    - Changing IP DNS Server To The Our On Ip

2. InstallAactive Directory Windows Feature
'''Shell
Install-WindowsFeature AD-Domain-services -IncludeManagementTools
''' 

3. Configure Active Directory on Windows server
'''
Import-Module ADDSDeployment
Install ADDSForest
    - Give A Domain Name You Want To Give Ex:- bun.com/xyz.com/abc.com
    - Now Give A Password To Service
'''

4. Changing Ip Of DNS Server Through Powershell
DoThisOnClientAndServer'''
Get-NetIPAddress -IPAddress {Our Server IP}
Get-DNSClientServerAddress
    - Changing Ethernet0 IPv4 ServerAddress to the {Our Server IP}
    '''Set-DNSClientServerAddress -InterfaceIndex {Indexof(Ethernet0 IPv4)} -ServerAddresses {Our Server IP}'''
''' 

5. Connect Client To The Server
'''
Get-NetIPAddress -IPAddress {Our Workspace IP}
Get-DNSClientServerAddress
    - Changing Ethernet0 IPv4 ServerAddress to the {Our Workspace IP}
    '''Set-DNSClientServerAddress -InterfaceIndex {Indexof(Ethernet0 IPv4)} -ServerAddresses {Our Workspace IP}'''
Add-Computer -DomainName {Domain Name} -Credential UserName@Domain -Force -Restart

'''