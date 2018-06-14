param (
    [string]$rootPath = ".`\"
 )

 if (!$rootPath)
 {
      Write-Host "rootPath is not set, setting to invocation folder"
      $invocation = (Get-Variable MyInvocation).Value
      $directorypath = Split-Path $invocation.MyCommand.Path
      $rootPath = $directorypath
}

Write-Host "Going to regist3er all .cer, rootPath is: $rootPath"

$Ext = "*.cer"
Get-ChildItem -Path $rootPath -Filter $Ext -Recurse -File | ForEach-Object {
	$file = $_.FullName
    Write-Host "Register: $file"
#	Import-Certificate -FilePath $file -CertStoreLocation cert:\LocalMachine\Root -Verbose
#	$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($file)
#	$rootStore = Get-Item cert:\CurrentUser\TrustedPeople
#	$rootStore.Open("ReadWrite")
#	$rootStore.Add($cert)
#	$rootStore.Close()
    & 'C:\tools\ElevationToolkit1\elevate64.exe' -- C:\Windows\System32\certutil.exe -addstore "Root" $file
}