Invoke-Expression (&starship init powershell)

Set-Alias ll Get-ChildItem
Set-Alias g git
Set-Alias v vagrant
Set-Alias touch New-Item
Set-Alias touch New-Item
Set-Alias vim "C:\Users\hasegawa-f.ES-DOMAIN\AppData\Local\Programs\Git\usr\bin\vim.exe"
Set-Alias o explorer.exe
# Set-Alias vimprof vim "C:\Users\hasegawa-f.ES-DOMAIN\Documents\WindowsPowerShell\profile.ps1"

Set-PSReadLineOption -EditMode Emacs -BellStyle None

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

# Chocolatey profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }

# function prompt {
#   $isRoot = (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
#   $color  = if ($isRoot) {"Red"} else {"Green"}
#   $marker = if ($isRoot) {"#"}   else {"$"}

#   Write-Host "$env:USERNAME " -ForegroundColor $color -NoNewline
#     Write-Host "$pwd " -ForegroundColor Magenta -NoNewline
#     Write-Host $marker -ForegroundColor $color -NoNewline
#     return " "
# }
