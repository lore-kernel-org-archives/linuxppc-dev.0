Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 03 Oct 2006 14:48:43 +1000
Subject: [PATCH] Fix a printk in pseries_mpic_init_IRQ
Message-Id: <20061003044846.5187D67C49@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This should probably say "mpic" to save confusion.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: to-merge/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
+++ to-merge/arch/powerpc/platforms/pseries/setup.c
@@ -180,7 +180,7 @@ static void __init pseries_mpic_init_IRQ
 
 	cascade_irq = irq_of_parse_and_map(cascade, 0);
 	if (cascade == NO_IRQ) {
-		printk(KERN_ERR "xics: failed to map cascade interrupt");
+		printk(KERN_ERR "mpic: failed to map cascade interrupt");
 		return;
 	}
 
