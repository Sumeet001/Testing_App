pipeline {
    agent any
    environment {
        CI = 'true'
        BRANCH_NAME = 'master'
        PROJECT_FILE='Testing_App.sln'
		BUILD_NUMBER= '1.0'
    }
    node {
        
		 //git poll: true, url: 'https://github.com/Sumeet001/Testing_App'

        stages {

            stage ('Nuget package install') {
                steps{
                    echo "Nuget package installer started"
                    bat "C:\\Tools\\nuget.exe restore  %WORKSPACE%\\Testing_App.sln -ConfigFile nuget.config"
                    echo "Nuget package installer completed"
                }
            }
            stage('Build') {
                steps {
                        //bat 'nuget restore Testing_App.sln'
                        bat "\"${tool 'MSBuild'}\" Testing_App.sln /p:Configuration=Release /p:Platform=\"Any CPU\" /p:ProductVersion=1.0.0.${env.BUILD_NUMBER}"

                }
            }

            /*stage('Test') {
                steps {
                    sh './jenkins/scripts/test.sh'
                }
            }
            stage('Deliver for development') {
                when {
                    branch 'development' 
                }
                steps {
                    sh './jenkins/scripts/deliver-for-development.sh'
                    input message: 'Finished using the web site? (Click "Proceed" to continue)'
                    sh './jenkins/scripts/kill.sh'
                }
            }
            stage('Deploy for production') {
                when {
                    branch 'production'  
                }
                steps {
                    sh './jenkins/scripts/deploy-for-production.sh'
                    input message: 'Finished using the web site? (Click "Proceed" to continue)'
                    sh './jenkins/scripts/kill.sh'
                }
            }*/
        }
    }
}