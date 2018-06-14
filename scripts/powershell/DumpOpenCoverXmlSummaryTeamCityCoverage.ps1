#requires -version 4
param (
    [Parameter(Mandatory=$true)]
    [string] $summaryReport,
    
    [string] $coverageReport = $null,
    [long] $visitedMethods = 0,
    [long] $numMethods = 0,
    [long] $visitedClasses = 0,
    [long] $numClasses = 0
)

function Extract-OpenCoverSummaryValue
{
    param(
        [Parameter(Mandatory=$true)]
        $openCoverReport,

        [Parameter(Mandatory=$true)]
        $summaryValueName
    )

    $regex = "<Summary.*$summaryValueName=`"(\d+)`""

    return Select-String -Path $openCoverReport -Pattern $regex -AllMatches | Select-Object -First 1 | % { $_.Matches.Groups[1].Value }
}

function Extract-CoverageReportSummaryValue
{
    param(
        [Parameter(Mandatory=$true)]
        $summaryReport,

        [Parameter(Mandatory=$true)]
        $summaryValueName
    )

    $regex = "<$summaryValueName>(.*)</$summaryValueName>"

    return Select-String -Path $summaryReport -Pattern $regex -AllMatches | Select-Object -First 1 | % { $_.Matches.Groups[1].Value -replace "%", "" }
}

if (-not (Test-Path $summaryReport))
{
    Write-Host "$summaryReport not found"
    exit 1
}

$classCoverage = "0.00"

trap [Exception]
{
    Write-Host $_.Exception.Message
    Write-Host "$($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"
    
    continue
}

$branchCoverage = Extract-CoverageReportSummaryValue -summaryReport $summaryReport -summaryValueName "BranchCoverage"
$lineCoverage = Extract-CoverageReportSummaryValue -summaryReport $summaryReport -summaryValueName "Linecoverage"
$coveredLine = Extract-CoverageReportSummaryValue -summaryReport $summaryReport -summaryValueName "Coveredlines"
$uncoveredLines = Extract-CoverageReportSummaryValue -summaryReport $summaryReport -summaryValueName "Uncoveredlines"
$coverableLines = Extract-CoverageReportSummaryValue -summaryReport $summaryReport -summaryValueName "Coverablelines"
$totalLines = Extract-CoverageReportSummaryValue -summaryReport $summaryReport -summaryValueName "Totallines"

$haveExtendedCoverage = ($numMethods -gt 0)
if ((-not [string]::IsNullOrEmpty($coverageReport)) -and (Test-Path $coverageReport))
{
    $visitedMethods = Extract-OpenCoverSummaryValue -openCoverReport $coverageReport -summaryValueName "visitedMethods"
    $numMethods = Extract-OpenCoverSummaryValue -openCoverReport $coverageReport -summaryValueName "numMethods"
    $visitedClasses = Extract-OpenCoverSummaryValue -openCoverReport $coverageReport -summaryValueName "visitedClasses"
    $numClasses = Extract-OpenCoverSummaryValue -openCoverReport $coverageReport -summaryValueName "numClasses"
    $haveExtendedCoverage = $true
}

Write-Host "##teamcity[blockOpened name='Code Coverage Summary']"
Write-Host "##teamcity[buildStatisticValue key='CodeCoverageB' value='$branchCoverage']"
if ($haveExtendedCoverage -and ($numMethods -gt 0))
{
    $methodCoverage = (100 * ($visitedMethods / $numMethods)).ToString("#.##", [Globalization.CultureInfo]::InvariantCulture)
    if ($numClasses -gt 0)
    {
        $classCoverage = (100 * ($visitedClasses / $numClasses)).ToString("#.##", [Globalization.CultureInfo]::InvariantCulture)
    }

    Write-Host "##teamcity[buildStatisticValue key='CodeCoverageAbsMCovered' value='$visitedMethods']"
    Write-Host "##teamcity[buildStatisticValue key='CodeCoverageAbsMTotal' value='$numMethods']"
    Write-Host "##teamcity[buildStatisticValue key='CodeCoverageM' value='$methodCoverage']"
    Write-Host "##teamcity[buildStatisticValue key='CodeCoverageAbsCCovered' value='$visitedClasses']"
    Write-Host "##teamcity[buildStatisticValue key='CodeCoverageAbsCTotal' value='$numClasses']"
    Write-Host "##teamcity[buildStatisticValue key='CodeCoverageC' value='$classCoverage']"
}
Write-Host "##teamcity[buildStatisticValue key='CodeCoverageAbsLCovered' value='$coveredLine']"
Write-Host "##teamcity[buildStatisticValue key='CodeCoverageAbsLTotal' value='$coverableLines']"
Write-Host "##teamcity[buildStatisticValue key='CodeCoverageL' value='$lineCoverage']"
Write-Host "##teamcity[blockClosed name='Code Coverage Summary']"
