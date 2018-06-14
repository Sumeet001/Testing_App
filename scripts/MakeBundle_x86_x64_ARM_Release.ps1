param (
    [string]$Solution = "..\Aurea.CRM.Client.Build.sln"
 )


$msbuild = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe"
set-alias msbuild $msbuild
 
$sln_name = $Solution
$vs_config = "Release;UapAppxPackageBuildMode=StoreUpload"

# /p:AppxPackageAllowDebugFrameworkReferencesInManifest=True # use it if you referenced debug libs /p:AppxBundle=Always
$vs_config | % { msbuild $sln_name /m /nr:false /p:Configuration=$_ `
	/p:OutDir=../Release `
	/p:Platform=x86 `
	/p:Platform=x64 `
	/p:Platform=ARM `
	/p:AppxPackageAllowDebugFrameworkReferencesInManifest=True `
	/p:AppxPackageIsForStore=true `
	/p:AppxBundlePlatforms="x86|x64|ARM" `
	/p:AppxPackageDir="AppxPackages" `
	/fileLoggerParameters:LogFile="..\MSBuildFull.log;" }