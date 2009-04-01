Return-Path: <anton@ozlabs.org>
Date: Wed, 1 Apr 2009 17:14:01 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: Fix ibm,client-architecture comment
Message-ID: <20090401061401.GE27084@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We specify a 64MB RMO, but the comment says 128MB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7f1b33d..ddd9561 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -614,7 +614,7 @@ static unsigned char ibm_architecture_vec[] = {
 	W(0xffffffff),			/* virt_base */
 	W(0xffffffff),			/* virt_size */
 	W(0xffffffff),			/* load_base */
-	W(64),				/* 128MB min RMA */
+	W(64),				/* 64MB min RMA */
 	W(0xffffffff),			/* full client load */
 	0,				/* min RMA percentage of total RAM */
 	48,				/* max log_2(hash table size) */
