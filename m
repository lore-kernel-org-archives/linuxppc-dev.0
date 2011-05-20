Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC4ADB71BF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:35 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69VKm001031
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:31 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/14] powerpc: Rename e55xx_smp_defconfig to
	corenet64_smp_defconfig
Date: Fri, 20 May 2011 01:09:18 -0500
Message-Id: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than trying to use the core name we use corenet to distinquish
the platform/core combo.  corenet64 will be a 64-bit kernel build and
we'll add a new defconfig for corenet32 for a 32-bit platforms.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/corenet64_smp_defconfig |  104 ++++++++++++++++++++++++++
 arch/powerpc/configs/e55xx_smp_defconfig     |  104 --------------------------
 2 files changed, 104 insertions(+), 104 deletions(-)
 create mode 100644 arch/powerpc/configs/corenet64_smp_defconfig
 delete mode 100644 arch/powerpc/configs/e55xx_smp_defconfig

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
new file mode 100644
index 0000000..d322835
--- /dev/null
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -0,0 +1,104 @@
+CONFIG_PPC64=y
+CONFIG_PPC_BOOK3E_64=y
+# CONFIG_VIRT_CPU_ACCOUNTING is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_P5020_DS=y
+# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BINFMT_MISC=m
+# CONFIG_PCI is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_ARPD=y
+CONFIG_INET_ESP=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_IPV6=y
+CONFIG_IP_SCTP=m
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_MISC_DEVICES=y
+CONFIG_EEPROM_LEGACY=y
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+CONFIG_NET_ETHERNET=y
+CONFIG_INPUT_FF_MEMLESS=m
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_I2C=y
+# CONFIG_HWMON is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_DMADEVICES=y
+CONFIG_FSL_DMA=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_MAC_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_UTF8=m
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=m
+CONFIG_FRAME_WARN=1024
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_VIRQ_DEBUG=y
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/e55xx_smp_defconfig b/arch/powerpc/configs/e55xx_smp_defconfig
deleted file mode 100644
index d322835..0000000
--- a/arch/powerpc/configs/e55xx_smp_defconfig
+++ /dev/null
@@ -1,104 +0,0 @@
-CONFIG_PPC64=y
-CONFIG_PPC_BOOK3E_64=y
-# CONFIG_VIRT_CPU_ACCOUNTING is not set
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_SPARSE_IRQ=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_EXPERT=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_P5020_DS=y
-# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BINFMT_MISC=m
-# CONFIG_PCI is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_NET_IPIP=y
-CONFIG_IP_MROUTE=y
-CONFIG_IP_PIMSM_V1=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_ARPD=y
-CONFIG_INET_ESP=y
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-CONFIG_IPV6=y
-CONFIG_IP_SCTP=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_PROC_DEVICETREE=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_MISC_DEVICES=y
-CONFIG_EEPROM_LEGACY=y
-CONFIG_NETDEVICES=y
-CONFIG_DUMMY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIO_LIBPS2=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
-CONFIG_I2C=y
-# CONFIG_HWMON is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_DMADEVICES=y
-CONFIG_FSL_DMA=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAC_PARTITION=y
-CONFIG_NLS=y
-CONFIG_NLS_UTF8=m
-CONFIG_CRC_T10DIF=y
-CONFIG_CRC_ITU_T=m
-CONFIG_FRAME_WARN=1024
-CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_VIRQ_DEBUG=y
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_TALITOS=y
-- 
1.7.3.4
