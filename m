Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C760AB7326
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:54:53 +1000 (EST)
Received: by mail-ew0-f51.google.com with SMTP id 6so1840080ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:53 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 05/14] 83xx: headers cleanup
Date: Tue, 19 Jul 2011 12:53:42 +0400
Message-Id: <1311065631-3429-6-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/platforms/83xx/asp834x.c          |    2 -
 arch/powerpc/platforms/83xx/km83xx.c           |   24 +------------------
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |    5 ----
 arch/powerpc/platforms/83xx/misc.c             |    1 -
 arch/powerpc/platforms/83xx/mpc830x_rdb.c      |    5 +--
 arch/powerpc/platforms/83xx/mpc831x_rdb.c      |    2 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c      |   30 ------------------------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c      |   11 --------
 arch/powerpc/platforms/83xx/mpc834x_itx.c      |   20 ----------------
 arch/powerpc/platforms/83xx/mpc834x_mds.c      |   20 ----------------
 arch/powerpc/platforms/83xx/mpc836x_mds.c      |   29 -----------------------
 arch/powerpc/platforms/83xx/mpc836x_rdk.c      |    8 +-----
 arch/powerpc/platforms/83xx/mpc837x_mds.c      |    4 ---
 arch/powerpc/platforms/83xx/mpc837x_rdb.c      |    2 -
 arch/powerpc/platforms/83xx/sbc834x.c          |   20 ----------------
 arch/powerpc/platforms/83xx/suspend.c          |    8 ------
 arch/powerpc/platforms/83xx/usb.c              |    8 ------
 17 files changed, 4 insertions(+), 195 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/asp834x.c b/arch/powerpc/platforms/83xx/asp834x.c
index 464ea8e..a7c0188 100644
--- a/arch/powerpc/platforms/83xx/asp834x.c
+++ b/arch/powerpc/platforms/83xx/asp834x.c
@@ -14,10 +14,8 @@
  * option) any later version.
  */
 
-#include <linux/pci.h>
 #include <linux/of_platform.h>
 
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index b9aaa50..e6c70e3 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -11,35 +11,13 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
 #include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
+
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 #include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index 70798ac..f47aac2 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -11,17 +11,12 @@
  * (at your option) any later version.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/device.h>
-#include <linux/mutex.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
-#include <asm/prom.h>
 #include <asm/machdep.h>
 
 /*
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index cd65f5a..ae61e10 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -9,7 +9,6 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index ef595f1..6e4783d 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -14,12 +14,11 @@
  */
 
 #include <linux/pci.h>
-#include <linux/of_platform.h>
-#include <asm/time.h>
+
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_pci.h>
-#include <sysdev/fsl_soc.h>
+
 #include "mpc83xx.h"
 
 /*
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index ce87406..ac38b14 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -14,9 +14,7 @@
  */
 
 #include <linux/pci.h>
-#include <linux/of_platform.h>
 
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 8ee1440..bea4d0c 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -10,45 +10,15 @@
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
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
+
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/qe.h>
-#include <asm/qe_ic.h>
 
 #include "mpc83xx.h"
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* ************************************************************************
  *
  * Setup the architecture
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index c10d0c4..8672d41 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -15,30 +15,19 @@
  */
 
 #include <linux/pci.h>
-#include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/mmc_spi.h>
 #include <linux/mmc/host.h>
-#include <linux/of_platform.h>
 #include <linux/fsl_devices.h>
 
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <asm/qe.h>
-#include <asm/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 #ifdef CONFIG_QUICC_ENGINE
 static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
 				   struct spi_board_info *board_infos,
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index d9ea7b7..53e403b 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -11,30 +11,10 @@
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
-#include <linux/root_dev.h>
-#include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 381e94e..6aedff9 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -11,30 +11,10 @@
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
-#include <linux/root_dev.h>
-#include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 1b90701..c9624b5 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -16,31 +16,9 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/compiler.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
 #include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
+
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -50,13 +28,6 @@
 
 #include "mpc83xx.h"
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 /* ************************************************************************
  *
  * Setup the architecture
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 2563174..cafb0c6 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -12,17 +12,11 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/of_platform.h>
-#include <linux/io.h>
-#include <asm/prom.h>
-#include <asm/time.h>
+
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <asm/qe.h>
-#include <asm/qe_ic.h>
-#include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 7463183..fe76bd7 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -12,13 +12,9 @@
  */
 
 #include <linux/pci.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
 
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/prom.h>
 #include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index a4a5336..a6e649e 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -12,9 +12,7 @@
  */
 
 #include <linux/pci.h>
-#include <linux/of_platform.h>
 
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index 3d98bd9..ea02022 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -13,30 +13,10 @@
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
-#include <linux/root_dev.h>
-#include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 104faa8..d0c814a 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -10,21 +10,13 @@
  * by the Free Software Foundation.
  */
 
-#include <linux/init.h>
-#include <linux/pm.h>
-#include <linux/types.h>
-#include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/wait.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/suspend.h>
-#include <linux/fsl_devices.h>
 #include <linux/of_platform.h>
 
-#include <asm/reg.h>
-#include <asm/io.h>
-#include <asm/time.h>
 #include <asm/mpc6xx.h>
 
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 2c64164..b2fda49 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -10,14 +10,6 @@
  * option) any later version.
  */
 
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/of.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
 #include "mpc83xx.h"
-- 
1.7.2.5
