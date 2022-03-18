#!/bin/bash
apt-get update
apt-get install -y \
  lsb-release \
  rsync \
  software-properties-common
apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
  || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u

echo "librealsense2:
  ubuntu: [librealsense2-dkms, librealsense2-utils, librealsense2-dev]" >>/tmp/librealsense_rosdep.yaml
echo "yaml file:///tmp/librealsense_rosdep.yaml" >/etc/ros/rosdep/sources.list.d/10-custom.list

rosdep update
rosdep install --from-paths "${SOURCE_DIR}" --ignore-src -y
