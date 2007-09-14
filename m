Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 03/25] spufs: remove spu_harvest
Message-Id: <1189751574.99844.732539932561.3.gpush@pokey>
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 16:32:54 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on an initial patch from Sebastian Siewior
<sebastian@breakpoint.cc>

spu_harvest isn't used, remove it.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/switch.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/switch.c b/arch/powerpc/platforms/cell/spufs/switch.c
index 27ffdae..2506619 100644
--- a/arch/powerpc/platforms/cell/spufs/switch.c
+++ b/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2146,19 +2146,6 @@ int spu_restore(struct spu_state *new, struct spu *spu)
 }
 EXPORT_SYMBOL_GPL(spu_restore);
 
-/**
- * spu_harvest - SPU harvest (reset) operation
- * @spu: pointer to SPU iomem structure.
- *
- * Perform SPU harvest (reset) operation.
- */
-void spu_harvest(struct spu *spu)
-{
-	acquire_spu_lock(spu);
-	harvest(NULL, spu);
-	release_spu_lock(spu);
-}
-
 static void init_prob(struct spu_state *csa)
 {
 	csa->spu_chnlcnt_RW[9] = 1;
