$TemplateLoc = "k:\unity\UnityTemplate"
#support for template in github
#read .secrets file as json.
$UnityLoc2020 = "G:\Unity\2020.3.33f1\Editor\Unity"
$UnityLoc2021 = "G:\Unity\2021.3.1f1\Editor\Unity"
$PackName = Read-Host "Please enter Game name"
$option = Read-Host "Use Unity 2020LTS or 2021?(enter 2020 or 2021)"
if($option -eq "2020")
{
	$UnityLoc = $UnityLoc2020;
}
elseif($option -eq "2021")
{
	$UnityLoc = $UnityLoc2021;
}

$secrets = Get-Content -Path .secrets | ConvertFrom-Json
$license = Get-Content -Path $secrets.UNITY_LICENSE

#$PackType = Read-Host "2D or 3D"
#https://cli.github.com/manual/gh_secret_set
#make sure to turn brotli compression off for webgl
& "mkdir" $PackName
& "cd" $PackName
& "git" "init"
& "gh" "repo" "create" "Unity-$PackName" "--confirm" "--private" "-g" "Unity"
& "git" "pull" "origin" "main"
& "git" "branch" "--set-upstream-to=origin/main"
& "git" "add" "."
& "git" "commit" "-m" "initial commit"
& "git" "push"
#$path = git remote get-url origin
& gh secret set BUTLER_API_KEY --body $secrets.BUTLER_API_KEY
& gh secret set DISCORD_WEBHOOK --body $secrets.DISCORD_WEBHOOK
& gh secret set UNITY_EMAIL --body $secrets.UNITY_EMAIL
& gh secret set UNITY_LICENSE --body $license
& gh secret set UNITY_PASSWORD --body $secrets.UNITY_PASSWORD
& "cd" ".."
Write-Output "Creating Unity Project. Please Quit Unity after this is finished to continue."
& $UnityLoc "-createProject" $PackName | Out-Null
& "cd" $PackName
& "xcopy" $TemplateLoc "." "/E/H/C/I/Y"
& "git" "add" "."
& "git" "commit" "-m" "added project+workflow"
& "git" "push"
& "cd" ".."