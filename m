Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69212DDF60
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:30:31 +1100 (EST)
Subject: [PATCH 10/12] powerpc: remove unneeded page_is_ram export
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1170940253.4385.44.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124614.830282000@sipsolutions.net>
	<17866.42529.436809.257415@cargo.ozlabs.ibm.com>
	<1170940253.4385.44.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 14:27:44 +0100
Message-Id: <1170941264.4385.59.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/mm/mem.c exports page_is_ram which is not used anywhere
that could be modular.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6.orig/arch/powerpc/mm/mem.c	2007-02-08 14:07:05.446944128 +0100
+++ linux-2.6/arch/powerpc/mm/mem.c	2007-02-08 14:26:24.016944128 +0100
@@ -83,7 +83,6 @@ int page_is_ram(unsigned long pfn)
 	return 0;
 #endif
 }
-EXPORT_SYMBOL(page_is_ram);
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
