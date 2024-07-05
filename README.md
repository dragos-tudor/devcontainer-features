
## Devcontainer features

### Debian features
- [debian-packages](features/debian-packages): install choosen/default apt packages.
- [debian-user-group](features/debian-user-group): add user and group based on **_REMOTE_USER** devcontainer env var ["remoteUser" devcontainer.json option]. User **root** not supported.
- [debian-dotnet-product](features/debian-dotnet-product): install bare-metal **dotnet product** and prepare nuget location. This feature depends on **debian-packages** [curl, tar] and on **debian-user-group** for remote user home.
- [debian-deno](features/debian-deno): install bare-metal **deno** and set deno cache location. This feature depends on **debian-packages** [curl, unzip] and on **debian-user-group** for remote user home.

### Remarks
- usually container workspace owner user/group ids should map with directory owner host user/group ids.
- *$PATH* env is unresolved on `~/.bashrc` file to allow multipe export PATH declarations [**debian-dotnet-product**, **debian-deno**].
- best practices: 
    - mount docker *nuget* volume on `~/.nuget` folder to reuse dotnet packages between containers.
    - mount docker *deno-cache* volume on `~/.deno-cache` folder to reuse deno modules and npm packages between containers. 
- tested using Ubuntu host.
- *debian-dotnet-product* should be used only with *dotnet-runtime-deps* base images and these images in-sync with *dotnet version* because starting with version 1.3.0 *debian-packages* feature will not longer install packages needed by dotnet. This change allow to use different debian based distros as base images without to manually install on each container neccessary packages to run dotnet.
