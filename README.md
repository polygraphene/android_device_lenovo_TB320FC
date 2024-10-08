# TWRP device tree for Lenovo Legion Y700 (2023) (TB320FC)

## Supported features

- [x] /data FBE Decryption
- [x] adb on primary USB port (long edge)

## WIP features

- [ ] MTP
- [ ] Secondary USB port (short edge)

## Partition layout

- A/B
- Has super partition
- dedicated recovery partition (with A/B)
- recovery doesn't include kernel (Use kernel from boot.img)
- no init\_boot partition

## Device specifications

Component              | Model
----------------------:|:-------------------------
SoC                    | Qualcomm SM8475P Snapdragon 8+ Gen 1 (4 nm)
CPU                    | Octa-core (1x3.19 GHz Cortex-X2 & 3x2.75 GHz Cortex-A710 & 4x1.80 GHz Cortex-A510)
GPU                    | Adreno 730
Memory                 | 12GB / 16GB
Storage                | 256GB / 512GB
Battery                | Li-Po 6550 mAh, non-removable
Display                | 1600 x 2560 pixels (144Hz 8.8" IPS LCD)
Latest Android Version | ZUI 16 (Android 14)

## Build instructions

1. Initialize TWRP source
```
mkdir twrp-12.1
cd twrp-12.1
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
mkdir -p .repo/local_manifests
```

2. Add this to `.repo/local_manifests/TB320FC.xml`
```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
	<project name="polygraphene/android_device_lenovo_TB320FC" path="device/lenovo/TB320FC" remote="github" revision="android-12.1"/>
</manifest>
```

3. Start downloading TWRP source
```
repo sync -j$(nproc)
```

4. Apply patches
This step is required as of October 2024. If [https://gerrit.twrp.me/q/topic:%22drm-fix-new-topology%22](those patches) are already merged in official repository, skip it.
Those patches solve a display issue that the bottom of display are grayed out.
```
cd bootable/recovery
git fetch https://gerrit.twrp.me/android_bootable_recovery refs/changes/83/7683/1 && git checkout FETCH_HEAD
```

5. Build TWRP
```
source build/envsetup.sh
lunch twrp_TB320FC-eng
mka -j$(nproc) recoveryimage
```

After the build has finished, you can find the recovery image at $OUT/recovery.img and flash it with `fastboot flash recovery` while the tablet is in bootloader mode.
