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
                       currentBuild.description="Test Description"
                       currentBuild.currentResult="FAILURE"
                       updateGithubCommitStatus(currentBuild)
                       setBuildStatus("Build is in progress","PENDING")
                        //bat 'nuget restore Testing_App.sln'
                        //bat "\"${tool 'MSBuild'}\" Testing_App.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
                        //setBuildStatus("Build Sucess + sumeet","SUCCESS")
                        //changes done
                       //pullRequest.comment('This PR is highly illogical..')

                        //chnaged the value
                }
            }
    
          
        }
        
   // }
}

def getRepoURL() {
  sh "git config --get remote.origin.url > .git/remote-url"
  return readFile(".git/remote-url").trim()
}
 
def getCommitSha() {
  sh "git rev-parse HEAD > .git/current-commit"
  return readFile(".git/current-commit").trim()
}
 
def updateGithubCommitStatus(build) {
  // workaround https://issues.jenkins-ci.org/browse/JENKINS-38674
  repoUrl = getRepoURL()
  commitSha = getCommitSha()
 
  step([
    $class: 'GitHubCommitStatusSetter',
    reposSource: [$class: "ManuallyEnteredRepositorySource", url: repoUrl],
    commitShaSource: [$class: "ManuallyEnteredShaSource", sha: commitSha],
    errorHandlers: [[$class: 'ShallowAnyErrorHandler']],
    statusResultSource: [
      $class: 'ConditionalStatusResultSource',
      results: [
        [$class: 'BetterThanOrEqualBuildResult', result: 'SUCCESS', state: 'SUCCESS', message: build.description],
        [$class: 'BetterThanOrEqualBuildResult', result: 'FAILURE', state: 'FAILURE', message: build.description],
        [$class: 'AnyBuildResult', state: 'FAILURE', message: 'Loophole']
      ]
    ]
  ])
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