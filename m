Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8A00DDDFF1
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 15:31:03 +1100 (EST)
Message-ID: <45B8189C.8050900@am.sony.com>
Date: Wed, 24 Jan 2007 18:40:28 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 13/14] ps3: remove unneeded header include
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove and unneeded header include from ps3.h.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 include/asm-powerpc/ps3.h |   12 ------------
 1 files changed, 12 deletions(-)

--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -21,7 +21,6 @@
 #if !defined(_ASM_POWERPC_PS3_H)
 #define _ASM_POWERPC_PS3_H
 
-#include <linux/compiler.h> /* for __deprecated */
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
