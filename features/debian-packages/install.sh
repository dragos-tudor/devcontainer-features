set -e

apt update &&
  apt -y install --no-install-recommends --no-install-suggests ${PACKAGES} &&
  apt -y autoremove &&
  apt -y clean &&
  rm -rf /var/lib/apt/lists/*

echo "Devcontainer feature [debian-packages]: Packages $PACKAGES installed."