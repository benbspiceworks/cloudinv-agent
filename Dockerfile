# escape=`
FROM microsoft/windowsservercore
ARG AGENT_VERSION
ARG SITE_KEY

ADD https://download.spiceworks.com/SpiceworksAgent/$AGENT_VERSION/SpiceworksAgentShell_cloud-inventory.msi C:\

SHELL ["powershell", "-Command"]

RUN $args = \"/i C:\SpiceworksAgentShell_cloud-inventory.msi /qn SITE_KEY=\" + $Env:SITE_KEY + \" /lv install.log\"; `
Start-Process msiexec.exe -Wait -ArgumentList $args;

RUN Remove-Item C:\SpiceworksAgentShell_cloud-inventory.msi -Force;
