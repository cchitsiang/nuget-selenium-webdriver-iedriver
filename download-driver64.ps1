# constants
$version = "3.0"
$build = "0"
$driverNameInZip = "IEDriverServer.exe"
$driverName = "IEDriverServer64.exe"
$zipName = "IEDriverServer_x64_$version.$build.zip"
$downloadurl = "https://selenium-release.storage.googleapis.com/$version/$zipName"

# move current folder to where contains this .ps1 script file.
$scriptDir = Split-Path $MyInvocation.MyCommand.Path
pushd $scriptDir

$currentPath = Convert-Path "."
$zipPath = Join-Path $currentPath $zipName

# download driver .zip file if not exists.
if (-not (Test-Path ".\$zipName")){
    (New-Object Net.WebClient).Downloadfile($downloadurl, $zipPath)
    if (Test-Path ".\$driverName") { del ".\$driverName" }
}

# Decompress .zip file to extract driver .exe file.
if (-not (Test-Path ".\$driverName")) {
    $shell = New-Object -com Shell.Application
    $zipFile = $shell.NameSpace($zipPath)

    $zipFile.Items() | `
    where {(Split-Path $_.Path -Leaf) -eq $driverNameInZip} | `
    foreach {
        $currentDir = $shell.NameSpace((Convert-Path "."))
        $currentDir.copyhere($_.Path)
    }
    sleep(2)
	
	Rename-Item -Path ".\$driverNameInZip" -NewName ".\$driverName"
}
