Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F9142C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 12:57:00 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/fsl: remove CONFIG_IRQ_ALL_CPUS from
 mpc85xx/mpc86xx defconfig
Date: Mon, 21 Jan 2013 19:56:44 -0600
Message-ID: <1358819804-28665-4-git-send-email-scottwood@freescale.com>
In-Reply-To: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
References: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While this should be harmless now that distribute_irqs
obeys MPIC_SINGLE_DEST_CPU, there's no reason to enable this
on mpc85xx/mpc86xx since MPIC_SINGLE_DEST_CPU will always be set.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/85xx/ge_imp3a_defconfig   |    1 -
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig  |    1 -
 arch/powerpc/configs/86xx/gef_sbc310_defconfig |    1 -
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    1 -
 arch/powerpc/configs/86xx/sbc8641d_defconfig   |    1 -
 arch/powerpc/configs/corenet32_smp_defconfig   |    1 -
 arch/powerpc/configs/corenet64_smp_defconfig   |    1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig     |    1 -
 8 files changed, 8 deletions(-)

diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index f8c51a4..c9765b5 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -34,7 +34,6 @@ CONFIG_PREEMPT=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_FORCE_MAX_ZONEORDER=17
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
index da731c2..f2f6734 100644
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
@@ -25,7 +25,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT=y
 CONFIG_BINFMT_MISC=m
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_SPARSE_IRQ=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/86xx/gef_sbc310_defconfig b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
index 2149360..be73219 100644
--- a/arch/powerpc/configs/86xx/gef_sbc310_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc310_defconfig
@@ -25,7 +25,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT=y
 CONFIG_BINFMT_MISC=y
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_SPARSE_IRQ=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/86xx/gef_sbc610_defconfig b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
index af2e8e1..b3e2b10 100644
--- a/arch/powerpc/configs/86xx/gef_sbc610_defconfig
+++ b/arch/powerpc/configs/86xx/gef_sbc610_defconfig
@@ -25,7 +25,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_1000=y
 CONFIG_PREEMPT=y
 CONFIG_BINFMT_MISC=m
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_SPARSE_IRQ=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/86xx/sbc8641d_defconfig b/arch/powerpc/configs/86xx/sbc8641d_defconfig
index 0a92ca0..1a62baf 100644
--- a/arch/powerpc/configs/86xx/sbc8641d_defconfig
+++ b/arch/powerpc/configs/86xx/sbc8641d_defconfig
@@ -23,7 +23,6 @@ CONFIG_SBC8641D=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_BINFMT_MISC=m
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_SPARSE_IRQ=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 1c0f243..60027c2 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -32,7 +32,6 @@ CONFIG_HIGHMEM=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_KEXEC=y
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 88fa5c4..7375961 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -26,7 +26,6 @@ CONFIG_P5020_DS=y
 CONFIG_P5040_DS=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 502cd9e..8d00ea5b 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -49,7 +49,6 @@ CONFIG_QE_GPIO=y
 CONFIG_HIGHMEM=y
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_FORCE_MAX_ZONEORDER=12
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
-- 
1.7.9.5
