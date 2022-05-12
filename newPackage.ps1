$PackName = Read-Host "Please enter package name(com.x.x)"
$PackFullName = Read-Host "Please enter proper package name"
& "mkdir" $PackName
& "cd" $PackName
& "git" "init"
& "gh" "repo" "create" "UPM-$PackFullName" "--confirm" "--private" "-g" "Unity"
& "git" "pull" "origin" "main"
& "git" "branch" "--set-upstream-to=origin/main"
& "npm" "init"
& "git" "add" "."
& "git" "commit" "-m" "initial commit"
& "git" "push"
& "cd" ".."