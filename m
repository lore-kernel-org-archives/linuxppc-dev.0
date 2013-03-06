Return-Path: <B29983@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E1762C0379
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 20:46:31 +1100 (EST)
From: <Yuantian.Tang@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH][RFC, upstream] powerpc: remove the PPC_CLOCK dependency
Date: Wed, 6 Mar 2013 17:14:09 +0800
Message-ID: <1362561249-14144-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

config FSL_SOC and CPM do not really depend on PPC_CLOCK. So remove it.
PPC_CLOCK also keeps powerpc archtecture from supporting COMMON_CLK.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/Kconfig           |    1 -
 arch/powerpc/platforms/Kconfig |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 352f416..383485b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -655,7 +655,6 @@ config SBUS
 config FSL_SOC
 	bool
 	select HAVE_CAN_FLEXCAN if NET && CAN
-	select PPC_CLOCK
 
 config FSL_PCI
  	bool
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index e7a896a..aba81cd 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -343,7 +343,6 @@ config FSL_ULI1575
 
 config CPM
 	bool
-	select PPC_CLOCK
 
 config OF_RTC
 	bool
-- 
1.7.0.4
