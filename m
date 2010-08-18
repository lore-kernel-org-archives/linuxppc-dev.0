Return-Path: <shaggy@linux.vnet.ibm.com>
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/47x: Remove redundant line from cputable.c
Date: Wed, 18 Aug 2010 11:44:24 -0500
Message-Id: <1282149866-4710-3-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1282149866-4710-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two entries for .cpu_user_features in
arch/powerpc/kernel/cputable.c.  Remove the one that doesn't belong

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cputable.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 65e2b4e..1f9123f 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1826,7 +1826,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_47X,
 		.cpu_user_features	= COMMON_USER_BOOKE |
 			PPC_FEATURE_HAS_FPU,
-		.cpu_user_features	= COMMON_USER_BOOKE,
 		.mmu_features		= MMU_FTR_TYPE_47x |
 			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
 		.icache_bsize		= 32,
-- 
1.7.1
