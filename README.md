# cloudinv-agent

Ex. docker build usage, where Dockerfile is at C:\build\Dockerfile

`docker build -t cloudinv-agent C:\build --build-arg AGENT_VERSION=<current Agent version ex. 0.3.16> --build-arg SITE_KEY="<actualSiteKey>"`

After a successful build:

## View images 
`docker images`

## Run the new image in a container
`docker run -dit cloudinv-agent`
 
The container is launched in the background with interactive mode enabled, which means we can "attach" to the container's console.

## Lookup the name of the container (its dynamic)
`docker ps -a`
 
## Then attach to the console using
`docker attach <dynamic name>`
 
After running docker attach you'll have a cmd console. You can call powershell to get a PS console.
You can detach and leave the container running using Ctrl+P , Ctrl+Q.
