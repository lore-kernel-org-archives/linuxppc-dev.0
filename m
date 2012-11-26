Return-Path: <olof@lixom.net>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 408A12C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 17:51:46 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id ro12so5027061pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2012 22:51:44 -0800 (PST)
From: Olof Johansson <olof@lixom.net>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/pasemi: enable PRINTK_TIME in defconfig
Date: Sun, 25 Nov 2012 22:51:28 -0800
Message-Id: <1353912688-6649-1-git-send-email-olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable PRINTK_TIME in pasemi_defconfig. Also regenerate it, it seems
that a lot of options have moved around since last time savedefconfig
was ran on it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/powerpc/configs/pasemi_defconfig | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 840a2c2..bd8a6f7 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -1,28 +1,27 @@
 CONFIG_PPC64=y
 CONFIG_ALTIVEC=y
-# CONFIG_VIRT_CPU_ACCOUNTING is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_MAC_PARTITION=y
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_PASEMI=y
 CONFIG_PPC_PASEMI_IOMMU=y
 CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_DEBUG=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
 CONFIG_PPC_64K_PAGES=y
 # CONFIG_SECCOMP is not set
@@ -47,7 +46,6 @@ CONFIG_INET_ESP=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_SLRAM=y
@@ -58,7 +56,6 @@ CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
@@ -91,21 +88,19 @@ CONFIG_BLK_DEV_DM=y
 CONFIG_DM_CRYPT=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-CONFIG_MARVELL_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-CONFIG_NET_PCI=y
-CONFIG_E1000=y
 CONFIG_TIGON3=y
+CONFIG_E1000=y
 CONFIG_PASEMI_MAC=y
+CONFIG_MARVELL_PHY=y
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=4
 CONFIG_HW_RANDOM=y
 CONFIG_RAW_DRIVER=y
 CONFIG_I2C_CHARDEV=y
@@ -146,14 +141,11 @@ CONFIG_HID_TOPSEED=y
 CONFIG_HID_THRUSTMASTER=y
 CONFIG_HID_ZEROPLUS=y
 CONFIG_USB=y
-CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_SL811_HCD=y
 CONFIG_USB_STORAGE=y
-CONFIG_USB_LIBUSUAL=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_PASEMI=y
@@ -164,8 +156,6 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_INOTIFY=y
-CONFIG_AUTOFS_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=y
@@ -177,27 +167,22 @@ CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V4=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAC_PARTITION=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRC_CCITT=y
+CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_BLOWFISH=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.10.1.488.g05fbf7a
