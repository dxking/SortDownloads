
# Script must be run from the same folder as sd-config
# Otherwise change parameter ConfigPath when launching
Param(
    [string]$ConfigPath = ".\sd-config",
    [string]$FolderPath = "C:\Users\$env:UserName\Downloads\",
    [string]$LogPath = "."
)

$Config = Import-Csv -Path $ConfigPath
$Files = $FolderPath | Get-ChildItem
$LogName = "sdlog_$(Get-Date -Format MMddyyyy-hhmmss).txt"   
New-Item -Path $LogPath -Name $LogName

ForEach($Extension in $Config) {
    ForEach($File in $Files) {
        if($File.Extension -eq $Extension.Extension) {
            if(!(Test-Path $Extension.Path -PathType Container)) {
                New-Item -Path $Extension.Path -ItemType Directory
            }
            Move-Item (Join-Path $FolderPath $File) $Extension.Path -Force
            Add-Content -Path (Join-Path $LogPath $LogName) -Value "Moved <$File> from <$FolderPath> to <$($Extension.Path)>"
        }    
    }
}

if(!(Get-Content $LogName)){
    Remove-Item $LogName
}
