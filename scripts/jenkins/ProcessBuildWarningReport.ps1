if(test-path u8.tool\TeamCity\BuildWarningReportGenerator.ps1){
    & u8.tool\TeamCity\BuildWarningReportGenerator.ps1 -BuildLogPath "%BuildLogFile%" -BuildCheckoutDirectoryPath ".\" -BuildArtifactRepositoryUrl "%teamcity.serverUrl%/httpAuth/repository/download/%system.teamcity.buildType.id%/" -user "%system.teamcity.auth.userId%" -password "%system.teamcity.auth.password%"
 }
  
 # EOF