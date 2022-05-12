npm config set registry https://repo.sargassosailor.com:4873
Get-ChildItem -Directory | Foreach-Object { cd $_.FullName; release-it; cd ..  }