
## Devcontainer features

### Debian features
- [debian-packages](features/debian-packages): install choosen/default apt packages.
- [debian-user-group](features/debian-user-group): add user and group based on **_REMOTE_USER** devcontainer env var ["remoteUser" devcontainer.json option]. User **root** not supported.
- [debian-dotnet-product](features/debian-dotnet-product): install bare-metal **dotnet product** and prepare nuget location. This feature depends on **debian-packages** [curl, tar] and on **debian-user-group** for remote user home.
- [debian-deno](features/debian-deno): install bare-metal **deno** and set deno cache location. This feature depends on **debian-packages** [curl, unzip] and on **debian-user-group** for remote user home.

### Remarks
- usually container workspace owner user/group ids should map with directory owner host user/group ids.
- **docker** group is used to allow container user access to host `docker.sock` for **docker-outside-of-docker** scenarios like integration testing.
- **$PATH** env is unresolved on `~/.bashrc` file to allow multipe export PATH declarations [**debian-dotnet-product**, **debian-deno**].
- best practices: 
    - mount docker **nuget** volume on `~/.nuget` folder to reuse dotnet packages between containers.
    - mount docker **deno-cache** volume on `~/.deno-cache` folder to reuse deno modules and npm packages between containers. 
- tested using Ubuntu host.
