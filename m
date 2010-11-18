Return-Path: <mikey@neuling.org>
Message-Id: <20101118045247.654743185@neuling.org>
Date: Thu, 18 Nov 2010 15:52:43 +1100
From: mikey@neuling.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc: remove POWER6 oprofile workarounds for POWER7
References: <20101118045241.071482503@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are not needed on POWER7 so remove them.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cputable.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
@@ -459,10 +459,6 @@
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power7",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
-		.oprofile_mmcra_sipr	= POWER6_MMCRA_SIPR,
-		.oprofile_mmcra_clear	= POWER6_MMCRA_THRM |
-			POWER6_MMCRA_OTHER,
 		.platform		= "power7",
 	},
 	{	/* Cell Broadband Engine */
