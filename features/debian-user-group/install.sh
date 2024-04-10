#!/usr/bin/env bash
set -e

[ $_REMOTE_USER = root ] && echo "Devcontainer feature [debian-user-group]: Root user not supported" && exit 1;

USER=${_REMOTE_USER:-vscode}
GROUP=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER
UID=${UID:-1000}
GID=${GID:-1000}

groupadd -g $GID $GROUP &&
	groupadd -g 999 docker &&
  useradd -m -d $USER_HOME -s /bin/bash -g $GID -G 999 -u $UID $USER

cat << EOF >> $USER_HOME/.devcontainer_features.log
Devcontainer feature [debian-user-group]: User $USER:$UID created.
Devcontainer feature [debian-user-group]: Group $GROUP:$GID created.
EOF
