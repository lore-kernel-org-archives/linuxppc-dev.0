Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBD10DDEC2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 23:24:59 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l4HDOZpX026300
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 15:24:35 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l4HDOYGY026298
	for linuxppc-dev@ozlabs.org; Thu, 17 May 2007 15:24:34 +0200
Date: Thu, 17 May 2007 15:24:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix 440-related Kconfig warnings
Message-ID: <20070517132434.GA26230@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently there is no IBM_NEW_EMAC_ZMII in the tree, so we shouldn't 
selected it.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig	2007-05-17 14:06:45.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/44x/Kconfig	2007-05-17 14:06:56.000000000 +0200
@@ -38,7 +38,7 @@ config 440EP
 
 config 440GP
 	bool
-	select IBM_NEW_EMAC_ZMII
+#	select IBM_NEW_EMAC_ZMII
 
 config 440GX
 	bool
Index: linux-2.6/arch/powerpc/platforms/4xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/4xx/Kconfig	2007-05-17 14:16:46.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/4xx/Kconfig	2007-05-17 14:16:52.000000000 +0200
@@ -171,7 +171,7 @@ config 440EP
 
 config 440GP
 	bool
-	select IBM_NEW_EMAC_ZMII
+#	select IBM_NEW_EMAC_ZMII
 
 config 440GX
 	bool
