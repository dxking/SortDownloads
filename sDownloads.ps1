# sd-config.csv needs to stay with sDownloads.ps1
# or change the path if you want sd-config.csv somewhere else
$Config = Import-Csv -Path .\sd-config.csv

# Will work fine as long as this is the folder you use for downloads
$Downloads = "C:\Users\$env:UserName\Downloads\"

$Files = $Downloads | Get-ChildItem
$FileNames = $Files.Name

ForEach($e in $Config) {
    ForEach($f in $FileNames) {
        $FilePath = $Downloads + $f
        $FileExtension = [IO.Path]::GetExtension($f)
        if($FileExtension -eq $e.Extension){
            Move-Item -Path $FilePath -Destination $e.Path
        }    
    }
  }