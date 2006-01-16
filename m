Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 239D968926
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 23:12:05 +1100 (EST)
Date: Mon, 16 Jan 2006 13:11:57 +0100
From: Olaf Hering <olh@suse.de>
To: Arnd Bergmann <arndb@de.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [PATCH] fix spider compilation
Message-ID: <20060116121157.GA7171@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


linux-2.6.15/drivers/net/spider_net.c: In function `spider_net_set_txdescr_cmdstat':
linux-2.6.15/drivers/net/spider_net.c:890: error: `IPPROTO_TCP' undeclared (first use in this function)
linux-2.6.15/drivers/net/spider_net.c:890: error: (Each undeclared identifier is reported only once
linux-2.6.15/drivers/net/spider_net.c:890: error: for each function it appears in.)
linux-2.6.15/drivers/net/spider_net.c:892: error: `IPPROTO_UDP' undeclared (first use in this function)

Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/net/spider_net.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.15/drivers/net/spider_net.c
===================================================================
--- linux-2.6.15.orig/drivers/net/spider_net.c
+++ linux-2.6.15/drivers/net/spider_net.c
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/ip.h>
+#include <linux/in.h>
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
