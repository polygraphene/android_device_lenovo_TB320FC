# TWRP device tree for Lenovo Legion Y700 (2023) (TB320FC)

8.8 inch a high-end tablet released on 2023.

## Flash instruction
  Make sure your device is a CN/Global/JP version of Y700 (2023) before proceeding.

1. Unlock bootloader
   - For detailed instructions, please see the following article.  
   [https://xdaforums.com/t/y700-2023-regional-rom-flashing-guide.4685115/](https://xdaforums.com/t/y700-2023-regional-rom-flashing-guide.4685115/)
3. Obtain stock vbmeta.img
   - Any version of vbmeta.img can be used.
4. Disable AVB.
   - Prepare fastboot drivers and platform-tools then, run the following command.
   ```sh
   fastboot --disable-verity --disable-verification flash vbmeta vbmeta.img
   ```
5. Download recovery image from the [release](https://github.com/polygraphene/android_device_lenovo_TB320FC/releases)
6. Flash recovery
   - Run the following command.
   ```sh
   fastboot flash recovery twrp-downloaded-file-name.img
   ```
8. Reboot into recovery
   - Run the following command.
   ```sh
   fastboot reboot recovery
   ```

## When not boot
  - Make sure disabled AVB by running step 4.
  - Try to flash boot or verndor_boot partition from stock ROM.

## Supported features

Blocking checks
- [x] Correct screen/recovery size
- [x] Working Touch, screen
- [x] Backup to internal/microSD
- [x] Restore from internal/microSD
- [x] reboot to system
- [x] ADB

Medium checks
- [ ] update.zip sideload  
  Not tested
- [x] UI colors (red/blue inversions)
- [x] Screen goes off and on
- [ ] F2FS/EXT4 Support, exFAT/NTFS where supported  
  Not tested
- [x] all important partitions listed in mount/backup lists
- [x] backup/restore to/from external (USB-OTG) storage (not supported by the device)
- [ ] backup/restore to/from adb (https://gerrit.omnirom.org/#/c/15943/)  
  Not tested
- [x] decrypt /data
- [x] Correct date

Minor checks
- [x] MTP export  
- [x] reboot to bootloader
- [x] reboot to recovery
- [x] poweroff
- [x] battery level
- [x] temperature
- [ ] encrypted backups  
  Not tested
- [x] input devices via USB (USB-OTG) - keyboard, mouse and disks (not supported by the device)
- [ ] USB mass storage export
- [x] set brightness
- [ ] vibrate
- [x] screenshot
- [ ] partition SD card  
  Not tested

Unchecked items are not working now.

## Partition layout

- A/B
- Has super partition
- Has dedicated recovery partition (with A/B)
- Recovery doesn't include kernel (Use kernel from boot.img)
- No init\_boot partition
- See the seciton `Launch or upgrade to Android 12, dedicated and A/B recovery (dedicated ramdisk)` from  
  [https://source.android.com/docs/core/architecture/partitions/generic-boot](https://source.android.com/docs/core/architecture/partitions/generic-boot)

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
```sh
mkdir twrp-12.1
cd twrp-12.1
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
mkdir -p .repo/local_manifests
```

2. Add this to `.repo/local_manifests/TB320FC.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
	<project name="polygraphene/android_device_lenovo_TB320FC" path="device/lenovo/TB320FC" remote="github" revision="android-12.1"/>
</manifest>
```

3. Start downloading TWRP source
```sh
repo sync -j$(nproc)
```

4. Apply patches  
This step is required as of October 2024. Skip it if [those patches](https://gerrit.twrp.me/q/topic:%22drm-fix-new-topology%22) are merged in the official repository.
Those patches solve a problem with the bottom of the screen not showing properly.
```sh
cd bootable/recovery
git fetch https://gerrit.twrp.me/android_bootable_recovery refs/changes/83/7683/1 && git checkout FETCH_HEAD
```

5. Build TWRP
```sh
source build/envsetup.sh
lunch twrp_TB320FC-eng
mka -j$(nproc) recoveryimage
```

After the build has finished, you can find the recovery image at out/target/product/TB320FC/recovery.img.
