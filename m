Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 792C0DDFC6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 11:11:56 +1100 (EST)
Date: Fri, 23 Mar 2007 01:11:59 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] remove unused inclusion of linux/ide.h
Message-ID: <20070323001159.GB14583@aepfle.de>
References: <20070322221117.GA13481@aepfle.de>
	<20070322221407.GA13592@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070322221407.GA13592@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove unneeded inclusion of linux/ide.h
It does not compile with CONFIG_BLOCK=n

Remove asm/ide.h from ksyms file, it gets included earlier via
linux/ide.h

Compile tested with all defconfig files.


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/kernel/ppc_ksyms.c                   |    1 -
 arch/powerpc/kernel/setup-common.c                |    1 -
 arch/powerpc/kernel/setup_64.c                    |    1 -
 arch/powerpc/platforms/chrp/pci.c                 |    1 -
 arch/powerpc/platforms/chrp/setup.c               |    1 -
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1 -
 arch/powerpc/platforms/iseries/irq.c              |    1 -
 arch/powerpc/platforms/iseries/pci.c              |    1 -
 arch/powerpc/platforms/maple/setup.c              |    1 -
 arch/powerpc/platforms/powermac/setup.c           |    1 -
 10 files changed, 10 deletions(-)

Index: b/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -20,7 +20,6 @@
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/ide.h>
 #include <asm/atomic.h>
 #include <asm/checksum.h>
 #include <asm/pgtable.h>
Index: b/arch/powerpc/kernel/setup-common.c
===================================================================
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -21,7 +21,6 @@
 #include <linux/delay.h>
 #include <linux/initrd.h>
 #include <linux/platform_device.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
Index: b/arch/powerpc/kernel/setup_64.c
===================================================================
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -20,7 +20,6 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
Index: b/arch/powerpc/platforms/chrp/pci.c
===================================================================
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -7,7 +7,6 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/ide.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
Index: b/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -28,7 +28,6 @@
 #include <linux/adb.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/ide.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
Index: b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -25,7 +25,6 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/serial.h>
Index: b/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -30,7 +30,6 @@
 #include <linux/param.h>
 #include <linux/string.h>
 #include <linux/bootmem.h>
-#include <linux/ide.h>
 #include <linux/irq.h>
 #include <linux/spinlock.h>
 
Index: b/arch/powerpc/platforms/iseries/pci.c
===================================================================
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -24,7 +24,6 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/ide.h>
 #include <linux/pci.h>
 
 #include <asm/io.h>
Index: b/arch/powerpc/platforms/maple/setup.c
===================================================================
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -32,7 +32,6 @@
 #include <linux/initrd.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
-#include <linux/ide.h>
 #include <linux/pci.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
Index: b/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -42,7 +42,6 @@
 #include <linux/initrd.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
-#include <linux/ide.h>
 #include <linux/pci.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
