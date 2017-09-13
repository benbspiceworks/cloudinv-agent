# escape=`
FROM microsoft/windowsservercore
ARG AGENT_VERSION
ARG SITE_KEY

#download/import installer
ADD https://download.spiceworks.com/SpiceworksAgent/$AGENT_VERSION/SpiceworksAgentShell_cloud-inventory.msi C:\

SHELL ["powershell", "-Command"]

#install agent shell msi
RUN $args = \"/i C:\SpiceworksAgentShell_cloud-inventory.msi /qn SITE_KEY=\" + $Env:SITE_KEY + \" /lv install.log\"; `
Start-Process msiexec.exe -Wait -ArgumentList $args;

#cleanup; remove installer
RUN Remove-Item C:\SpiceworksAgentShell_cloud-inventory.msi -Force;

#startup and monitor agent service, ref. https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/master/windows-server-container-tools/Wait-Service
ADD https://raw.githubusercontent.com/MicrosoftDocs/Virtualization-Documentation/master/windows-server-container-tools/Wait-Service/Wait-Service.ps1 C:\Wait-Service.ps1
ENTRYPOINT powershell.exe -file c:\Wait-Service.ps1 -ServiceName agentshellservice

#agent shell windows service status = container health
HEALTHCHECK CMD powershell -command `  
    try { `
	$serviceInfo = service -name agentshellservice; `
	$response = $serviceInfo.status -eq "Running"; `
     if ($response) { return 0} `
     else {return 1}; `
    } catch { return 1 }
