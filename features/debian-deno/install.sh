set -e

USER=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER
DENO_DIR=$USER_HOME/.deno
curl -fsSL https://github.com/denoland/deno/releases/download/$DENO_VERSION/deno-x86_64-unknown-linux-gnu.zip -o $USER_HOME/deno.zip &&
    unzip -d $DENO_DIR -o $USER_HOME/deno.zip &&
    chmod +x $DENO_DIR/deno &&
    chown -R $USER:$USER $DENO_DIR &&
    rm $USER_HOME/deno.zip

cat << EOF >> $USER_HOME/.bashrc
export DENO_DIR=$DENO_DIR
export PATH=$PATH:$DENO_DIR
EOF
