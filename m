Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id DDCE21A0CA2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:16:59 +1000 (AEST)
Message-Id: <20150531010135.349475001@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:44 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 12/24] char/nvram: Add "devname:nvram" module alias
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/char/nvram.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:11.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:13.000000000 +1000
@@ -575,3 +575,4 @@ module_exit(nvram_module_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
+MODULE_ALIAS("devname:nvram");
