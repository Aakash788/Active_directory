param(
    [Parameter(Mandatory=$true)] $OutputJSONFile,
    [int]$UserCount,
    [int]$GroupCount,
    [int]$LocalAdminCount

    )

$group_names=[System.Collections.ArrayList](Get-Content "data/group_name.txt")
$first_names=[System.Collections.ArrayList](Get-Content "data/first_name.txt")
$last_names=[System.Collections.ArrayList](Get-Content "data/last_name.txt")
$password=[System.Collections.ArrayList](Get-Content "data/password.txt")


$group= @()
$user= @()
# Default UserCount set to 5
if ($UserCount -eq 0){
    $UserCount = 5
}
# Default GroupCount set to 5
if ($groupCount -eq 0){
    $groupCount = 5
}
if ($LocalAdminCount -ne 0){
    $local_admin_indexes= @()
    while (($local_admin_indexes | Measure-Object).Count -lt $LocalAdminCount) {
        $random_index = (Get-Random -InputObject (1..($UserCount)) | Where-Object{$local_admin_indexes -notcontains $_})
        $local_admin_indexes+=@($random_index)
        echo "adding $random_index to local_admin_indexs $local_admin_indexes"
    }
}

for ($i = 1; $i -le $GroupCount; $i++){
    $group_name=(Get-Random -InputObject $group_names)
    $group = @{"name"="$group_name"}
    $group +=$group
    $group_names.Remove($group_names)
}

for ($i = 1; $i -le $UserCount; $i++){
    $first_name=(Get-Random -InputObject $first_names)
    $last_name=(Get-Random -InputObject $last_names)
    $password=(Get-Random -InputObject $password)
    $new_user= @{`
    "name"="$first_name $last_name"
    "password"="$password"
    "groups"=(Get-Random -InputObject $group).name
    }
    if($local_admin_indexes | where {$_ -eq $i }){
        echo "user $i is local admin"
        $new_user["local_admin"]= $true
    }
    $user +=$new_user
    $first_names.Remove($first_names)
    $last_names.Remove($last_names)
    $password.Remove($password)
}

ConvertFrom-Json -InputObject @{
    "domain"= "bun.com"
    "group"=$group
    "users"=$user
} | Out-File$OutputJSONFile
