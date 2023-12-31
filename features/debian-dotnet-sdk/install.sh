set -e

USER=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER
DOTNET_PATH=$USER_HOME/.dotnet
DOTNET_ROOT=$DOTNET_PATH

curl -fsSL $DOTNET_SDK_URL -o $USER_HOME/dotnet.tar.gz &&
	mkdir -p $DOTNET_PATH &&
	tar -xzf $USER_HOME/dotnet.tar.gz -C $DOTNET_PATH &&
  chmod +x $DOTNET_PATH/dotnet &&
  chown -R $USER:$USER $DOTNET_PATH &&
  rm $USER_HOME/dotnet.tar.gz

NUGET_PATH=$USER_HOME/.nuget
mkdir $NUGET_PATH

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

echo "Devcontainer feature [debian-dotnet-sdk]: dotnet installed. dotnet path: $DOTNET_PATH. dotnet sdk url: $DOTNET_SDK_URL"
echo "Devcontainer feature [debian-dotnet-sdk]: nuget path: $NUGET_PATH"