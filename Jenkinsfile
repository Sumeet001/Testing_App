pipeline {
    agent any
    environment {
        CI = 'true'
        BRANCH_NAME = 'master'
        PROJECT_FILE='Testing_App.sln'
		BUILD_NUMBER= '1.0'
    }
    //node {
        
		// git poll: true, url: 'https://github.com/Sumeet001/Testing_App'

        stages {

            stage ('Nuget package install') {
                steps{
                    echo "Nuget package installer started"
                    //bat "C:\\Tools\\nuget.exe restore  %WORKSPACE%\\Testing_App.sln -ConfigFile nuget.config"
                    //echo "Nuget package installer completed"
                }
            }
            stage('Build') {
                steps {
                       
                       setBuildStatus("Build is in progress","PENDING")
                        //bat 'nuget restore Testing_App.sln'
                        //bat "\"${tool 'MSBuild'}\" Testing_App.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
                        //setBuildStatus("Build Sucess + sumeet","SUCCESS")
                        //changes done
                       def comment = pullRequest.comment('This PR is highly illogical..')

                        //cahned
                }
            }
    
          
        }
        
   // }
}
 void setBuildStatus(String message, String state) {
  step([
      $class: "GitHubCommitStatusSetter",
      reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/Sumeet001/Testing_App"],
      contextSource: [$class: "ManuallyEnteredCommitContextSource", context: "ci/jenkins/build-status/sumeet"],
      errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
      statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
  ]);
}