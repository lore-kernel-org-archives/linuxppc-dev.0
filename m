Return-Path: <anton@ozlabs.org>
Date: Fri, 6 Oct 2006 02:54:07 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Update MTFSF_L() comment
Message-ID: <20061005165407.GA19972@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwmw2@infradead.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


David Woodhouse points out that the comment accompanying the MTFSF_L
macro is misleading. We should make it clear that the L bit is ignored
on older CPUS, not the entire instruction.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index 3a9fcc1..8fb9681 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -503,7 +503,7 @@ #endif
 
 /*
  * An mtfsf instruction with the L bit set. On CPUs that support this a
- * full 64bits of FPSCR is restored and on other CPUs it is ignored.
+ * full 64bits of FPSCR is restored and on other CPUs the L bit is ignored.
  *
  * Until binutils gets the new form of mtfsf, hardwire the instruction.
  */
