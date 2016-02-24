Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B2CC1A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 12:55:52 +1100 (AEDT)
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/powernv: Add powernv firmware interface drivers
 to powernv_defconfig
Date: Wed, 24 Feb 2016 09:55:04 +0800
Message-Id: <1456278905-4824-2-git-send-email-jk@ozlabs.org>
In-Reply-To: <1456278905-4824-1-git-send-email-jk@ozlabs.org>
References: <1456278905-4824-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are a few firmware-provided interfaces for OpenPOWER platforms:
the PRD infrastructure, IPMI support, and MTD access to the PNOR flash.

This change adds these to powernv_defconfig

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 arch/powerpc/configs/powernv_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index ad0ad65..ed84b2b 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -37,6 +37,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_OPAL_PRD=y
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
@@ -78,6 +79,8 @@ CONFIG_VLAN_8021Q=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_POWERNV_FLASH=y
 CONFIG_PARPORT=m
 CONFIG_PARPORT_PC=m
 CONFIG_BLK_DEV_FD=m
@@ -178,6 +181,9 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_JSM=m
 CONFIG_VIRTIO_CONSOLE=m
+CONFIG_IPMI_HANDLER=y
+CONFIG_IPMI_DEVICE_INTERFACE=y
+CONFIG_IPMI_POWERNV=y
 CONFIG_RAW_DRIVER=y
 CONFIG_MAX_RAW_DEVS=1024
 CONFIG_FB=y
-- 
2.5.0
