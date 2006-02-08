Return-Path: <bgill@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4D7B0689F3
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 14:22:56 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k183cenO006236
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 20:38:40 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k183VeoJ009276
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:31:40 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (cde-tx32-ldt329 [10.82.19.206])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k183JYip021972
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:19:35 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (localhost [127.0.0.1])
	by cde-tx32-ldt329.sps.mot.com (Postfix) with ESMTP id A0CC8C2DD7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2006 21:22:53 -0600 (CST)
Received: from localhost (bgill@localhost)
	by cde-tx32-ldt329.sps.mot.com (8.12.11/8.12.11/Submit) with ESMTP id
	k183MqlL003946
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:22:53 -0600
Date: Tue, 7 Feb 2006 21:22:52 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: mpc85xx_ads.c include file cleanup
Message-ID: <Pine.LNX.4.61.0602072119110.3872@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cut-and-paste from the old platform code in arch/ppc resulted in
arch/powerpc/platforms/85xx/mpc85xx_ads.c having way too many
header files included.  Clean this up.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit f0a2dc035ebf50418e699f789f5c7523092ff553
tree 0e10e705722dbdb52db310d39c1de3b5ff0c4374
parent f692600853b404c2b863bd75fbf41bcc90040002
author Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 20:53:21 -0600
committer Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 20:53:21 -0600

 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 41191e9..9e8a91b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -14,38 +14,17 @@
 #include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
-#include <linux/serial.h>
-#include <linux/tty.h>	/* for linux/serial_core.h */
-#include <linux/serial_core.h>
-#include <linux/initrd.h>
-#include <linux/module.h>
-#include <linux/fsl_devices.h>
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
 
 #include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <asm/atomic.h>
 #include <asm/time.h>
-#include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/bootinfo.h>
 #include <asm/pci-bridge.h>
 #include <asm/mpc85xx.h>
-#include <asm/irq.h>
-#include <asm/immap_85xx.h>
 #include <asm/prom.h>
 #include <asm/mpic.h>
 #include <mm/mmu_decl.h>
