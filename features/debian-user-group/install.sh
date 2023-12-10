set -e

[ $_REMOTE_USER = root ] && echo "Root user not supported" && exit 1;

USER=${_REMOTE_USER:-vscode}
GROUP=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER

groupadd -g 1000 $GROUP &&
	groupadd -g 999 docker &&
  useradd -m -d $USER_HOME -s /bin/bash -g 1000 -G 999 -u 1000 $USER
