# Making ADUser ANd Group Form A JSON File

1. In ad_schema.json make Define:-
    - User
    - Group
    - Domain

2. Write Powershell File For Creating ADUser And ADGroup
    (Use gen_ad.ps1 As A Reference)

3. store gen_ad.ps1 and ad_schema.json on server and run 
    - cp .\ad_schema.json -ToSession $dc c:\Windows\Task
    - Where $dc = New-Session -ComputerName {Server IP} -Credential (Get-Credential)