Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A649DDE09
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 05:11:19 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1IpStN-0003li-2G
	for linuxppc-dev@ozlabs.org; Tue, 06 Nov 2007 12:11:14 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH Rev 2] 8xxx: Convert #include of asm/of_{platform,
	device}.h into linux/of_{platform, device}.h.
Date: Tue, 06 Nov 2007 12:11:13 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IpStN-0003li-2G@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

Chip away at some janitor work.
Catch both asm/of_platform.h and asm/of_device.h this time.
Add sfr's ACK.

 arch/powerpc/platforms/82xx/pq2fads.c     |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    4 ++--
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    4 ++--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index 4f457a9..1be5005 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -15,12 +15,12 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
 #include <asm/machdep.h>
-#include <asm/of_platform.h>
 #include <asm/time.h>
 
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 972fa85..4ea1989 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -23,9 +23,9 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
 
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index fbca336..24e6ce6 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -16,8 +16,8 @@
 
 #include <linux/pci.h>
 #include <linux/spi/spi.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_platform.h>
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 0f3855c..3781e3d 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -29,9 +29,9 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
 
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 61b3eed..e6c63a5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -30,9 +30,9 @@
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
 
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
-- 
1.5.3.1.139.g9346b
