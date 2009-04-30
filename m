Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EEE89DDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 16:58:01 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 30 Apr 2009 16:58:01 +1000
Subject: [PATCH 1/4] powerpc: Cleanup macros in ppc-opcode.h
In-Reply-To: <1241074681.528764.881549582503.qpush@pale>
Message-Id: <20090430065801.96E951222C@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make macros more braces happy.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
@@ -47,10 +47,10 @@
 #define PPC_INST_WAIT			0x7c00007c
 
 /* macros to insert fields into opcodes */
-#define __PPC_RA(a)	((a & 0x1f) << 16)
-#define __PPC_RB(b)	((b & 0x1f) << 11)
-#define __PPC_T_TLB(t)	((t & 0x3) << 21)
-#define __PPC_WC(w)	((w & 0x3) << 21)
+#define __PPC_RA(a)	(((a) & 0x1f) << 16)
+#define __PPC_RB(b)	(((b) & 0x1f) << 11)
+#define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
+#define __PPC_WC(w)	(((w) & 0x3) << 21)
 
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
