function Read-ConfigFile {
  param (
    [Parameter(Mandatory)][string]$Path
  )
  try {
    Get-Content -Path $Path -ErrorAction Stop | ConvertFrom-Json
  }
  catch [System.Management.Automation.ItemNotFoundException] {
    Write-Warning "Could not locate config file:`n$($_.Exception.Message)"
    exit
  }
  catch [System.ArgumentException] {
    Write-Warning "Could not parse config JSON:`n$($_.Exception.Message)"
    exit
  }
  catch {
    Write-Warning "Unknown exception occurred while reading config file:`n$($_.Exception.Message)"
    exit
  }
}

function Sort-DownloadsFolder {
  param (
    [Parameter(Mandatory)][string]$ConfigPath
  )
  $Config = Read-ConfigFile -Path $ConfigPath
  # Reliable method to determine Downloads folder path: https://stackoverflow.com/a/57950443
  $DownloadsFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
}

Sort-DownloadsFolder -ConfigPath "$PSScriptRoot\Sort-DownloadsFolder.json"
