# constants
$version = "3.11"
$build = "0"
$driverNameInZip = "IEDriverServer.exe"
$driverName = "IEDriverServer64.exe"
$zipName = "IEDriverServer_x64_$version.$build.zip"
$downloadurl = "https://selenium-release.storage.googleapis.com/$version/$zipName"

# move current folder to where contains this .ps1 script file.
$scriptDir = Split-Path $MyInvocation.MyCommand.Path
pushd $scriptDir

$currentPath = Convert-Path "..\"
$downloadDir = Join-Path $currentPath "downloads"
$zipPath = Join-Path $downloadDir $zipName
$driverPath = Join-Path $downloadDir $driverName
$driverInZipPath = Join-Path $downloadDir $driverNameInZip

# download driver .zip file if not exists.
if (-not (Test-Path $zipPath)){
    (New-Object Net.WebClient).Downloadfile($downloadurl, $zipPath)
    if (Test-Path $driverPath) {
        del $driverPath 
    }
}

# Decompress .zip file to extract driver .exe file.
if (-not (Test-Path $driverPath)) {
    $shell = New-Object -com Shell.Application
    $zipFile = $shell.NameSpace($zipPath)

    $zipFile.Items() | `
    where {(Split-Path $_.Path -Leaf) -eq $driverNameInZip} | `
    foreach {
        $extractTo = $shell.NameSpace($downloadDir)
        $extractTo.copyhere($_.Path)
    }
    sleep(2)
	
	Rename-Item -Path $driverInZipPath -NewName $driverPath
    sleep(2)
}
