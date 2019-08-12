# Copyright (C) 2019 Wave-OS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include device/qcom/common/common.mk

# Enable SIP+VoIP
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Include support for GApps backup
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/wave/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/wave/prebuilt/bin/50-backuptool.sh:system/addon.d/50-backuptool.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/wave/prebuilt/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/wave/prebuilt/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Copy wave specific init file
PRODUCT_COPY_FILES += vendor/wave/prebuilt/root/init.wave.rc:root/init.wave.rc

# Include vendor overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/wave/overlay/common

# Include hostapd configuration
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    vendor/wave/prebuilt/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny \
    vendor/wave/prebuilt/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept

# World APN list
PRODUCT_COPY_FILES += \
    vendor/wave/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Build some apps
PRODUCT_PACKAGES += \
    SnapdragonGallery \
    Phonograph \
    ViaBrowser \
    MiXplorer \
    MusicFX

# Include support for additional filesystems
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Bluetooth Audio (A2DP)
PRODUCT_PACKAGES += libbthost_if

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += libprotobuf-cpp-full

# RCS Service
PRODUCT_PACKAGES += \
    rcscommon \
    rcscommon.xml \
    rcsservice \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# MSIM manual provisioning
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# TCP Connection Management
PRODUCT_PACKAGES += tcmiface
PRODUCT_BOOT_JARS += tcmiface

#SeLinux
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=1
else
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
endif

# Sounds
include vendor/wave/configs/pixel2-audio_prebuilt.mk

# Branding stuffs
include vendor/wave/configs/branding.mk

# Bootanimation
include vendor/wave/configs/bootanimation.mk

# Themes
include vendor/wave/configs/themes.mk

# Disable qmi EAP-SIM security
DISABLE_EAP_PROXY := true

# Add perf blobs if the device needs it
ifeq ($(TARGET_NEEDS_PERF_BLOBS), true)
PRODUCT_PACKAGES += \
    QPerformance \
    UxPerformance

PRODUCT_BOOT_JARS += \
    QPerformance \
    UxPerformance

PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,vendor/wave/performance/proprietary/lib,system/lib)
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,vendor/wave/performance/proprietary/lib64,system/lib64)
endif
