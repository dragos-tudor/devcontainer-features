set -e

[ -f "devcontainer-feature-debian-deno.tgz" ] && rm devcontainer-feature-debian-deno.tgz 
[ -f "devcontainer-feature-debian-dotnet-sdk.tgz" ] && rm devcontainer-feature-debian-dotnet-sdk.tgz
[ -f "devcontainer-feature-debian-packages.tgz" ] && rm devcontainer-feature-debian-packages.tgz
[ -f "devcontainer-feature-debian-user-group.tgz" ] && rm devcontainer-feature-debian-user-group.tgz

tar -czvf devcontainer-feature-debian-deno.tgz ./.devcontainer/debian-deno
tar -czvf devcontainer-feature-debian-dotnet-sdk.tgz ./.devcontainer/debian-dotnet-sdk
tar -czvf devcontainer-feature-debian-packages.tgz ./.devcontainer/debian-packages
tar -czvf devcontainer-feature-debian-user-group.tgz ./.devcontainer/debian-user-group