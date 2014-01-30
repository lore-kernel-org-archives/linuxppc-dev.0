Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Add cpu family documentation
Date: Thu, 30 Jan 2014 13:38:00 +1100
Message-Id: <1391049480-29346-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds some documentation on the different cpu families
supported by arch/powerpc.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 Documentation/powerpc/cpu_families.txt | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/powerpc/cpu_families.txt

diff --git a/Documentation/powerpc/cpu_families.txt b/Documentation/powerpc/cpu_families.txt
new file mode 100644
index 0000000..df72657
--- /dev/null
+++ b/Documentation/powerpc/cpu_families.txt
@@ -0,0 +1,76 @@
+CPU Families
+============
+
+This doco tries to summarise some of the different cpu families that exist and
+are supported by arch/powerpc.
+
+Book3S (aka sPAPR)
+------------------
+
+ - Hash MMU
+ - Mix of 32 & 64 bit
+
+  Old
+ POWER --- 601 --- 603
+   |            |   |
+   |            |   *----- 740
+   |            |   |
+   |            |   *----- 750 (G3) --- 750CX --- 750CL --- 750FX
+   |            |           |
+   |            |           |
+   |           604          *--- 7400 --- 7410 --- 7450 --- 7455 --- 7447 --- 7448
+   |            |
+   |            |
+   |            *---- [620] --- POWER3/630 --- POWER3+ --- POWER4 --- POWER4+ --- POWER5 --- POWER5+ --- POWER5++ --- POWER6 --- POWER7 --- POWER7+ --- POWER8
+   |                 (64bit)                                                   |    .
+   |                                                                           |    .
+   |                                                                           |    *--- Cell
+   |                                                                           |
+   |                                                                           *--- 970 --- 970FX --- 970MP
+   |
+   *--- RS64 (threads)
+
+
+  PA6T (64bit) ...
+
+
+IBM BookE
+---------
+
+ - Software loaded TLB.
+ - All 32 bit
+
+  401 --- 403 --- 405 --- 440 --- 450 --- 460 --- 476
+                                   |
+                                   *--- BG/P
+
+
+Motorola/Freescale 8xx
+----------------------
+
+ - Software loaded with hardware assist.
+ - All 32 bit
+
+  8xx --- 850
+
+
+Freescale BookE
+---------------
+
+ - Software loaded TLB.
+ - e6500 adds HW loaded indirect TLB entries.
+ - Mix of 32 & 64 bit
+
+  e200 --- e500 --- e500v2 --- e500mc --- e5500 --- e6500
+                                         (Book3E)  (HW TLB)
+                                         (64bit)
+
+IBM A2 core
+-----------
+
+ - Book3E, software loaded TLB + HW loaded indirect TLB entries.
+ - 64 bit
+
+  A2 core --- BG/Q
+     |
+     *------- WSP
-- 
1.8.3.2
