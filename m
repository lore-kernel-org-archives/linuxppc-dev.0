Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail171-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A53F1DDF3C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:18 +1100 (EST)
Message-ID: <47910D00.5050505@am.sony.com>
Date: Fri, 18 Jan 2008 12:33:04 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 16/16] PS3: Update ps3_defconfig
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update ps3_defconfig.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/configs/ps3_defconfig |   49 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 14 deletions(-)

--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.24-rc4
-# Tue Dec  4 22:49:57 2007
+# Linux kernel version: 2.6.24-rc8
+# Wed Jan 16 14:31:21 2008
 #
 CONFIG_PPC64=y
 
@@ -103,6 +103,7 @@ CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
@@ -154,7 +155,6 @@ CONFIG_PPC_PS3=y
 # CONFIG_PS3_ADVANCED is not set
 CONFIG_PS3_HTAB_SIZE=20
 # CONFIG_PS3_DYNAMIC_DMA is not set
-CONFIG_PS3_USE_LPAR_ADDR=y
 CONFIG_PS3_VUART=y
 CONFIG_PS3_PS3AV=y
 CONFIG_PS3_SYS_MANAGER=y
@@ -162,6 +162,7 @@ CONFIG_PS3_STORAGE=y
 CONFIG_PS3_DISK=y
 CONFIG_PS3_ROM=y
 CONFIG_PS3_FLASH=y
+CONFIG_PS3_LPM=m
 CONFIG_PPC_CELL=y
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
@@ -225,7 +226,7 @@ CONFIG_HAVE_MEMORY_PRESENT=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPARSEMEM_EXTREME=y
 CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
-CONFIG_SPARSEMEM_VMEMMAP=y
+# CONFIG_SPARSEMEM_VMEMMAP is not set
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
@@ -338,7 +339,26 @@ CONFIG_IPV6_SIT=y
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
-# CONFIG_BT is not set
+CONFIG_BT=m
+CONFIG_BT_L2CAP=m
+CONFIG_BT_SCO=m
+CONFIG_BT_RFCOMM=m
+CONFIG_BT_RFCOMM_TTY=y
+CONFIG_BT_BNEP=m
+CONFIG_BT_BNEP_MC_FILTER=y
+CONFIG_BT_BNEP_PROTO_FILTER=y
+CONFIG_BT_HIDP=m
+
+#
+# Bluetooth device drivers
+#
+CONFIG_BT_HCIUSB=m
+CONFIG_BT_HCIUSB_SCO=y
+# CONFIG_BT_HCIUART is not set
+# CONFIG_BT_HCIBCM203X is not set
+# CONFIG_BT_HCIBPA10X is not set
+# CONFIG_BT_HCIBFUSB is not set
+# CONFIG_BT_HCIVHCI is not set
 # CONFIG_AF_RXRPC is not set
 
 #
@@ -666,14 +686,14 @@ CONFIG_LOGO_LINUX_CLUT224=y
 #
 # Sound
 #
-CONFIG_SOUND=y
+CONFIG_SOUND=m
 
 #
 # Advanced Linux Sound Architecture
 #
-CONFIG_SND=y
-CONFIG_SND_TIMER=y
-CONFIG_SND_PCM=y
+CONFIG_SND=m
+CONFIG_SND_TIMER=m
+CONFIG_SND_PCM=m
 # CONFIG_SND_SEQUENCER is not set
 # CONFIG_SND_MIXER_OSS is not set
 # CONFIG_SND_PCM_OSS is not set
@@ -702,7 +722,7 @@ CONFIG_SND_VERBOSE_PROCFS=y
 #
 # ALSA PowerPC devices
 #
-CONFIG_SND_PS3=y
+CONFIG_SND_PS3=m
 CONFIG_SND_PS3_DEFAULT_START_DELAY=2000
 
 #
@@ -747,7 +767,7 @@ CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
-CONFIG_USB=y
+CONFIG_USB=m
 # CONFIG_USB_DEBUG is not set
 
 #
@@ -761,13 +781,13 @@ CONFIG_USB_DEVICEFS=y
 #
 # USB Host Controller Drivers
 #
-CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD=m
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
 # CONFIG_USB_ISP116X_HCD is not set
-CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD=m
 # CONFIG_USB_OHCI_HCD_PPC_OF is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
@@ -1033,7 +1053,8 @@ CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_INSTRUMENTATION=y
-# CONFIG_PROFILING is not set
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=m
 # CONFIG_KPROBES is not set
 # CONFIG_MARKERS is not set
 

-- 
