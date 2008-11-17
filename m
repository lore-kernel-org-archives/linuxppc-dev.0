Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 454CADDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 10:04:17 +1100 (EST)
Subject: [PATCH] powerpc: don't export pci dma inlines
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 00:03:32 +0100
Message-Id: <1226963012.4014.7.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are inlines provided by the pci-dma-compat API.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 arch/powerpc/kernel/ppc_ksyms.c |    2 --
 1 file changed, 2 deletions(-)

--- everything.orig/arch/powerpc/kernel/ppc_ksyms.c	2008-11-17
23:58:35.000000000 +0100
+++ everything/arch/powerpc/kernel/ppc_ksyms.c	2008-11-18
00:01:13.000000000 +0100
@@ -96,8 +96,6 @@ EXPORT_SYMBOL(copy_4K_page);
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);
-EXPORT_SYMBOL(pci_alloc_consistent);
-EXPORT_SYMBOL(pci_free_consistent);
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL(start_thread);
