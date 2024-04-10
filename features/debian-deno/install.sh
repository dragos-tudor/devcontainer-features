set -e

USER=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER
DENO_ROOT=$USER_HOME/.deno
DENO_RELEASE_URL="https://github.com/denoland/deno/releases/download/$VERSION/deno-$ARCH-$OS.zip"

echo "Devcontainer feature [debian-deno]: install deno from: $DENO_RELEASE_URL"

curl -fsSL $DENO_RELEASE_URL -o $USER_HOME/deno.zip &&
    unzip -d $DENO_ROOT -o $USER_HOME/deno.zip &&
    chmod +x $DENO_ROOT/deno &&
    chown -R $USER:$USER $DENO_ROOT &&
    rm $USER_HOME/deno.zip

DENO_CACHE=$USER_HOME/.deno-cache
mkdir -p $DENO_CACHE
    chown -R $USER:$USER $DENO_CACHE

cat << EOF >> $USER_HOME/.bashrc
export DENO_DIR=$DENO_CACHE
export PATH="\$PATH:$DENO_ROOT"
EOF

echo "Devcontainer feature [debian-deno]: deno installed, deno root: $DENO_ROOT, deno cache: $DENO_CACHE, deno version: $VERSION"
