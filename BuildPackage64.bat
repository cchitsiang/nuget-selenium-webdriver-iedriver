@echo off
pushd %~dp0

echo Downloading %fname%...
powershell -noprof -exec unrestricted -c ".\buildTools\download-driver64.ps1"
echo.
:SKIP_DOWNLOAD

echo Packaging...
.\buildTools\NuGet.exe pack .\src\Selenium.WebDriver.IEDriver64.nuspec -Out .\dist
