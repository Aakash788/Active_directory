param( [Parameter(Mandatory=$true)] $JsonFile)

function CreateADGruop {
    param( [Parameter(Mandatory=$true)] $gruopObject)
    $name= $gruopObject.name
    New-ADGroup -Name $name -GruopScope Globle
}
function CreateADUser() {
    param( [Parameter(Mandatory=$true)] $userObject)
    # pull out name form json object
    $name=$userObject.name
    $password=$userObject.password
    # genrate "first initial,last name" as a user name
    $firstname , $lastname = $name.split(" ")
    $username =($firstname[1]+$lastname).ToLower()
    $samAccountName =$username
    $principalName =$username

    #creating new user
    Add-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $samAccountName -UserPrincipalName $principalName@$Globle:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force )-PassThru | Enable ADAccount 
    # Write-Output $userObject
    foreach ($group_name in $gruopObject.groups){
        try{
            Get-ADGroup -Identity "$group_name"
            Add-ADGruopMember -Identity $group_name -Members $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]{
            Write-Warning "User $name NOT  added to group $group_name becoz it doesnt exist"
        }
    }

}
$json = (Get-Content $JsonFile | ConvertFrom-Json)
$Globle:Domain = $json.domain
foreach ($group in $json.groups){
    CreateADGruop $group
}
foreach ($user in $json.user){
    CreateADUser $user
}