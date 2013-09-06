Return-Path: <B21989@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B256F2C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 18:56:54 +1000 (EST)
Received: from mail102-db9 (localhost [127.0.0.1])	by
 mail102-db9-R.bigfish.com (Postfix) with ESMTP id B391520214	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 08:56:48 +0000 (UTC)
Received: from DB9EHSMHS003.bigfish.com (unknown [10.174.16.227])	by
 mail102-db9.bigfish.com (Postfix) with ESMTP id 9B27D3401E4	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 08:56:22 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/corenet/config: add missing SCSI configs for
 corenet64_smp_defconfig
Date: Fri, 6 Sep 2013 16:52:34 +0800
Message-ID: <1378457554-22595-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Shaohui Xie <Shaohui.Xie@freescale.com>
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
 arch/powerpc/configs/corenet64_smp_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 6c8b020..53058cb 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -92,6 +92,13 @@ CONFIG_BLK_DEV_LOOP=y
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
1.8.0
