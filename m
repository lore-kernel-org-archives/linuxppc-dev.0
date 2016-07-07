Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcyh4vKTzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:54:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/5] powerpc/xmon: Remove unused externs
Date: Thu,  7 Jul 2016 22:54:26 +1000
Message-Id: <1467896070-15167-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

None of these are used, or have been since we merged ppc & ppc64.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index c5e155108be5..f351ba6a58ab 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -184,9 +184,6 @@ static void dump_tlb_book3e(void);
 
 static int xmon_no_auto_backtrace;
 
-extern void xmon_enter(void);
-extern void xmon_leave(void);
-
 #ifdef CONFIG_PPC64
 #define REG		"%.16lx"
 #else
@@ -1686,8 +1683,6 @@ write_spr(int n, unsigned long val)
 }
 
 static unsigned long regno;
-extern char exc_prolog;
-extern char dec_exc;
 
 static void dump_one_spr(int spr, bool show_unimplemented)
 {
-- 
2.7.4
