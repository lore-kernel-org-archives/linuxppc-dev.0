Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B97A4DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 14:52:45 +1000 (EST)
Date: Thu, 30 Aug 2007 22:58:51 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] export new __io{re,un}map_at() symbols
Message-ID: <20070831035851.GA24414@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Export new __io{re,un}map_at() symbols so modules can use them.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: mainline/arch/powerpc/mm/pgtable_64.c
===================================================================
--- mainline.orig/arch/powerpc/mm/pgtable_64.c
+++ mainline/arch/powerpc/mm/pgtable_64.c
@@ -228,5 +228,7 @@ void iounmap(volatile void __iomem *toke
 EXPORT_SYMBOL(ioremap);
 EXPORT_SYMBOL(ioremap_flags);
 EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(__iounmap);
+EXPORT_SYMBOL(__iounmap_at);
