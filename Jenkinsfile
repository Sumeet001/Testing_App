pipeline {
    //agent any
    agent { label 'windows' }

        environment {
            CI_BUILD = "true"
            BUILD_TYPE= "CI"
            PROJECT_FILE='Aurea.CRM.Client.sln'
            nuget_restore_target="Aurea.CRM.Client.sln"
            path_to_solution_ft="Aurea.CRM.UWPClient/Aurea.CRM.WinClient.Functional.Tests/Aurea.CRM.WinClient.Functional.Tests.sln"
            TOOL_FOLDER='C:\\Tools'
            path_to_solution_shared="Aurea.CRM.Client.Shared.sln"
        }
        stages {
            stage('Git source fetch')
            {
                steps{
                    echo env.BRANCH_NAME
                    echo 'Intializing the build'
                    
                }
            }
            stage("Nuget Restore With Retry")
            {
                steps{
                    powershell returnStdout: true, script: '''
                            .\\scripts\\jenkins\\MakeBundle_x86_Debug.ps1
                            '''
                }
            }
            stage("Restore NuGetPackages FTs")
            {
                when {
                     environment name: 'CI_BUILD', value: 'false'
                }
                steps{
                    //TODO: ask for command
                     powershell returnStdout: true, script: '''
                            .\\scripts\\jenkins\\RestoreNuGetPackagesFTs.ps1
                            '''
                }

            }
            stage("Reset VS Tools Environment")
            {
                steps{
                    //TODO ask for justification
                    bat "c:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\Tools\\vcvarsqueryregistry.bat"
                }
            }
            stage("Building Shared")
            {
                when {
                     environment name: 'CI_BUILD', value: 'false'
                }
                steps{
                    //TODO: ask for command
                     powershell returnStdout: true, script: '''
                            .\\scripts\\jenkins\\BuildShared.ps1
                            '''
                }

            }
            stage('Building CI') {
                  when {
                     environment name: 'CI_BUILD', value: 'true'
                }
                steps {
                        //TODO: ask for command
                        echo "Build Started...."
                       powershell returnStdout: true, script: '''cd scripts
                            .\\MakeBundle_x86_Debug.ps1
                            cd ..'''
                        echo "Build Completed successfully"
                }
            }
             stage('Building FT') {
                  when {
                     environment name: 'CI_BUILD', value: 'false'
                }
                steps {
                        //TODO: ask for command
                        echo "Build Started...."
                       powershell returnStdout: true, script: '''cd scripts
                            .\\MakeBundle_FT_x86_Debug.ps1
                            cd ..'''
                        echo "Build Completed successfully"
                }
            }

            stage('Process Build warning report') {
                //   when {
                //      environment name: 'CI_BUILD', value: 'true'
                // }
                steps {
                        //TODO: ask for command
                        echo "Build Started...."
                       powershell returnStdout: true, script: '''cd scripts
                            .\\ProcessBuildWarningReport.ps1
                            cd ..'''
                        echo "Build Completed successfully"
                }
            }    

            stage('Register Certificates') {
                //   when {
                //      environment name: 'CI_BUILD', value: 'true'
                // }
                steps {
                        //TODO: ask for command
                        echo "Build Started...."
                       powershell returnStdout: true, script: '''cd scripts
                            .\\RegisterCertificates.ps1
                            cd ..'''
                        echo "Build Completed successfully"
                }
            }

             stage('Run UTs with coverage') {
                   when {
                      environment name: 'CI_BUILD', value: 'true'
                 }
                steps {
                        //TODO: ask for command
                        // env.UT_CoverageFiles="\\Shared\\%build.config%\\Aurea.CRM.UIModel.Tests.dll \\Shared\\%build.config%\\Aurea.CRM.Core.Tests.dll \\Shared\\%build.config%\\Aurea.CRM.Client.UI.Tests.dll \\Shared\\%build.config%\\Aurea.CRM.Services.Tests.dll"

                        // env.TestCategory="TestCategory!=Intgration.Tests"
                        // env.UTFilter="+:Aurea.CRM.Client +:Aurea.CRM.Core +:Aurea.CRM.UIModel +:Aurea.CRM.Client.UI +:Aurea.CRM.Services"
                        // env.DotCoverArgument="/Filters=+:module=Aurea.CRM.Core;+:module=Aurea.CRM.UIModel;+:module=Aurea.CRM.Client.UI;+:module=Aurea.CRM.Services;-:type=Aurea.CRM.Client.UI.Views.Search.FilterView*;-:type=Aurea.CRM.Client.UI.UIControls.SearchBarView*;-:type=Aurea.CRM.Client.UI.Resources*;-:type=Aurea.CRM.Client.UI.Views.ActionsView*;-:type=Aurea.CRM.Client.UI.Views.Search.GlobalSearchPopup*;-:module=*.Tests;"
                        // env.VSTest="VSTest 2017"

                       
                       powershell returnStdout: true, script: '''cd scripts
                            .\\TestsWithUTCoverage.ps1
                            cd ..'''
                       
                }
            }
            

             stage('Run ITs with coverage (by category)') {
                   when {
                      environment name: 'CI_BUILD', value: 'false'
                 }
                steps {
                        //TODO: ask for command
                        // env.IT_CoverageFiles="\\Shared\\%build.config%\\Aurea.CRM.UIModel.Tests.dll \\Shared\\%build.config%\\Aurea.CRM.Core.Tests.dll \\Shared\\%build.config%\\Aurea.CRM.Client.UI.Tests.dll \\Shared\\%build.config%\\Aurea.CRM.Services.Tests.dll"

                        // env.TestCategory="TestCategory=Intgration.Tests"
                        // env.UTFilter="+:Aurea.CRM.Client +:Aurea.CRM.Core +:Aurea.CRM.UIModel +:Aurea.CRM.Services +:Aurea.CRM.Client.UI"
                        // env.DotCoverArgument="/Filters=+:module=Aurea.CRM.Core;+:module=Aurea.CRM.UIModel;+:module=Aurea.CRM.Client.UI;+:module=Aurea.CRM.Services;-:type=Aurea.CRM.Client.UI.Views.Search.FilterView*;-:type=Aurea.CRM.Client.UI.UIControls.SearchBarView*;-:type=Aurea.CRM.Client.UI.Resources*;-:type=Aurea.CRM.Client.UI.Views.ActionsView*;-:type=Aurea.CRM.Client.UI.Views.Search.GlobalSearchPopup*;-:module=*.Tests;"
                        // env.VSTest="VSTest 2017"

                       
                       powershell returnStdout: true, script: '''cd scripts
                            .\\TestsWithUTCoverage.ps1
                            cd ..'''
                       
                }
            }
             stage('Run FTs (no coverage)') {
                   when {
                      environment name: 'CI_BUILD', value: 'false'
                 }
                steps {
                        //TODO: ask for command
                        // env.FT_CoverageFiles="Aurea.CRM.UWPClient\\Aurea.CRM.WinClient.Functional.Tests\\bin\\%build.config%\\Aurea.CRM.WinClient.Functional.*.dll"
                      
                        // env.VSTest="VSTest 2017"
                        // env.FT_TestName="OpenCrmWinClientFromWebUrlTest.OpenCrmClientFromWebUrl"
                       
                       powershell returnStdout: true, script: '''cd scripts
                            .\\TestsWithFTNoCoverage.ps1
                            cd ..'''
                       
                }
            }
            stage('Verify Bundle') {
                   when {
                      environment name: 'CI_BUILD', value: 'false'
                 }
                steps {
                        //TODO: ask for command
                       
                      bat ".//scripts/verifybundle.bat"
                       
                }
            }

             stage('Uninstall natively') {
                   when {
                      environment name: 'CI_BUILD', value: 'false'
                 }
                steps {
                        //TODO: ask for command
                       
                    powershell returnStdout: true, script: '''cd scripts
                            .\\UninstallNatively.ps1
                            cd ..'''
                       
                }
            }

             stage('Install natively') {
                   when {
                      environment name: 'CI_BUILD', value: 'false'
                 }
                steps {
                        //TODO: ask for command and to be passed
                       
                    powershell returnStdout: true, script: '''cd scripts
                            .\\InstallNatively.ps1
                            cd ..'''
                       
                }
            }
            stage('Repack Bundle') {
                   when {
                      environment name: 'CI_BUILD', value: 'false'
                 }
                steps {
                        //TODO: ask for command and to be passed
                       
                    powershell returnStdout: true, script: '''
                            .\\scripts\\RepackBundle.ps1.ps1 -buildNumber %build.number% -buildConfig %build.config%
                            '''
                       
                }
            }
            stage('Upload Bundle') {
                  when {
                      environment name: 'CI_BUILD', value: 'false'
                 } 
                steps {
                        //TODO: ask for command and to be passed
                     bat ".\\scripts\\UploadBundle.bat"
                       
                }
            
            }
            stage('OSS Report') {
                  when {
                      environment name: 'CI_BUILD', value: 'false'
                 } 
                steps {
                        //TODO: ask for command and to be passed
                     bat ".//scripts//OSSReport.bat"
                       
                }
            
            }
            stage ('Nuget package install') {
                steps{
                    echo "Nuget package installer started"
                     bat ".\\scripts\\jenkins\\nuget-restore.bat"
                     echo "Nuget package installer completed"
                    
                }
            }
            
            stage ('Warnings')
            {
                steps{
                    step([$class: 'WarningsPublisher', canComputeNew: "NO", canResolveRelativePaths: "NO", defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', messagesPattern: '', parserConfigurations: [[parserName: 'MSBuild', pattern: 'MSBuildFull.log']], unHealthy: ''])
                }
            
            }
            stage('Runing Tests'){

                steps{
                        //testing this phase
                        echo 'Running Tests'
                        bat ".\\scripts\\jenkins\\opencover.bat"
                        echo 'Test executed successfully'

                }
            }
            stage('Publishing Test Results'){
                steps{
                    step([$class: 'MSTestPublisher', testResultsFile:"**/*.trx", failOnError: "NO", keepLongStdio: true])
                }
            }
            stage('Publishing Coverage Report'){
                steps{
                            echo 'generating test coverage report'    
                            bat ".\\scripts\\jenkins\\reportgenerator.bat"
                            echo 'report generation completed'
                       
                            echo 'converting test coverage report...'
                            bat ".\\scripts\\jenkins\\convertreport.bat"
                            echo 'test coverage report convertion completed'
                            cobertura autoUpdateHealth: "NO", autoUpdateStability: "NO", coberturaReportFile: 'Cobertura.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: "NO", failUnstable: "NO", lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: "NO", sourceEncoding: 'ASCII', zoomCoverageChart: "NO"
                  }
            }   
        }
   }
      




