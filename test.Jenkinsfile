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
                    echo "Running another pipeline from test"
                    echo "Nuget package installer started"
                    //echo env.BUILD_NUMBER
                    bat "test.bat"
                    //bat "C:\\Tools\\nuget.exe restore  %WORKSPACE%\\Testing_App.sln -ConfigFile nuget.config"
                    //echo "Nuget package installer completed"
                    //setBuildStatus("Pending", "SUCCESS");
                }
            }
            stage('Build') {
                steps {

                    echo 'build step done'

                    echo 'just testing it'
                //githubNotify account: 'Sumeet001', context: 'continuous-integration/jenkins/sumeet', credentialsId: 'github', description: 'Testing build status', gitApiUrl: '', repo: 'Testing_App', sha: GIT_COMMIT, status: 'SUCCESS', targetUrl: ''
                //githubstatus('continuous-integration/jenkins/sumeet1',"Success", "SUCCESS");
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