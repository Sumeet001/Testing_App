pipeline {
    agent any
    environment {
        CI = 'true'
        BRANCH_NAME = 'master'
        PROJECT_FILE='Testing_App.sln'
		BUILD_NUMBER= '1.0'
        AN_ACCESS_KEY = credentials('jenkinspassword') 

    }
    //node {
        
		// git poll: true, url: 'https://github.com/Sumeet001/Testing_App'
        
        
        stages {
           
            stage ('Nuget package install') {
                
            
                steps{
                 script{
                    load ".\\env\\base.txt"
                     }
                    bat '''
                        echo %bundle.file%
                        echo %build.config%
                    '''
                    echo "Nuget package installer started from main pipeline"
                    


                    //echo "password for jenkins is : ${env.AN_ACCESS_KEY}"   
                     withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'jenkinspassword',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                      //  bat '''
                      //      type %USERNAME%
                      //      type %PASSWORD%
                      //      '''
                            echo "password for jenkins is : ${PASSWORD}"  
                        }
                



                    //echo env.BUILD_NUMBER
                    bat "test.bat"
                    //bat "C:\\Tools\\nuget.exe restore  %WORKSPACE%\\Testing_App.sln -ConfigFile nuget.config"
                    //echo "Nuget package installer completed"
                    //setBuildStatus("Pending", "SUCCESS");
                }
            }
            stage('Build') {
                steps {

                      bat '''
                        echo %bundle.file%
                        echo %build.config%
                    '''
                //githubNotify account: 'Sumeet001', context: 'continuous-integration/jenkins/sumeet', credentialsId: 'github', description: 'Testing build status', gitApiUrl: '', repo: 'Testing_App', sha: GIT_COMMIT, status: 'SUCCESS', targetUrl: ''
                githubstatus('continuous-integration/jenkins/sumeet1',"Success", "SUCCESS");
                //setBuildStatus("Success", "SUCCESS");

    //                 githubNotify account: 'raul-arabaolaza', context: 'Final Test', credentialsId: 'raul-github',
    // description: 'This is an example', repo: 'acceptance-test-harness', sha: '0b5936eb903d439ac0c0bf84940d73128d5e9487'
    // , status: 'SUCCESS', targetUrl: 'https://my-jenkins-instance.com'

                    // script{
                    //    currentBuild.description="Test Description"
                    //    currentBuild.currentResult="FAILURE"
                    //    updateGithubCommitStatus(currentBuild)
                    //    setBuildStatus("Build is in progress","PENDING")
                    // }
                        //bat 'nuget restore Testing_App.sln'
                        //bat "\"${tool 'MSBuild'}\" Testing_App.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"
                        //setBuildStatus("Build Sucess + sumeet","SUCCESS")
                        //changes done
                       //pullRequest.comment('This PR is highly illogical..')

                        //chnaged the value
                }
            }
    
          
        }
    post { 
        always { 
            echo 'setting at post'
           setBuildStatus("Build is in progress","PENDING")
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
def githubstatus(String context, String status, String message){
  step([$class: 'GitHubCommitStatusSetter',
      contextSource: [$class: 'ManuallyEnteredCommitContextSource', context: context],
      statusResultSource: [$class: 'ConditionalStatusResultSource',
          results: [[$class: 'AnyBuildResult', state: status, message: message]]]])
}