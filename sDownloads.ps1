# Check directory sDownloads.ps1 runs from for sd-config file
$ConfigPath = $PSScriptRoot + "\sd-config"

# sd-config needs to stay with sDownloads.ps1
# Change the path if you want sd-config somewhere else
$Config = Import-Csv -Path $ConfigPath

# Will work fine as long as you use the default Downloads folder
$Downloads = "C:\Users\$env:UserName\Downloads\"

$Files = $Downloads | Get-ChildItem
$FileNames = $Files.Name

ForEach($e in $Config) {
    ForEach($f in $FileNames) {
        $FilePath = $Downloads + $f
        $FileExtension = [IO.Path]::GetExtension($f)

        if($FileExtension -eq $e.Extension) {
            # Create destination folder if it doesn't exist
            if(!(Test-Path $e.Path -PathType Container)) {
                New-Item -Path $e.Path -ItemType Directory 
            }
            Move-Item -Path $FilePath -Destination $e.Path
        }    
    }
}
