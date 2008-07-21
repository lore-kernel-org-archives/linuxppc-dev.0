Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BDACCDDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 17:05:47 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [2/5] replace all occurrences of CONFIG_POWER3 by CONFIG_BATS64
Date: Mon, 21 Jul 2008 09:04:33 +0200
References: <200807201946.04299.marvin24@gmx.de>
In-Reply-To: <200807201946.04299.marvin24@gmx.de>
MIME-Version: 1.0
Message-Id: <200807210904.33862.marvin24@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch replaces all occurrences of CONFIG_POWER3 by CONFIG_BATS64. It 
should have no effect on the output kernel.

Subject: [PATCH] replace all occurrences of CONFIG_POWER3 by 
CONFIG_BATS64

---
 arch/powerpc/configs/cell_defconfig    |    2 +-
 arch/powerpc/configs/celleb_defconfig  |    2 +-
 arch/powerpc/configs/iseries_defconfig |    2 +-
 arch/powerpc/configs/ppc64_defconfig   |    2 +-
 arch/powerpc/configs/ps3_defconfig     |    2 +-
 arch/powerpc/configs/pseries_defconfig |    2 +-
 arch/powerpc/mm/pgtable_32.c           |    2 +-
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 include/asm-powerpc/cputable.h         |    3 +--
 9 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/configs/cell_defconfig 
b/arch/powerpc/configs/cell_defconfig
index c420e47..579e996 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -9,7 +9,7 @@ CONFIG_PPC64=y
 # Processor support
 #
 # CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
+CONFIG_BATS64=y
 CONFIG_POWER4=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/celleb_defconfig 
b/arch/powerpc/configs/celleb_defconfig
index 9ba3c6f..c2761a7 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -9,7 +9,7 @@ CONFIG_PPC64=y
 # Processor support
 #
 # CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
+CONFIG_BATS64=y
 CONFIG_POWER4=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/iseries_defconfig 
b/arch/powerpc/configs/iseries_defconfig
index 63f0bdb..5237a6b 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -9,7 +9,7 @@ CONFIG_PPC64=y
 # Processor support
 #
 # CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
+CONFIG_BATS64=y
 CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/ppc64_defconfig 
b/arch/powerpc/configs/ppc64_defconfig
index ce250bc..953d840 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -9,7 +9,7 @@ CONFIG_PPC64=y
 # Processor support
 #
 # CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
+CONFIG_BATS64=y
 CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/ps3_defconfig 
b/arch/powerpc/configs/ps3_defconfig
index 71d79e4..2015c69 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -9,7 +9,7 @@ CONFIG_PPC64=y
 # Processor support
 #
 # CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
+CONFIG_BATS64=y
 CONFIG_POWER4=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/configs/pseries_defconfig 
b/arch/powerpc/configs/pseries_defconfig
index fe6ffa6..e163059 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -9,7 +9,7 @@ CONFIG_PPC64=y
 # Processor support
 #
 # CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
+CONFIG_BATS64=y
 CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index c758407..c4e8d86 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -38,7 +38,7 @@ unsigned long ioremap_base;
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
-#if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
+#if defined(CONFIG_6xx) || defined(CONFIG_BATS64)
 #define HAVE_BATS	1
 #endif
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype 
b/arch/powerpc/platforms/Kconfig.cputype
index 88e6ce2..b343fdb 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -115,7 +115,7 @@ config OPT_EXCLUSIVE
 	  
 	  If you are unsure, select no.
 
-config POWER3
+config BATS64
 	depends on PPC64
 	def_bool y if !POWER4_ONLY
 
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 2a3e907..0ef9abc 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -257,8 +257,7 @@ extern void do_feature_fixups(unsigned long value, void 
*fixup_start,
 #endif
 
 #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
-		     !defined(CONFIG_POWER3) && !defined(CONFIG_POWER4) && \
-		     !defined(CONFIG_BOOKE))
+		     !defined(CONFIG_POWER4) && !defined(CONFIG_BOOKE))
 
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | CPU_FTR_HPTE_TABLE | 
\
 	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
-- 
1.5.6.2
