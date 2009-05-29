Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <400c5ac9bcab8891e15d83b722d97ae1e09ea5f2.1243575200.git.michael@ellerman.id.au>
In-Reply-To: <8e59964be84e85d2ca8c08db3fdd979db61fb0f6.1243575200.git.michael@ellerman.id.au>
References: <8e59964be84e85d2ca8c08db3fdd979db61fb0f6.1243575200.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/3] powerpc/ftrace: Remove unused macros
Date: Fri, 29 May 2009 15:33:35 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These macros were used in the original port, but since commit
e4486fe316 (ftrace, use probe_kernel API to modify code) they
are unused.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/ftrace.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 8585217..8620ecb 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -43,14 +43,6 @@ ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 	return op;
 }
 
-#ifdef CONFIG_PPC64
-# define _ASM_ALIGN	" .align 3 "
-# define _ASM_PTR	" .llong "
-#else
-# define _ASM_ALIGN	" .align 2 "
-# define _ASM_PTR	" .long "
-#endif
-
 static int
 ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
 {
-- 
1.6.2.1
