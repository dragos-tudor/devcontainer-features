#!/usr/bin/env bash
set -eo pipefail

USER=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER
DOTNET_PATH=$USER_HOME/.dotnet
DOTNET_ROOT=$DOTNET_PATH

if [ "$PRODUCT" == "sdk" ]; then DOTNET_PRODUCT_URL="https://dotnetcli.azureedge.net/dotnet/Sdk/$VERSION/dotnet-sdk-$VERSION-${OS}-${ARCH}.${EXT}"; fi
if [ "$PRODUCT" == "aspnetcore" ]; then DOTNET_PRODUCT_URL="https://dotnetcli.azureedge.net/dotnet/aspnetcore/Runtime/$VERSION/aspnetcore-runtime-$VERSION-${OS}-${ARCH}.${EXT}"; fi
if [ "$PRODUCT" == "runtime" ]; then DOTNET_PRODUCT_URL="https://dotnetcli.azureedge.net/dotnet/Runtime/$VERSION/dotnet-runtime-$VERSION-${OS}-${ARCH}.${EXT}"; fi

cat << EOF >> /.devcontainer_features.log
Devcontainer feature [debian-dotnet-product]: install dotnet product from: $DOTNET_PRODUCT_URL.
EOF

curl -fsSL $DOTNET_PRODUCT_URL -o $USER_HOME/dotnet.tar.gz &&
	mkdir -p $DOTNET_PATH &&
	tar -xzf $USER_HOME/dotnet.tar.gz -C $DOTNET_PATH &&
  chmod +x $DOTNET_PATH/dotnet &&
  chown -R $USER:$USER $DOTNET_PATH &&
  rm $USER_HOME/dotnet.tar.gz || exit

NUGET_PATH=$USER_HOME/.nuget &&
  mkdir $NUGET_PATH &&
  chown -R $USER:$USER $NUGET_PATH || exit

cat << EOF >> $USER_HOME/.bashrc
export DOTNET_ROOT=$DOTNET_ROOT
export DOTNET_GENERATE_ASPNET_CERTIFICATE=false
export DOTNET_USE_POLLING_FILE_WATCHER=true
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=true
export NUGET_XMLDOC_MODE=skip
export PATH="\$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"
EOF

cat << EOF >> /.devcontainer_features.log
Devcontainer feature [debian-dotnet-product]: dotnet installed. dotnet path: $DOTNET_PATH. dotnet product url: $DOTNET_PRODUCT_URL.
Devcontainer feature [debian-dotnet-product]: nuget path: $NUGET_PATH.
EOF