FROM microsoft/dotnet-framework:4.7.2-runtime-windowsservercore-1803

ADD ./setup c:/Jenkins

RUN Powershell.exe -Command Install-WindowsFeature Web-Server
RUN ["msiexec.exe","/i","c:\\Jenkins\\jenkins.msi","/qn"]
RUN Powershell.exe -Command remove-item c:/Jenkins -Recurse
