<#
How to use this script:

run following command in PowerShell terminal:


```powershell
set-executionpolicy -executionpolicy remotesigned -scope currentuser; irm https://raw.githubusercontent.com/Utsav-56/help/refs/heads/main/git_setup.ps1 | iex
```
#>

$git_username = "anishaneupne100-design"
$git_email = "anisha.neupane.100@gmail.com"

$remote_repo = "https://github.com/$git_username/forestsoul_.git"

$project_root = "d:\\forestsoul"

git config --global user.name $git_username
git config --global user.email $git_email
git config --global core.autocrlf true
git config --global pull.rebase false

# automatically set name of default branch to 'main' instead of 'master'
git config --global init.defaultBranch main

Write-Host "Git global configuration set:"

Write-Host "Username: $git_username"
Write-Host "Email: $git_email"

cd $project_root

# initialize a new git repository if one doesn't exist
if (-not (Test-Path ".git")) {
    git init
    Write-Host "Initialized a new git repository in $project_root"
} else {
    Write-Host "Git repository already exists in $project_root"
}

# check if the remote 'origin' is already set
$remote_url = git remote get-url origin 2>$null
if (-not $remote_url) {

    git remote add origin $remote_repo
    Write-Host "Added remote repository: $remote_repo"
} else {
    Write-Host "Remote 'origin' already set to: $remote_url"
}

#  create an initial commit if there are no commits yet
$commit_count = git rev-list --count HEAD 2>$null
if ($commit_count -eq 0) {
    git add .
    git commit -m "Initial commit"
    Write-Host "Created initial commit."
} else {
    Write-Host "Repository already has commits."
}

# current repo has a ReadMe file, pull first to avoid conflicts
git pull origin main --allow-unrelated-histories


# push to remote repository check if any conflicts exists 
git push -u origin main
if ($LASTEXITCODE -eq 0) {
    Write-Host "Pushed to remote repository successfully."
} else {
    Write-Host "Failed to push to remote repository. Please resolve any conflicts and try again."
}


Write-Host "Git setup complete."
Write-Host "`n`n Your Repo url: https://github.com/$git_username/forestsoul_.git `n`n"