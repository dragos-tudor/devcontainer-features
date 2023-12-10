set -e

[ $_REMOTE_USER = root ] && echo "Devcontainer feature [debian-user-group]: Root user not supported" && exit 1;

USER=${_REMOTE_USER:-vscode}
GROUP=${_REMOTE_USER:-vscode}
USER_HOME=/home/$USER

groupadd -g 1000 $GROUP &&
	groupadd -g 999 docker &&
  useradd -m -d $USER_HOME -s /bin/bash -g 1000 -G 999 -u 1000 $USER

echo "Devcontainer feature [debian-user-group]: User $USER created."
echo "Devcontainer feature [debian-user-group]: Group $GROUP created."  
