# Created by KYUU
# https://github.com/yuuslokrobjakkroval/recycle-bin-themes
# Version 0.1

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$supported_themes = @('patrick-star', 'pop-cat', 'kirby', 'kanna', 'sword-kirby', 'french-fries', 'minecraft-chest')

try {
    if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) {
        throw 'This script requires Windows.'
    }

    $textInfo = (Get-Culture).TextInfo
    Write-Host 'Recycle Bin Themes'
    Write-Host 'Select a theme:'
    for ($index = 0; $index -lt $supported_themes.Count; $index++) {
        $theme_name = $textInfo.ToTitleCase($supported_themes[$index].Replace('-', ' '))
        Write-Host " [$($index + 1)] $theme_name"
    }
    Write-Host ' [0] Default'

    $choiceText = Read-Host 'Choice'
    $choice = 0
    if (-not [int]::TryParse($choiceText, [ref]$choice) -or
        $choice -lt 0 -or $choice -gt $supported_themes.Count) {
        throw "'$choiceText' is an invalid choice. Enter a number from 0 to $($supported_themes.Count)."
    }

    if ($choice -eq 0) {
        $emptyIcon = "$env:SystemRoot\System32\imageres.dll,-55"
        $fullIcon = "$env:SystemRoot\System32\imageres.dll,-54"
        $theme_name = 'Default'
    }
    else {
        $selected_theme = $supported_themes[$choice - 1]
        $theme_name = $textInfo.ToTitleCase($selected_theme.Replace('-', ' '))
        $sourceFolder = Join-Path $PSScriptRoot "themes\$selected_theme"
        foreach ($state in @('empty', 'full')) {
            $source = Join-Path $sourceFolder "$selected_theme-$state.ico"
            if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
                throw "Missing icon: $source. Extract the entire repository, including the themes folder."
            }
        }

        $pictures = [Environment]::GetFolderPath('MyPictures')
        if ([string]::IsNullOrWhiteSpace($pictures)) {
            $pictures = Join-Path $env:USERPROFILE 'Pictures'
        }
        $destination = Join-Path $pictures 'RecycleBinThemes'
        New-Item -ItemType Directory -Path $destination -Force | Out-Null
        foreach ($state in @('empty', 'full')) {
            Copy-Item -LiteralPath (Join-Path $sourceFolder "$selected_theme-$state.ico") -Destination $destination -Force
        }
        $emptyIcon = (Join-Path $destination "$selected_theme-empty.ico") + ',0'
        $fullIcon = (Join-Path $destination "$selected_theme-full.ico") + ',0'
    }

    $registryPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon'
    New-Item -Path $registryPath -Force | Out-Null
    foreach ($entry in @{'(default)' = $emptyIcon; empty = $emptyIcon; full = $fullIcon}.GetEnumerator()) {
        New-ItemProperty -Path $registryPath -Name $entry.Key -Value $entry.Value -PropertyType String -Force | Out-Null
    }

    # Refresh icons without closing File Explorer windows.
    if (-not ('RecycleBinThemes.Shell' -as [type])) {
        Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
namespace RecycleBinThemes {
    public static class Shell {
        [DllImport("shell32.dll")]
        public static extern void SHChangeNotify(uint eventId, uint flags, IntPtr item1, IntPtr item2);
    }
}
"@
    }
    [RecycleBinThemes.Shell]::SHChangeNotify(0x08000000, 0, [IntPtr]::Zero, [IntPtr]::Zero)
    Write-Host "Changed Recycle Bin theme to $theme_name."
}
catch {
    Write-Error "Could not change the Recycle Bin theme: $($_.Exception.Message)" -ErrorAction Continue
    exit 1
}
