# Bring in Qualcomm helper macros
include vendor/wave/build/core/qcom_utils.mk

# Populate the qcom hardware variants in the project pathmap.
define ril-set-path-variant
$(call project-set-path-variant,ril,TARGET_RIL_VARIANT,hardware/$(1))
endef
define wlan-set-path-variant
$(call project-set-path-variant,wlan,TARGET_WLAN_VARIANT,hardware/qcom/$(1))
endef
define bt-vendor-set-path-variant
$(call project-set-path-variant,bt-vendor,TARGET_BT_VENDOR_VARIANT,hardware/qcom/$(1))
endef

# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    BOARD_USES_QTI_HARDWARE := true
endif

# Set HAL paths
$(call set-device-specific-path,AUDIO,audio,hardware/qcom/audio/$(QCOM_HARDWARE_VARIANT))
$(call set-device-specific-path,DISPLAY,display,hardware/qcom/display/$(QCOM_HARDWARE_VARIANT))
$(call set-device-specific-path,MEDIA,media,hardware/qcom/media/$(QCOM_HARDWARE_VARIANT))

$(call set-device-specific-path,DATA_IPA_CFG_MGR,data-ipa-cfg-mgr,vendor/qcom/opensource/data-ipa-cfg-mgr)
$(call set-device-specific-path,GPS,gps,hardware/qcom/gps)
$(call set-device-specific-path,LOC_API,loc-api,vendor/qcom/opensource/location)
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/dataservices)
$(call set-device-specific-path,POWER,power,vendor/qcom/opensource/power)
$(call set-device-specific-path,THERMAL,thermal,vendor/qcom/opensource/thermal-hal)
$(call set-device-specific-path,VR,vr,hardware/qcom/vr)
