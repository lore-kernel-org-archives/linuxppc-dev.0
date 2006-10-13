Return-Path: <anton@ozlabs.org>
Date: Fri, 13 Oct 2006 12:13:12 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] POWER6 has 6 PMCs
Message-ID: <20061013021312.GB16029@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Change ->num_pmcs to match the number of PMCs in POWER6. 

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/cputable.c
===================================================================
--- build.orig/arch/powerpc/kernel/cputable.c	2006-09-22 19:04:56.000000000 +1000
+++ build/arch/powerpc/kernel/cputable.c	2006-09-22 19:24:11.000000000 +1000
@@ -268,7 +268,7 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_POWER6,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.num_pmcs		= 8,
+		.num_pmcs		= 6,
 		.oprofile_cpu_type	= "ppc64/power6",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
  		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
