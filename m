Return-Path: <prabhakar@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A2822C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jan 2014 23:23:47 +1100 (EST)
Received: from mail72-am1 (localhost [127.0.0.1])	by mail72-am1-R.bigfish.com
 (Postfix) with ESMTP id D1B49400537	for
 <linuxppc-dev@lists.ozlabs.org>; Sat,
 25 Jan 2014 12:23:41 +0000 (UTC)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/config: Remove unnecssary CONFIG_FSL_IFC
Date: Sat, 25 Jan 2014 17:53:32 +0530
Message-ID: <1390652612-3553-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_FSL_IFC gets enabled by Kconfig dependancies.
So remove unnecssary define from the defconfigs

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 arch/powerpc/configs/corenet64_smp_defconfig |    1 -
 arch/powerpc/configs/mpc85xx_defconfig       |    1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 25b03f8..188e117 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -26,7 +26,6 @@ CONFIG_CORENET_GENERIC=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
-CONFIG_FSL_IFC=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index cba638c..3c44a53 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -49,7 +49,6 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
-CONFIG_FSL_IFC=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index e315b8a..dd55ed6 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -52,7 +52,6 @@ CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
 CONFIG_FORCE_MAX_ZONEORDER=12
-CONFIG_FSL_IFC=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
-- 
1.7.9.5
