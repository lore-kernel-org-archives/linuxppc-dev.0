Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8783FDE7E1
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:09:03 +1100 (EST)
Message-ID: <45BAC22A.4060708@am.sony.com>
Date: Fri, 26 Jan 2007 19:08:26 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 15/16] ps3: remove unneeded header include
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove an unneeded header include from ps3.h.

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
