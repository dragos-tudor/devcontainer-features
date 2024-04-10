set -e

USER=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER
DOTNET_PATH=$USER_HOME/.dotnet
DOTNET_ROOT=$DOTNET_PATH

if [[ -n $BUILD ]]; then DOTNET_BUILD=/$BUILD; fi
DOTNET_PRODUCT_URL="https://aka.ms/dotnet/${VERSION}${DOTNET_BUILD}/${PRODUCT}-${OS}-${ARCH}.${EXT}"

echo "Devcontainer feature [debian-dotnet-product]: install dotnet product from: $DOTNET_PRODUCT_URL"

curl -fsSL $DOTNET_PRODUCT_URL -o $USER_HOME/dotnet.tar.gz &&
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

echo "Devcontainer feature [debian-dotnet-product]: dotnet installed. dotnet path: $DOTNET_PATH. dotnet product url: $DOTNET_PRODUCT_URL"
echo "Devcontainer feature [debian-dotnet-product]: nuget path: $NUGET_PATH"