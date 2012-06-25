Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 26 Jun 2012 09:33:20 +1000
Subject: [PATCH 13/18] powerpc: introduce new ___PPC_RA/B/S/T macros
In-Reply-To: <1340667187.357853.615199632713.qpush@ale>
Message-Id: <20120625233320.B2E4AD43685@localhost.localdomain>
Cc: mikey@neuling.org, matt@ozlabs.org, linuxppc-dev@ozlabs.org,
 schwab@linux-m68k.org, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are currently the same as __PPC_RA/B/S/T but we'll wrap them
soon.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -144,6 +144,10 @@
 #define PPC_INST_STBCIX			0x7c0007aa
 
 /* macros to insert fields into opcodes */
+#define ___PPC_RA(a)	(((a) & 0x1f) << 16)
+#define ___PPC_RB(b)	(((b) & 0x1f) << 11)
+#define ___PPC_RS(s)	(((s) & 0x1f) << 21)
+#define ___PPC_RT(t)	___PPC_RS(t)
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
 #define __PPC_RB(b)	(((b) & 0x1f) << 11)
 #define __PPC_RS(s)	(((s) & 0x1f) << 21)
