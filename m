Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 8B249DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:06 +1100 (EST)
Message-Id: <20071218175105.491157000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:02 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 10/18] Remove bogus comment in dma_direct_alloc_coherent()
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since commit c80d9133e99de1af607314107910a2a1645efb17 (Make direct DMA use
node local allocations) went in this comment makes no sense.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/dma_64.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

Index: linux-2.6-new/arch/powerpc/kernel/dma_64.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/kernel/dma_64.c
+++ linux-2.6-new/arch/powerpc/kernel/dma_64.c
@@ -137,7 +137,6 @@ static void *dma_direct_alloc_coherent(s
 	void *ret;
 	int node = dev->archdata.numa_node;
 
-	/* TODO: Maybe use the numa node here too ? */
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
 		return NULL;

-- 
