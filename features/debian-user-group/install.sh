#!/usr/bin/env bash
set -eo pipefail

[ $_REMOTE_USER = root ] && echo "Devcontainer feature [debian-user-group]: root user not supported" && exit 1;

USER=${_REMOTE_USER:-vscode}
GROUP=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER
UID=${UID:-1000}
GID=${GID:-1000}

groupadd -g $GID $GROUP &&
  useradd -m -d $USER_HOME -s /bin/bash -g $GID -u $UID $USER || exit

cat << EOF >> /.devcontainer_features.log
Devcontainer feature [debian-user-group]: user $USER:$UID created.
Devcontainer feature [debian-user-group]: group $GROUP:$GID created.
EOF
