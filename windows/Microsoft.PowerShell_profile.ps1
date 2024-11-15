Write-Output "<----- Loading Eric's Super Awesome Profile ----->"

# GIT
function GitStatus { & git status $args }
New-Alias -Name gs -Value GitStatus

function GitAddPatchInteractive { & git add --patch --interactive $args }
New-Alias -Name gapi -Value GitAddPatchInteractive

function GitSubmoduleUpdate { & git submodule update --init --recursive $args }
New-Alias -Name gsu -Value GitSubmoduleUpdate

function CdD { & Set-Location D:\}
New-Alias -Name cdd -Value CdD

# Linux muscle memory
function LsList { & Get-ChildItem $args }
New-Alias -Name ll -Value LsList

