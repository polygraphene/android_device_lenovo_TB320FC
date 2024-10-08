#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := TB320FC
PRODUCT_NAME := twrp_TB320FC
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := Lenovo TB320FC
PRODUCT_MANUFACTURER := lenovo

PRODUCT_GMS_CLIENTID_BASE := android-lenovo

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="LenovoTB320FC_ROW-user 13 SKQ1.221119.001 16.0.324_240718 release-keys"

BUILD_FINGERPRINT := Lenovo/TB320FC/TB320FC:13/SKQ1.221119.001/ZUI_16.0.324_240718_ROW:user/release-keys
#PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Inherit from TB320FC device
$(call inherit-product, device/lenovo/TB320FC/device.mk)
