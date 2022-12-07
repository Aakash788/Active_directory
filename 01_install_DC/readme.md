#installing domain controller

1. use "Sconfig" for
    - changing hostname
    - changing ip address to the static
    - changing ip dns server to the our on ip
2. install active directory windows feature
'''shell
Install-WindowsFeature AD-Domain-services -IncludeManagementTools
''' 
    