Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <95c5ebd63992c64ad0b644f1204362aaf5e35eeb.1239025478.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/oprofile: dump_pmcs() is not used
Date: Mon,  6 Apr 2009 23:45:08 +1000 (EST)
Cc: Kumar Gala <kumar.gala@freescale.com>, afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/oprofile/op_model_fsl_emb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

Or should we just remove it?

diff --git a/arch/powerpc/oprofile/op_model_fsl_emb.c b/arch/powerpc/oprofile/op_model_fsl_emb.c
index 91596f6..4abd466 100644
--- a/arch/powerpc/oprofile/op_model_fsl_emb.c
+++ b/arch/powerpc/oprofile/op_model_fsl_emb.c
@@ -228,6 +228,7 @@ static void pmc_stop_ctrs(void)
 	mtpmr(PMRN_PMGC0, pmgc0);
 }
 
+#if 0
 static void dump_pmcs(void)
 {
 	printk("pmgc0: %x\n", mfpmr(PMRN_PMGC0));
@@ -241,6 +242,7 @@ static void dump_pmcs(void)
 	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC3),
 			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
 }
+#endif
 
 static int fsl_emb_cpu_setup(struct op_counter_config *ctr)
 {
-- 
1.6.2.1
