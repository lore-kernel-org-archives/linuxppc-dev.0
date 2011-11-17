Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DAB66B7306
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 01:49:30 +1100 (EST)
Received: by wwf10 with SMTP id 10so2461061wwf.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 06:49:26 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] poewrpc/83xx: headers cleanup
Date: Thu, 17 Nov 2011 18:48:49 +0400
Message-Id: <1321541330-2330-3-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
References: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
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
 arch/powerpc/platforms/83xx/km83xx.c           |   26 ------------------
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |    5 ---
 arch/powerpc/platforms/83xx/misc.c             |    1 -
 arch/powerpc/platforms/83xx/mpc830x_rdb.c      |    5 +--
 arch/powerpc/platforms/83xx/mpc831x_rdb.c      |    5 ---
 arch/powerpc/platforms/83xx/mpc832x_mds.c      |   33 ------------------------
 arch/powerpc/platforms/83xx/mpc832x_rdb.c      |   13 ---------
 arch/powerpc/platforms/83xx/mpc834x_itx.c      |   21 ---------------
 arch/powerpc/platforms/83xx/mpc834x_mds.c      |   23 ----------------
 arch/powerpc/platforms/83xx/mpc836x_mds.c      |   32 -----------------------
 arch/powerpc/platforms/83xx/mpc836x_rdk.c      |    9 ------
 arch/powerpc/platforms/83xx/mpc837x_mds.c      |    7 -----
 arch/powerpc/platforms/83xx/mpc837x_rdb.c      |    5 ---
 arch/powerpc/platforms/83xx/sbc834x.c          |   23 ----------------
 arch/powerpc/platforms/83xx/suspend.c          |    8 ------
 arch/powerpc/platforms/83xx/usb.c              |    8 ------
 17 files changed, 2 insertions(+), 224 deletions(-)

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
index 65eb792..3b29e35 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -11,35 +11,9 @@
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
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-
-#include <asm/system.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 #include <asm/qe.h>
-#include <asm/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index ef6537b..d78221a 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -11,19 +11,14 @@
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
 #include <linux/kthread.h>
 #include <linux/reboot.h>
-#include <asm/prom.h>
 #include <asm/machdep.h>
 
 /*
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 125336f..76377fe 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -9,7 +9,6 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
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
index fa25977..9a0486f 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -13,13 +13,8 @@
  * option) any later version.
  */
 
-#include <linux/pci.h>
-#include <linux/of_platform.h>
-
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index e36bc61..e0c25ec 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -10,45 +10,12 @@
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
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
-
-#include <asm/system.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
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
index eff5baa..eabfbb9 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -14,31 +14,18 @@
  * option) any later version.
  */
 
-#include <linux/pci.h>
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
-#include <sysdev/fsl_pci.h>
 
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
index 39849dd..e6fe14f 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -11,31 +11,10 @@
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
-#include <linux/root_dev.h>
 #include <linux/of_platform.h>
 
-#include <asm/system.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 5828d8e..7a850a6 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -11,31 +11,8 @@
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
-#include <linux/root_dev.h>
-#include <linux/of_platform.h>
-
-#include <asm/system.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index ad8e4bc..355aa2d 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -16,47 +16,15 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/compiler.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
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
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
 
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
index f8769d7..2c234bd 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -12,18 +12,9 @@
  * option) any later version.
  */
 
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/of_platform.h>
-#include <linux/io.h>
-#include <asm/prom.h>
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <asm/qe.h>
-#include <asm/qe_ic.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index e53a60b..947ae94 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -11,15 +11,8 @@
  * option) any later version.
  */
 
-#include <linux/pci.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/prom.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 16c9c9c..c6bc87f 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -11,14 +11,9 @@
  * option) any later version.
  */
 
-#include <linux/pci.h>
-#include <linux/of_platform.h>
-
-#include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index 1c3dfc8..9dff3ff 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -13,31 +13,8 @@
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
-#include <linux/root_dev.h>
-#include <linux/of_platform.h>
-
-#include <asm/system.h>
-#include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
 #include <asm/ipic.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
 
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
index 1ad748b..9eb85b8 100644
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
1.7.7.1
