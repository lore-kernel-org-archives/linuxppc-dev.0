Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 06/20] powerpc/xmon: Remove renaming #defines of scanhex() and
 skipbl()
Date: Wed, 10 Oct 2012 01:20:33 +1100
Message-Id: <1349792447-15714-6-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have two #defines that rename scanhex() and skipbl() to
xmon_scanhex() and xmon_skipbl() - but no one ever uses those
names.

So the only effect is to rename the actual symbols in the generated
code, and AFACIS there is no reason to do that, so drop them.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 67d36ab..cc96a71 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -52,9 +52,6 @@
 #include "nonstdio.h"
 #include "dis-asm.h"
 
-#define scanhex	xmon_scanhex
-#define skipbl	xmon_skipbl
-
 #ifdef CONFIG_SMP
 static cpumask_t cpus_in_xmon = CPU_MASK_NONE;
 static unsigned long xmon_taken = 1;
-- 
1.7.9.5
