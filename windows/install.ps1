function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Ensure-AdminPrivileges {
    if (-NOT (Test-Administrator)) {
        Write-Host "This script requires administrator privileges." -ForegroundColor Yellow
        Write-Host "Enabling sudo configuration..." -ForegroundColor Yellow
        
        try {
            # Enable sudo configuration
            sudo config --enable enable
            Write-Host "Sudo has been enabled successfully." -ForegroundColor Green
            Write-Host "Please run this script again with 'sudo .\install.ps1'" -ForegroundColor Cyan
        }
        catch {
            Write-Host "Failed to enable sudo: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "Please run this script as an administrator or with 'sudo .\install.ps1'" -ForegroundColor Cyan
        }
        
        # Exit after configuring sudo
        exit
    }
    else {
        Write-Host "Running with administrator privileges." -ForegroundColor Green
    }
}

# Check for admin privileges first
Ensure-AdminPrivileges

function DisableUAC {
    Write-Host "Disabling UAC prompts..."
    
    try {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0 -Force
        Write-Host "UAC has been disabled. A restart is required for changes to take effect." -ForegroundColor Yellow
    }
    catch {
        Write-Host "Failed to disable UAC: $($_.Exception.Message)" -ForegroundColor Red
    }
}

function FixExplorer {
    Write-Host "Fixing Windows Explorer settings..." -ForegroundColor Yellow
    
    try {
        Write-Host "Restoring old right-click context menu..." -ForegroundColor Cyan
        
        # Create the registry key to disable the new context menu
        $registryPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
        
        # Check if the key exists, if not create it
        if (!(Test-Path $registryPath)) {
            New-Item -Path $registryPath -Force | Out-Null
        }
        
        # Set the default value to empty string to disable new context menu
        Set-ItemProperty -Path $registryPath -Name "(default)" -Value "" -Force
        Write-Host "✓ Old context menu restored" -ForegroundColor Green
        
        Write-Host "Configuring developer-friendly folder options..." -ForegroundColor Cyan
        
        # Registry path for Windows Explorer advanced settings
        $explorerAdvanced = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        
        # Show hidden files, folders, and drives
        Set-ItemProperty -Path $explorerAdvanced -Name "Hidden" -Value 1 -Force
        Write-Host "✓ Show hidden files and folders" -ForegroundColor Green
        
        # Show protected operating system files (super hidden files)
        Set-ItemProperty -Path $explorerAdvanced -Name "ShowSuperHidden" -Value 1 -Force
        Write-Host "✓ Show protected operating system files" -ForegroundColor Green
        
        # Show file extensions for known file types
        Set-ItemProperty -Path $explorerAdvanced -Name "HideFileExt" -Value 0 -Force
        Write-Host "✓ Show file extensions" -ForegroundColor Green
        
        # Show full path in title bar
        Set-ItemProperty -Path $explorerAdvanced -Name "ShowInfoTip" -Value 1 -Force
        Write-Host "✓ Show full path in title bar" -ForegroundColor Green
        
        # Display the full path in the address bar
        $cabinetState = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState"
        if (!(Test-Path $cabinetState)) {
            New-Item -Path $cabinetState -Force | Out-Null
        }
        Set-ItemProperty -Path $cabinetState -Name "FullPath" -Value 1 -Force
        Write-Host "✓ Display full path in address bar" -ForegroundColor Green
        
        # Show empty drives
        Set-ItemProperty -Path $explorerAdvanced -Name "HideDrivesWithNoMedia" -Value 0 -Force
        Write-Host "✓ Show empty drives" -ForegroundColor Green
        
        # Show status bar in Explorer
        Set-ItemProperty -Path $explorerAdvanced -Name "ShowStatusBar" -Value 1 -Force
        Write-Host "✓ Show status bar" -ForegroundColor Green
        
        # Navigation pane options
        Set-ItemProperty -Path $explorerAdvanced -Name "NavPaneExpandToCurrentFolder" -Value 1 -Force
        Write-Host "✓ Expand to current folder in navigation pane" -ForegroundColor Green
        
        Write-Host "Windows Explorer has been fixed successfully!" -ForegroundColor Green
        Write-Host "You may need to restart Explorer to see all changes." -ForegroundColor Yellow
    }
    catch {
        Write-Host "Failed to fix Explorer settings: $($_.Exception.Message)" -ForegroundColor Red
    }
}

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

# make Windows usable
DisableUAC
FixExplorer

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
