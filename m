Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/ptrace: make #defines for all request numbers hex
Date: Wed, 09 Jan 2013 15:45:36 +1100
Message-ID: <4081.1357706736@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a mix of decimal and hex here, so lets make them consistently
hex.  Also, strace will print them in hex if it can't decode them, so
having them in hex here makes it easier to match up.

No functional change.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index ee67a2b..7e1584a 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -146,34 +146,34 @@ struct pt_regs {
  * structures.  This also simplifies the implementation of a bi-arch
  * (combined (32- and 64-bit) gdb.
  */
-#define PTRACE_GETVRREGS	18
-#define PTRACE_SETVRREGS	19
+#define PTRACE_GETVRREGS	0x12
+#define PTRACE_SETVRREGS	0x13
 
 /* Get/set all the upper 32-bits of the SPE registers, accumulator, and
  * spefscr, in one go */
-#define PTRACE_GETEVRREGS	20
-#define PTRACE_SETEVRREGS	21
+#define PTRACE_GETEVRREGS	0x14
+#define PTRACE_SETEVRREGS	0x15
 
 /* Get the first 32 128bit VSX registers */
-#define PTRACE_GETVSRREGS	27
-#define PTRACE_SETVSRREGS	28
+#define PTRACE_GETVSRREGS	0x1b
+#define PTRACE_SETVSRREGS	0x1c
 
 /*
  * Get or set a debug register. The first 16 are DABR registers and the
  * second 16 are IABR registers.
  */
-#define PTRACE_GET_DEBUGREG	25
-#define PTRACE_SET_DEBUGREG	26
+#define PTRACE_GET_DEBUGREG	0x19
+#define PTRACE_SET_DEBUGREG	0x1a
 
 /* (new) PTRACE requests using the same numbers as x86 and the same
  * argument ordering. Additionally, they support more registers too
  */
-#define PTRACE_GETREGS            12
-#define PTRACE_SETREGS            13
-#define PTRACE_GETFPREGS          14
-#define PTRACE_SETFPREGS          15
-#define PTRACE_GETREGS64	  22
-#define PTRACE_SETREGS64	  23
+#define PTRACE_GETREGS            0xc
+#define PTRACE_SETREGS            0xd
+#define PTRACE_GETFPREGS          0xe
+#define PTRACE_SETFPREGS          0xf
+#define PTRACE_GETREGS64	  0x16
+#define PTRACE_SETREGS64	  0x17
 
 /* Calls to trace a 64bit program from a 32bit program */
 #define PPC_PTRACE_PEEKTEXT_3264 0x95
