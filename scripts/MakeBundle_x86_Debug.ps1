param (
    [string]$Solution = "..\Aurea.CRM.Client.Build.sln"
 )

$msbuild = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe"
set-alias msbuild $msbuild
 
$sln_name = $Solution
$vs_config = "Debug"
$vs_config | % { msbuild $sln_name /m /nr:false /p:Configuration=$_ `
	/p:OutDir=../Debug `
	/p:Platform=x86 `
	/p:AppxPackageAllowDebugFrameworkReferencesInManifest=True `
	/p:AppxPackageIsForStore=true `
	/p:AppxBundlePlatforms="x86" `
	/p:AppxPackageDir="AppxPackages" `
	/fileLoggerParameters:LogFile="..\MSBuildFull.log;" }