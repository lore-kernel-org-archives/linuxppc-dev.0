Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id 23CF76819A
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 07:00:53 +1100 (EST)
Received: from mail7.sony.co.jp (localhost [127.0.0.1])
	by mail7.sony.co.jp (R8/Sony) with ESMTP id kAAK0qmD009500
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:00:52 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail7.sony.co.jp (R8/Sony) with SMTP id kAAK0q0l009489
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 05:00:52 +0900 (JST)
Message-ID: <4554DA6F.6060400@am.sony.com>
Date: Fri, 10 Nov 2006 12:00:47 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/16] cell: set ARCH_SPARSEMEM_DEFAULT in Kconfig
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current cell processor support needs sparsemem, so set it as
the default memory model.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
As noted by Benjamin Herrenschmidt.

Index: cell--common--6/arch/powerpc/Kconfig
===================================================================
--- cell--common--6.orig/arch/powerpc/Kconfig
+++ cell--common--6/arch/powerpc/Kconfig
@@ -734,7 +734,7 @@
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on SMP && PPC_PSERIES
+	depends on (SMP && PPC_PSERIES) || PPC_CELL
 
 config ARCH_POPULATES_NODE_MAP
 	def_bool y
