Return-Path: <yao.yuan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5B021A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 13:39:05 +1000 (AEST)
From: Yuan Yao <yao.yuan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/corenet32: enable DMA in defconfig
Date: Thu, 23 Jul 2015 11:00:46 +0800
Message-ID: <1437620446-47626-1-git-send-email-yao.yuan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default we enable DMA(CONFIG_FSL_DMA) support
which are needed on P2041RDB, P3041DS, P4080DS,
B4860QDS, etc.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 3765993..0c175cc 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -143,6 +143,8 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_DS3232=y
 CONFIG_UIO=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_DMA=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
 CONFIG_STAGING=y
-- 
2.1.0.27.g96db324
