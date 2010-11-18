Return-Path: <mikey@neuling.org>
Message-Id: <20101118045247.854059569@neuling.org>
Date: Thu, 18 Nov 2010 15:52:44 +1100
From: mikey@neuling.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc: add POWER7+ cputable entry
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

This adds the POWER7+ cputable entry for the PVR 0x004a0000.  Rest is
the same as vanilla POWER7.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cputable.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
@@ -461,6 +461,22 @@
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power7",
 	},
+	{	/* Power7+ */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x004A0000,
+		.cpu_name		= "POWER7+ (raw)",
+		.cpu_features		= CPU_FTRS_POWER7,
+		.cpu_user_features	= COMMON_USER_POWER7,
+		.mmu_features		= MMU_FTR_HPTE_TABLE |
+			MMU_FTR_TLBIE_206,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power7",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.platform		= "power7+",
+	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
