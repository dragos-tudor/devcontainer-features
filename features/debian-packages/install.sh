#!/usr/bin/env bash
set -eo pipefail

cat << EOF >> /.devcontainer_features.log
Devcontainer feature [debian-packages]: installing ${PACKAGES} packages.
EOF

apt update &&
  apt -y install --no-install-recommends --no-install-suggests ${PACKAGES} &&
  apt -y autoremove &&
  apt -y clean &&
  rm -rf /var/lib/apt/lists/* || exit

cat << EOF >> /.devcontainer_features.log
Devcontainer feature [debian-packages]: installed ${PACKAGES} packages.
EOF