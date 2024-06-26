#!/bin/bash
# Script to build image for qemu.
# Author: Siddhant Jajoo.

git submodule init
git submodule sync
git submodule update

# local.conf won't exist until this step on first execution
source poky/oe-init-build-env

CONFLINE="MACHINE = \"raspberrypi4\""

#Create image of the type rpi-sdimg
IMAGE="IMAGE_FSTYPES = \"wic.bz2 tar.bz2 ext3 rpi-sdimg\""

#Set GPU memory as minimum
MEMORY="GPU_MEM = \"16\""

#Add wifi support
DISTRO_F="DISTRO_FEATURES:append = \"wifi\""

#License
LICENSE="LICENSE_FLAGS_ACCEPTED = \"synaptics-killswitch\""

#I2C
MODULE_I2C="ENABLE_I2C = \"1\""

#Autoload I2C module
AUTOLOAD_I2C="KERNEL_MODULE_AUTOLOAD:rpi += \" i2c-dev i2c-bcm2708\""

#SSH
IMAGE_F="IMAGE_FEATURES += \" ssh-server-openssh tools-debug\""

#LIBGPIOD Version
LIBGPIOD_VER="PREFERRED_VERSION_libgpiod = \"1.6.4\""


#add firmware support 
IMAGE_ADD="IMAGE_INSTALL:append = \" i2c-tools python3 ntp rpi-gpio python3-core libgpiod libgpiod-dev libgpiod-tools wpa-supplicant \
    bcm2835-tests \
    raspi-gpio \
    rpio \
    python3-adafruit-circuitpython-register \
    python3-adafruit-platformdetect \
    python3-adafruit-pureio \
    python3-rtimu \
    python3-adafruit-blinka \
    python3-adafruit-circuitpython-busdevice \
    python-adafruit-circuitpython-pm25 \""

#Add extra packages is applicable
CORE_IM_ADD="CORE_IMAGE_EXTRA_INSTALL += \" python-pm25-app\""

cat conf/local.conf | grep "${CONFLINE}" > /dev/null
local_conf_info=$?

cat conf/local.conf | grep "${IMAGE}" > /dev/null
local_image_info=$?

cat conf/local.conf | grep "${MEMORY}" > /dev/null
local_memory_info=$?

cat conf/local.conf | grep "${DISTRO_F}" > /dev/null
local_distro_info=$?

cat conf/local.conf | grep "${LICENSE}" > /dev/null
local_licn_info=$?

cat conf/local.conf | grep "${MODULE_I2C}" > /dev/null
local_i2c_info=$?

cat conf/local.conf | grep "${AUTOLOAD_I2C}" > /dev/null
local_i2c_autoload_info=$?

cat conf/local.conf | grep "${LIBGPIOD_VER}" > /dev/null
local_libgpiod_ver_info=$?

cat conf/local.conf | grep "${IMAGE_F}" > /dev/null
local_imgf_info=$?

cat conf/local.conf | grep "${IMAGE_ADD}" > /dev/null
local_imgadd_info=$?

cat conf/local.conf | grep "${CORE_IM_ADD}" > /dev/null
local_core_im_add_info=$?

if [ $local_conf_info -ne 0 ];then
	echo "Append ${CONFLINE} in the local.conf file"
	echo ${CONFLINE} >> conf/local.conf
	
else
	echo "${CONFLINE} already exists in the local.conf file"
fi

if [ $local_image_info -ne 0 ];then
    echo "Append ${IMAGE} in the local.conf file"
	echo ${IMAGE} >> conf/local.conf
else
	echo "${IMAGE} already exists in the local.conf file"
fi


if [ $local_memory_info -ne 0 ];then
    echo "Append ${MEMORY} in the local.conf file"
	echo ${MEMORY} >> conf/local.conf
else
	echo "${MEMORY} already exists in the local.conf file"
fi

if [ $local_distro_info -ne 0 ];then
    echo "Append ${DISTRO_F} in the local.conf file"
	echo ${DISTRO_F} >> conf/local.conf
else
	echo "${DISTRO_F} already exists in the local.conf file"
fi

if [ $local_licn_info -ne 0 ];then
    echo "Append ${LICENSE} in the local.conf file"
	echo ${LICENSE} >> conf/local.conf
