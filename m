Return-Path: <R1AAHA@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2131FB7015
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2012 08:28:05 +1000 (EST)
Date: Fri, 13 Apr 2012 17:26:15 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/fsl: Distribute interrupts on all CPUs by default
Message-ID: <20120413172615.136b60077051430253bb5d0a@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At least for crypto/IPSec, doing so provides users with a better
performance experience out of the box.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index f8aef20..13e7f3c 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -32,6 +32,7 @@ CONFIG_HIGH_RES_TIMERS=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_KEXEC=y
+CONFIG_IRQ_ALL_CPUS=y
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_FSL_LBC=y
 CONFIG_PCI=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 7ed8d4c..00c49b9 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -23,6 +23,7 @@ CONFIG_P5020_DS=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=m
+CONFIG_IRQ_ALL_CPUS=y
 CONFIG_RAPIDIO=y
 CONFIG_FSL_RIO=y
 CONFIG_NET=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index abdcd31..608ccc6 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -45,6 +45,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
+CONFIG_IRQ_ALL_CPUS=y
 CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-- 
1.7.10
