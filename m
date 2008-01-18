Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail154-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AFD06DDF69
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:12 +1100 (EST)
Message-ID: <47910C3B.7010402@am.sony.com>
Date: Fri, 18 Jan 2008 12:29:47 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 01/16] POWERPC: Add Cell SPRN bookmark register
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
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

Add a definition for the Cell SPRN bookmark register
to asm-powerpc/regs.h

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
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
 
 

-- 
