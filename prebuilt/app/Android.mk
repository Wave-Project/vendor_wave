#
# Prebuilt apps for WaveOS
#

LOCAL_PATH := $(call my-dir)

# ViaBrowser
include $(CLEAR_VARS)
LOCAL_MODULE := ViaBrowser
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_DEX_PREOPT := false
LOCAL_OVERRIDES_PACKAGES := Browser2
include $(BUILD_PREBUILT)

# MiXplorer
include $(CLEAR_VARS)
LOCAL_MODULE := MiXplorer
LOCAL_SRC_FILES := $(LOCAL_MODULE).apk
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_DEX_PREOPT := false
include $(BUILD_PREBUILT)
