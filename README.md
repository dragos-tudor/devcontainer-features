
## Devcontainer features

### Debian features
- [debian-packages](debian-packages): install choosen/default apt packages.
- [debian-user-group](debian-user-group): add user and group based on `_REMOTE_USER` devcontainer env var ["remoteUser" devcontainer.json option]. User `root` not supported.
- [debian-dotnet-sdk](debian-dotnet-sdk): install bare-metal dotnet sdk and prepare nuget location. This feature depends on `debian-packages` [curl, tar] and on `debian-user-group` for remote user home.
- [debian-deno](debian-deno): install bare-metal deno and set deno cache location. This feature depends on `debian-packages` [curl, unzip] and on `debian-user-group` for remote user home.

### Remarks
- usualy container workspace owners user/group ids should map with directory owners host user/group ids.
- `docker` group is used to allow container user access to host `docker.sock` for `docker-outside-of-docker` scenarios like integration testing.
- `$PATH` env is unresolved on `~/.bashrc` file to allow multipe export PATH declarations [`debian-dotnet-sdk`, `debian-deno`].
- tested using Linux hosts only.
