Return-Path: <anton@ozlabs.org>
Date: Sat, 1 Apr 2006 11:33:12 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: trivial spelling fixes in fault.c
Message-ID: <20060401003312.GG23416@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This comment exceeded my bad spelling threshold :)

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index ec4adcb..ba0bc04 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -177,15 +177,15 @@ int __kprobes do_page_fault(struct pt_re
 
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
-	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
-	 * erroneous fault occuring in a code path which already holds mmap_sem
+	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
+	 * erroneous fault occurring in a code path which already holds mmap_sem
 	 * we will deadlock attempting to validate the fault against the
 	 * address space.  Luckily the kernel only validly references user
 	 * space from well defined areas of code, which are listed in the
 	 * exceptions table.
 	 *
 	 * As the vast majority of faults will be valid we will only perform
-	 * the source reference check when there is a possibilty of a deadlock.
+	 * the source reference check when there is a possibility of a deadlock.
 	 * Attempt to lock the address space, if we cannot we then validate the
 	 * source.  If this is invalid we can skip the address space check,
 	 * thus avoiding the deadlock.
