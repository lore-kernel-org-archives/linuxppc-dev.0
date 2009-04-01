Return-Path: <anton@ozlabs.org>
Message-Id: <20090401060657.049971887@samba.org>
References: <20090401060613.377489909@samba.org>
Date: Wed, 01 Apr 2009 17:06:15 +1100
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 2/2] powerpc: Clean up some prom printouts
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make all messages consistent, some have spaces before the "...", some do not.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom_init.c	2009-04-01 16:19:01.000000000 +1100
+++ linux-2.6/arch/powerpc/kernel/prom_init.c	2009-04-01 16:19:03.000000000 +1100
@@ -1085,7 +1085,7 @@
 		return;
 	}
 
-	prom_printf("instantiating rtas at 0x%x ...", base);
+	prom_printf("instantiating rtas at 0x%x...", base);
 
 	if (call_prom_ret("call-method", 3, 2, &entry,
 			  ADDR("instantiate-rtas"),
@@ -1564,7 +1564,7 @@
 		if (call_prom("package-to-path", 3, 1, node, path,
 			      PROM_SCRATCH_SIZE-10) == PROM_ERROR)
 			continue;
-		prom_printf("found display   : %s, opening ... ", path);
+		prom_printf("found display   : %s, opening... ", path);
 		
 		ih = call_prom("open", 1, 1, path);
 		if (ih == 0) {
@@ -2389,7 +2389,7 @@
 	/*
 	 * Now finally create the flattened device-tree
 	 */
-	prom_printf("copying OF device tree ...\n");
+	prom_printf("copying OF device tree...\n");
 	flatten_device_tree();
 
 	/*
@@ -2404,7 +2404,7 @@
 	 * Call OF "quiesce" method to shut down pending DMA's from
 	 * devices etc...
 	 */
-	prom_printf("Calling quiesce ...\n");
+	prom_printf("Calling quiesce...\n");
 	call_prom("quiesce", 0, 0);
 
 	/*

-- 
