Date: Tue, 6 Nov 01 13:03:44 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111062103.AA03070@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] fix bug-causing header file typo in linuxppc_2_4_devel
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

The patch below fixes a bug-causing typo in arch/ppc/kernel/cpc710.h.

MS

diff -Nru a/arch/ppc/kernel/cpc710.h b/arch/ppc/kernel/cpc710.h
--- a/arch/ppc/kernel/cpc710.h	Tue Nov  6 12:39:29 2001
+++ b/arch/ppc/kernel/cpc710.h	Tue Nov  6 12:39:29 2001
@@ -58,7 +58,7 @@
 #define PSSIZE	0x000f8100
 #define PPSIZE	0x000f8110
 #define BARPS	0x000f8120
-#define BARPP	0x00008130
+#define BARPP	0x000f8130
 #define PSBAR	0x000f8140
 #define PPBAR	0x000f8150


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
