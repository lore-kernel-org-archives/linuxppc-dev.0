Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3F78B67A3A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 00:48:39 +1000 (EST)
Received: from localhost (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 13C643685A1
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 00:48:39 +1000 (EST)
Date: Sat, 15 Jul 2006 00:48:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [POWERPC] iseries: Remove unnecessary include of
	iseries/hv_lp_event.h
Message-Id: <20060715004828.7d3803c0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also remove unnecessary reference to struct HvLpEvent.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/asm-offsets.c         |    1 -
 include/asm-powerpc/iseries/it_lp_queue.h |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7ee8496..ac06319 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -40,7 +40,6 @@ #include <asm/vdso_datapage.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #include <asm/lppaca.h>
-#include <asm/iseries/hv_lp_event.h>
 #include <asm/cache.h>
 #include <asm/compat.h>
 #endif
diff --git a/include/asm-powerpc/iseries/it_lp_queue.h b/include/asm-powerpc/iseries/it_lp_queue.h
index 284c5a7..3f68147 100644
--- a/include/asm-powerpc/iseries/it_lp_queue.h
+++ b/include/asm-powerpc/iseries/it_lp_queue.h
@@ -27,8 +27,6 @@ #define _ASM_POWERPC_ISERIES_IT_LP_QUEUE
 #include <asm/types.h>
 #include <asm/ptrace.h>
 
-struct HvLpEvent;
-
 #define IT_LP_MAX_QUEUES	8
 
 #define IT_LP_NOT_USED		0	/* Queue will not be used by PLIC */
-- 
1.4.0
