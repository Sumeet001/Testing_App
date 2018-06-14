$sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
$targetNugetExe = "$env($env:nuget_path)"
If (Test-Path $targetNugetExe) {
  Write-Host "NuGet found at $targetNugetExe"
  iex "$targetNugetExe update -self"
} Else {
  Write-Host "NuGet not found at $targetNugetExe"
  $nugetFolder = Split-Path "$env($env:nuget_path)" -Parent
  New-Item -ErrorAction Ignore -ItemType directory -Path $nugetFolder
  Write-Host "Downloading " + $sourceNugetExe
  Invoke-WebRequest $sourceNugetExe -OutFile $targetNugetExe
  Get-Item $targetNugetExe | Unblock-File
}

iex "$targetNugetExe locals all -clear"

for( $i = 1; $i -le 10; $i++) {
    Write-Host "##teamcity[blockOpened name='NugetRestoreAttempt$i' description='Restore packages from $env($env:nuget_feed) (Attempt #$($i))']"
    $exitCode = 0
    if(Test-Path "nuget-out.txt") {
        Remove-Item -Path "nuget-out.txt" -Force -ErrorAction Continue
    }
    if(Test-Path "nuget-error.txt") {
        Remove-Item -Path "nuget-error.txt" -Force -ErrorAction Continue
    }
    Write-Host "Starting $env($env:nuget_path) install Attempt #$i"
    $nugetProcess = Start-Process -FilePath "$env($env:nuget_path)" -PassThru -ArgumentList "restore `"$env($env:nuget_restore_target)`" -Source $env($env:nuget_feed) -Source https://api.nuget.org/v3/index.json" -RedirectStandardError "nuget-error.txt" -RedirectStandardOutput "nuget-out.txt"
    if ( -not $nugetProcess.WaitForExit(600000) ) {
        Write-Host "nuget did not finish after 10 minutes, killing the process"
        $nugetProcess.Kill()
        Start-Sleep -Seconds 5
        if(Test-Path "nuget-out.txt") {
            Get-Content -Path "nuget-out.txt"
        }
        if(Test-Path "nuget-error.txt") {
            Get-Content -Path "nuget-error.txt"
        }
        $exitCode = -1
        Write-Host "##teamcity[blockClosed name='NugetRestoreAttempt$i']"
        continue
    }
    $exitCode = $nugetProcess.GetType().GetField("exitCode", "NonPublic,Instance").GetValue($nugetProcess)

    if(Test-Path "nuget-out.txt") {
        Get-Content -Path "nuget-out.txt"
    }
	Write-Host "Dumping nuget errors..."
    if(Test-Path "nuget-error.txt") {
        Get-Content -Path "nuget-error.txt"
    }

    if (Test-Path "nuget-error.txt") {
      if ((Get-Item "nuget-error.txt").length -gt 0kb) {
          Write-Host "nuget-error.txt is not empty. ExitCode = $exitCode"
		  continue
      }
	}

    Write-Host "$env($env:nuget_path): ExitCode = $exitCode"

    Write-Host "##teamcity[blockClosed name='NugetRestoreAttempt$i']"
    break
}

if ($exitCode -ne 0 -and $exitCode -lt 200) {
    Write-Host "##teamcity[buildProblem description=''nuget restore' failed after $i attempts']"
    exit 1
}