Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A8778B745B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 04:56:56 +1100 (EST)
Received: by mail-ww0-f45.google.com with SMTP id 10so2764655wwf.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 09:56:56 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/6] poewrpc/85xx: headers cleanup
Date: Thu, 17 Nov 2011 21:56:21 +0400
Message-Id: <1321552581-29773-6-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop lots of unused headers after board files merge/splitup

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.c  |   17 ---------------
 arch/powerpc/platforms/85xx/ksi8560.c     |   16 ---------------
 arch/powerpc/platforms/85xx/mpc8536_ds.c  |   13 ------------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   10 ---------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   23 ---------------------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |   12 -----------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   31 +++-------------------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   12 -----------
 arch/powerpc/platforms/85xx/p1010rdb.c    |   10 ---------
 arch/powerpc/platforms/85xx/p1022_ds.c    |    5 +--
 arch/powerpc/platforms/85xx/p1023_rds.c   |   13 ------------
 arch/powerpc/platforms/85xx/p2041_rdb.c   |   15 +-------------
 arch/powerpc/platforms/85xx/p3041_ds.c    |   15 +-------------
 arch/powerpc/platforms/85xx/p3060_qds.c   |    8 ++----
 arch/powerpc/platforms/85xx/p4080_ds.c    |   14 +------------
 arch/powerpc/platforms/85xx/p5020_ds.c    |   15 +-------------
 arch/powerpc/platforms/85xx/sbc8548.c     |   28 --------------------------
 arch/powerpc/platforms/85xx/sbc8560.c     |   15 +-------------
 arch/powerpc/platforms/85xx/socrates.c    |   15 +-------------
 arch/powerpc/platforms/85xx/stx_gp3.c     |   15 +-------------
 arch/powerpc/platforms/85xx/tqm85xx.c     |   13 +-----------
 arch/powerpc/platforms/85xx/xes_mpc85xx.c |   14 -------------
 22 files changed, 17 insertions(+), 312 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index d782d55..8028d37 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -11,26 +11,9 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/memblock.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/mpic.h>
 
 #include <linux/of_platform.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc85xx.h"
 
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 2f5c3bb..2c7f9d9 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -12,28 +12,12 @@
  *
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
 #include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
 #include <asm/mpic.h>
-#include <mm/mmu_decl.h>
-#include <asm/udbg.h>
-#include <asm/prom.h>
-
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 
 #include <asm/cpm2.h>
-#include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
 
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 8a7fc81..cc46db4 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -9,22 +9,9 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/interrupt.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 384b4cc..27298ec 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -11,20 +11,11 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
 #include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
 #include <asm/mpic.h>
-#include <mm/mmu_decl.h>
 #include <asm/udbg.h>
 
 #include <sysdev/fsl_soc.h>
@@ -32,7 +23,6 @@
 
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
-#include <sysdev/cpm2_pic.h>
 #endif
 
 #include "mpc85xx.h"
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 0e551d7..b9bb364 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -11,35 +11,12 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
 #include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/initrd.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/fsl_devices.h>
 #include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/pci-bridge.h>
 #include <asm/irq.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/i8259.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 246d33a..f43537c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -12,26 +12,14 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/i8259.h>
-#include <asm/swiotlb.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 1f5f1af..69a80b8 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -16,42 +16,19 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/initrd.h>
-#include <linux/module.h>
-#include <linux/fsl_devices.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 #include <linux/phy.h>
-#include <linux/memblock.h>
 
-#include <asm/system.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/irq.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-#include <sysdev/simple_gpio.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
-#include <asm/swiotlb.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <sysdev/simple_gpio.h>
 
 #include "mpc85xx.h"
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 82906b0..b6578a5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -9,21 +9,9 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/interrupt.h>
 #include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 832ed1d..d68c5f8 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -9,19 +9,9 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 82da3dd..fd2ec71 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -18,14 +18,13 @@
 
 #include <linux/pci.h>
 #include <linux/of_platform.h>
-#include <linux/memblock.h>
 #include <asm/div64.h>
+#include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/swiotlb.h>
+#include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/fsl_guts.h>
 
 #include "mpc85xx.h"
 
diff --git a/arch/powerpc/platforms/85xx/p1023_rds.c b/arch/powerpc/platforms/85xx/p1023_rds.c
index 0098775..f14b315 100644
--- a/arch/powerpc/platforms/85xx/p1023_rds.c
+++ b/arch/powerpc/platforms/85xx/p1023_rds.c
@@ -12,22 +12,9 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/fsl_devices.h>
 #include <linux/of_platform.h>
-#include <linux/of_device.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 
diff --git a/arch/powerpc/platforms/85xx/p2041_rdb.c b/arch/powerpc/platforms/85xx/p2041_rdb.c
index eda6ed5..985ee0e 100644
--- a/arch/powerpc/platforms/85xx/p2041_rdb.c
+++ b/arch/powerpc/platforms/85xx/p2041_rdb.c
@@ -9,26 +9,13 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/phy.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/ehv_pic.h>
 
-#include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
 
 #include "corenet_ds.h"
 
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
index 96d99a3..b969c1f 100644
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ b/arch/powerpc/platforms/85xx/p3041_ds.c
@@ -11,26 +11,13 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/phy.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/ehv_pic.h>
 
-#include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
 
 #include "corenet_ds.h"
 
diff --git a/arch/powerpc/platforms/85xx/p3060_qds.c b/arch/powerpc/platforms/85xx/p3060_qds.c
index 01dcf44..318a2de 100644
--- a/arch/powerpc/platforms/85xx/p3060_qds.c
+++ b/arch/powerpc/platforms/85xx/p3060_qds.c
@@ -9,16 +9,14 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/phy.h>
 #include <asm/machdep.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <linux/of_platform.h>
+#include <asm/ehv_pic.h>
+
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
+
 #include "corenet_ds.h"
 
 /*
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
index d1b21d7..bd5ded3 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -11,25 +11,13 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/ehv_pic.h>
 
-#include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
 
 #include "corenet_ds.h"
 
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
index e8cba50..1ff0277 100644
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -11,26 +11,13 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/phy.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
+#include <asm/ehv_pic.h>
 
-#include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/ehv_pic.h>
 
 #include "corenet_ds.h"
 
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index e948b4c..32f5d4d 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -14,35 +14,7 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/initrd.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/fsl_devices.h>
-#include <linux/of_platform.h>
-
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ipic.h>
-#include <asm/pci-bridge.h>
-#include <asm/irq.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index b0c62f0..adae8a5 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -13,21 +13,9 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/of_platform.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpic.h>
-#include <mm/mmu_decl.h>
 #include <asm/udbg.h>
+#include <asm/mpic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -36,7 +24,6 @@
 
 #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
-#include <sysdev/cpm2_pic.h>
 #endif
 
 static void __init sbc8560_pic_init(void)
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index 67535a5..d414ce7 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -21,22 +21,9 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/of_platform.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpic.h>
-#include <asm/prom.h>
-#include <mm/mmu_decl.h>
 #include <asm/udbg.h>
+#include <asm/mpic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 18a9fc5..407abba 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -20,22 +20,9 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/of_platform.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpic.h>
-#include <asm/prom.h>
-#include <mm/mmu_decl.h>
 #include <asm/udbg.h>
+#include <asm/mpic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 56c5518..3d89453 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -18,22 +18,11 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpic.h>
-#include <asm/prom.h>
-#include <mm/mmu_decl.h>
 #include <asm/udbg.h>
+#include <asm/mpic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index e1ddff5..77b6a37 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -12,21 +12,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/interrupt.h>
-#include <linux/of_platform.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 
-- 
1.7.7.1
