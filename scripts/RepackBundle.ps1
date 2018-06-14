param (
    [string]$bundleName = "AppxPackages",
	[string]$extension = ".zip",
    [Parameter(Mandatory=$true)][string]$buildNumber,
	[Parameter(Mandatory=$true)][string]$buildConfig
 )

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Write-host "My directory is $dir"

Push-Location $dir
[Environment]::CurrentDirectory = $PWD
 
 # zip folder
$source = "../" + $bundleName;
$destination = "../" + $bundleName + $extension;
If(Test-path $destination) {Remove-item $destination};
Add-Type -assembly "system.io.compression.filesystem";
[io.compression.zipfile]::CreateFromDirectory($Source, $destination);

Pop-Location
[Environment]::CurrentDirectory = $PWD
