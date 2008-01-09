Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail197-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1E122DDF75
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 17:41:29 +1100 (EST)
Message-ID: <47846B30.5040406@am.sony.com>
Date: Tue, 08 Jan 2008 22:35:28 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 1/4] POWERPC: Add Cell SPRN bookmark register
References: <477EF59C.2070809@am.sony.com>
In-Reply-To: <477EF59C.2070809@am.sony.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a definition for the Cell SPRN bookmark register
to asm-powerpc/regs.h

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Needed for PS3's lpm driver.

 include/asm-powerpc/reg.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -553,6 +553,7 @@
 #define SPRN_PA6T_BTCR	978	/* Breakpoint and Tagging Control Register */
 #define SPRN_PA6T_IMAAT	979	/* Instruction Match Array Action Table */
 #define SPRN_PA6T_PCCR	1019	/* Power Counter Control Register */
+#define SPRN_BKMK	1020	/* Cell Bookmark Register */
 #define SPRN_PA6T_RPCCR	1021	/* Retire PC Trace Control Register */
 
 
