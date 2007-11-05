Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DAC83DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 08:05:15 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lA5L56Y6020457
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 14:05:11 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lA5L56YS029192
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2007 15:05:06 -0600 (CST)
Subject: [PATCH] Replace some #includes of asm/of_platform.h with
	linux/of_platform.h.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1194296705.7158.45.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 05 Nov 2007 15:05:06 -0600
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
---
Chip away at some janitor work.

 arch/powerpc/platforms/82xx/pq2fads.c     |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
index 972fa85..3ea59af 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -23,9 +23,9 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
+#include <linux/of_platform.h>
 
 #include <asm/of_device.h>
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
index 0f3855c..ec1b03b 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -29,9 +29,9 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
+#include <linux/of_platform.h>
 
 #include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 61b3eed..1d81d22 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -30,9 +30,9 @@
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
 
 #include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
-- 
1.5.3
