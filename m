Return-Path: <michael@ozlabs.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-Id: <fe6d8d0ac33f450da7db317eb7f785bed788fc21.1239148958.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/oprofile: Remove unused dump_pmcs() in FSL oprofile
Date: Wed,  8 Apr 2009 10:02:50 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's still in the git history if anyone wants it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/oprofile/op_model_fsl_emb.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/oprofile/op_model_fsl_emb.c b/arch/powerpc/oprofile/op_model_fsl_emb.c
index 91596f6..62312ab 100644
--- a/arch/powerpc/oprofile/op_model_fsl_emb.c
+++ b/arch/powerpc/oprofile/op_model_fsl_emb.c
@@ -228,20 +228,6 @@ static void pmc_stop_ctrs(void)
 	mtpmr(PMRN_PMGC0, pmgc0);
 }
 
-static void dump_pmcs(void)
-{
-	printk("pmgc0: %x\n", mfpmr(PMRN_PMGC0));
-	printk("pmc\t\tpmlca\t\tpmlcb\n");
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC0),
-			mfpmr(PMRN_PMLCA0), mfpmr(PMRN_PMLCB0));
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC1),
-			mfpmr(PMRN_PMLCA1), mfpmr(PMRN_PMLCB1));
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC2),
-			mfpmr(PMRN_PMLCA2), mfpmr(PMRN_PMLCB2));
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC3),
-			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
-}
-
 static int fsl_emb_cpu_setup(struct op_counter_config *ctr)
 {
 	int i;
-- 
1.6.2.1
