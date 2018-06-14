rem del "%teamcity.build.checkoutDir%\%bundle.path%\AppCertReport.xml"
rem "C:\Program Files (x86)\Windows Kits\10\App Certification Kit\appcert.exe" reset
"C:\Program Files (x86)\Windows Kits\10\App Certification Kit\appcert.exe" test -appxpackagepath "%teamcity.build.checkoutDir%\%bundle.path%\%bundle.file%" -reportoutputpath "%teamcity.build.checkoutDir%\%bundle.path%\AppCertReport.xml"