Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 73582B70E3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 02:56:06 +1000 (EST)
Date: Wed, 11 Aug 2010 20:56:03 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] booting-without-of: Remove nonexistent chapters from TOC,
	fix numbering
Message-ID: <20100811165603.GA22708@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marvell and GPIO bindings live in their own files, so the TOC should not
mention them.

Also fix chapters numbering.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   31 +------------------------
 1 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 46d2210..3f454b7 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -49,40 +49,13 @@ Table of Contents
       f) MDIO on GPIOs
       g) SPI busses
 
-  VII - Marvell Discovery mv64[345]6x System Controller chips
-    1) The /system-controller node
-    2) Child nodes of /system-controller
-      a) Marvell Discovery MDIO bus
-      b) Marvell Discovery ethernet controller
-      c) Marvell Discovery PHY nodes
-      d) Marvell Discovery SDMA nodes
-      e) Marvell Discovery BRG nodes
-      f) Marvell Discovery CUNIT nodes
-      g) Marvell Discovery MPSCROUTING nodes
-      h) Marvell Discovery MPSCINTR nodes
-      i) Marvell Discovery MPSC nodes
-      j) Marvell Discovery Watch Dog Timer nodes
-      k) Marvell Discovery I2C nodes
-      l) Marvell Discovery PIC (Programmable Interrupt Controller) nodes
-      m) Marvell Discovery MPP (Multipurpose Pins) multiplexing nodes
-      n) Marvell Discovery GPP (General Purpose Pins) nodes
-      o) Marvell Discovery PCI host bridge node
-      p) Marvell Discovery CPU Error nodes
-      q) Marvell Discovery SRAM Controller nodes
-      r) Marvell Discovery PCI Error Handler nodes
-      s) Marvell Discovery Memory Controller nodes
-
-  VIII - Specifying interrupt information for devices
+  VII - Specifying interrupt information for devices
     1) interrupts property
     2) interrupt-parent property
     3) OpenPIC Interrupt Controllers
     4) ISA Interrupt Controllers
 
-  IX - Specifying GPIO information for devices
-    1) gpios property
-    2) gpio-controller nodes
-
-  X - Specifying device power management information (sleep property)
+  VIII - Specifying device power management information (sleep property)
 
   Appendix A - Sample SOC node for MPC8540
 
-- 
1.7.0.5
