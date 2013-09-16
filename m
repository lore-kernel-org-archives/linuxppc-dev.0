Return-Path: <R58495@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A32A2C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 09:36:08 +1000 (EST)
From: York Sun <yorksun@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [Patch v2] powerpc/corenet64_smp_defconfig: Enable most SPI splash
Date: Mon, 16 Sep 2013 16:35:41 -0700
Message-ID: <1379374541-13838-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable CONFIG_MTD_M25P80 for corenet64_smp_defconfig. Verified on
P5040DS.

Signed-off-by: York Sun <yorksun@freescale.com>
---
Change log:
 v2: remote reviewed-by and tested-by lines added by gerrit

 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 6c8b020..1ec6f0c 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -66,6 +66,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
 CONFIG_FTL=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_GEN_PROBE=y
-- 
1.7.9.5