else
	echo "${LICENSE} already exists in the local.conf file"
fi

if [ $local_i2c_info -ne 0 ];then
        echo "Append ${MODULE_I2C} in the local.conf file"
        echo ${MODULE_I2C} >> conf/local.conf
else
        echo "${MODULE_I2C} already exists in the local.conf file"
fi

if [ $local_i2c_autoload_info -ne 0 ];then
        echo "Append ${AUTOLOAD_I2C} in the local.conf file"
        echo ${AUTOLOAD_I2C} >> conf/local.conf
else
        echo "${AUTOLOAD_I2C} already exists in the local.conf file"
fi

if [ $local_libgpiod_ver_info -ne 0 ];then
        echo "Append ${LIBGPIOD_VER} in the local.conf file"
        echo ${LIBGPIOD_VER} >> conf/local.conf
else
        echo "${LIBGPIOD_VER} already exists in the local.conf file"
fi

if [ $local_imgf_info -ne 0 ];then
    echo "Append ${IMAGE_F} in the local.conf file"
	echo ${IMAGE_F} >> conf/local.conf
else
	echo "${IMAGE_F} already exists in the local.conf file"
fi

if [ $local_imgadd_info -ne 0 ];then
    echo "Append ${IMAGE_ADD} in the local.conf file"
	echo ${IMAGE_ADD} >> conf/local.conf
else
	echo "${IMAGE_ADD} already exists in the local.conf file"
fi

if [ $local_core_im_add_info -ne 0 ];then
    echo "Append ${CORE_IM_ADD} in the local.conf file"
	echo ${CORE_IM_ADD} >> conf/local.conf
else
	echo "${CORE_IM_ADD} already exists in the local.conf file"
fi

bitbake-layers show-layers | grep "meta-raspberrypi" > /dev/null
layer_info=$?

bitbake-layers show-layers | grep "meta-python" > /dev/null
layer_python_info=$?

bitbake-layers show-layers | grep "meta-oe" > /dev/null
layer_metaoe_info=$?

bitbake-layers show-layers | grep "meta-networking" > /dev/null
layer_networking_info=$?

bitbake-layers show-layers | grep "meta-adafruit-pm25" > /dev/null
layer_pm25_info=$?

#bitbake-layers show-layers | grep "meta-i2c" > /dev/null
#layer_i2c_info=$?

if [ $layer_metaoe_info -ne 0 ];then
    echo "Adding meta-oe layer"
	bitbake-layers add-layer ../meta-openembedded/meta-oe
else
	echo "layer meta-oe already exists"
fi

if [ $layer_python_info -ne 0 ];then
    echo "Adding meta-python layer"
	bitbake-layers add-layer ../meta-openembedded/meta-python
else
	echo "layer meta-python already exists"
fi

if [ $layer_networking_info -ne 0 ];then
    echo "Adding meta-networking layer"
	bitbake-layers add-layer ../meta-openembedded/meta-networking
else
	echo "layer meta-networking already exists"
fi

if [ $layer_pm25_info -ne 0 ];then
    echo "Adding meta-adafruit-pm25 layer"
	bitbake-layers add-layer ../meta-adafruit-pm25
else
	echo "layer meta-adafruit-pm25 already exists"
fi

if [ $layer_info -ne 0 ];then
	echo "Adding meta-raspberrypi layer"
	bitbake-layers add-layer ../meta-raspberrypi
else
	echo "layer meta-raspberrypi already exists"
fi

#if [ $layer_i2c_info -ne 0 ];then
#        echo "Adding meta-i2c layer"
#        bitbake-layers add-layer ../meta-i2c
#else
#        echo "meta-i2c layer already exists"
#fi

#bitbake-layers show-layers | grep "meta-gpio" > /dev/null
#layer_info=$?

#if [ $layer_info -ne 0 ];then
#	echo "Adding meta-gpio layer"
#	bitbake-layers add-layer ../meta-gpio
#else
#	echo "meta-gpio layer already exists"
#fi

set -e
bitbake core-image-base
#bitbake -C compile libgpiod
#bitbake rpi-test-image
#bitbake -s | grep ^python3
#bitbake -s | grep adafruit
#bitbake-layers create-layer ../meta-adafruit-pm25
#bitbake -fc cleanall libgpiod
