Return-Path: <B21989@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 051492C00FD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 23:27:45 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/corenet/config: add missing SCSI configs for
 corenet64_smp_defconfig
Date: Tue, 16 Apr 2013 20:47:19 +0800
Message-ID: <1366116439-19569-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Otherwise there will be no SCSI device nodes.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
resend due to patch work did not capture this patch.

 arch/powerpc/configs/corenet64_smp_defconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 83dcc6a..2333e9b 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -77,6 +77,13 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_EEPROM_LEGACY=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_ATA=y
 CONFIG_SATA_FSL=y
 CONFIG_SATA_SIL24=y
-- 
1.7.0.4
