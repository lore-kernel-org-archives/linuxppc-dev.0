Date: Sat, 8 Mar 2003 03:09:45 +0900
From: "Q-ha Park" <qhpark@jchyun.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: bug in arch/ppc/kernel/traps.c
Message-ID: <dz3834f6/linuxppc-embedded@lists.linuxppc.org/qhpark@jchyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--- 1.43/arch/ppc/kernel/traps.c        Sat Mar  1 03:30:44 2003
+++ edited/traps.c      Sat Mar  8 03:27:08 2003
@@ -176,7 +176,7 @@
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
-#define get_reason(regs)       mfspr(SPRN_ESR);
+#define get_reason(regs)       mfspr(SPRN_ESR)
 #define REASON_FP              0
 #define REASON_ILLEGAL         ESR_PIL
 #define REASON_PRIVILEGED      ESR_PPR


someone should change this.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
