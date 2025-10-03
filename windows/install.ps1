function InstallWinGet {
    param (
        [string]$PackageName
    )

    Write-Host "Installing $PackageName..."
    # Use WinGet to install the package and automatically accept prompts
    winget install --id $PackageName --accept-source-agreements --accept-package-agreements --silent
    
    if ($?) {
        Write-Host "Installation of $PackageName completed successfully."
    }
    else {
        Write-Host "Installation of $PackageName encountered an error."
    }
}

# essentials
InstallWinGet("Mozilla.Firefox" )
InstallWinGet("Google.Chrome" )
InstallWinGet("voidtools.Everything" )
InstallWinGet("Autohotkey.AutoHotkey" )
InstallWinGet("Microsoft.PowerToys" )
InstallWinGet("7zip.7zip" )
InstallWinGet("VideoLAN.VLC")

# dev tools
InstallWinGet("Notepad++.Notepad++")
InstallWinGet("SublimeHQ.SublimeText.4")
InstallWinGet("MHNexus.HxD")
InstallWinGet("Meld.Meld")
InstallWinGet("Microsoft.VisualStudioCode")
InstallWinGet("Microsoft.PowerShell")
InstallWinGet("Microsoft.Sysinternals.Suite")

if ((Read-Host "Do you want to install fun stuff? (y/n)") -eq 'y') {
    InstallWinGet("qBittorrent.qBittorrent")
    InstallWinGet("Valve.Steam")
}
