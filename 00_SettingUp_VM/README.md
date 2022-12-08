# Install VM  

1. Installing Windows 11 Without TPM
    - Press Shift+F10
    - Open Terminal
        - Write regedit
        "Computer\HKEY_LOCAL_MACHINE\SYSTEM\Setup" RightClick New>Key LabConfig
        - In LabConfig Add>key>DWORD (32 bit) value>KeyName>KeyValue(1)(Hexa)
        - KeyName 
            - BypassTPMCheck
            - BypassRAMCheck
            - BypassSecureBootCheck

            Close regedit And Install Windows 11
            # Note :- Dont Restart Just Close regedit
2. For Connecting To The Server With PSRemoting
OnServer'''
- Enable PSRemoting
'''
            
OnClient'''
- Start-Service WinRM
- Get-wsman:\localhost\Client\TrustedHost
- Set-item wsman:\localhost\Client\TrustedHost -Value {Server IP}
- New-PSSession -CompuetrName {Server IP} -Credential (Get-Credential) {Administrator>Password}
- Enter-PSSession {Session ID}
'''