Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401brx562KzF196
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 02:54:57 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 45/47] tty: hvc: remove tile driver
Date: Wed, 14 Mar 2018 16:35:58 +0100
Message-Id: <20180314153603.3127932-46-arnd@arndb.de>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Tile architecture is obsolete and getting removed from the kernel,
this removes the corresponding console driver as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/hvc/Makefile   |   1 -
 drivers/tty/hvc/hvc_tile.c | 196 ---------------------------------------------
 2 files changed, 197 deletions(-)
 delete mode 100644 drivers/tty/hvc/hvc_tile.c

diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index b82f9f68cd23..7da1934d34e8 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi_lib.o
 obj-$(CONFIG_HVC_OPAL)		+= hvc_opal.o hvsi_lib.o
 obj-$(CONFIG_HVC_OLD_HVSI)	+= hvsi.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
-obj-$(CONFIG_HVC_TILE)		+= hvc_tile.o
 obj-$(CONFIG_HVC_DCC)		+= hvc_dcc.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.o
diff --git a/drivers/tty/hvc/hvc_tile.c b/drivers/tty/hvc/hvc_tile.c
deleted file mode 100644
index b517c0661abb..000000000000
-- 
2.9.0
