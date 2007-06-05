Return-Path: <b08248@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17C22DDE42
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 04:29:21 +1000 (EST)
Date: Tue, 5 Jun 2007 13:29:14 -0500
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200706051829.l55ITEAR028492@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: add table of contents to booting-without-of-txt
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add table of contents.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

 I think this should help make the doc more easily navigated and will help
 make the structure visible so someone editing will know where to put
 stuff.

 Documentation/powerpc/booting-without-of.txt |   57 +++++++++++++++++++++++++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 258a279..f36ad71 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1,7 +1,6 @@
            Booting the Linux/ppc kernel without Open Firmware
            --------------------------------------------------
 
-
 (c) 2005 Benjamin Herrenschmidt <benh at kernel.crashing.org>,
     IBM Corp.
 (c) 2005 Becky Bruce <becky.bruce at freescale.com>,
@@ -9,6 +8,62 @@
 (c) 2006 MontaVista Software, Inc.
     Flash chip node definition
 
+Table of Contents
+=================
+
+  I - Introduction
+    1) Entry point for arch/powerpc
+    2) Board support
+  
+  II - The DT block format
+    1) Header
+    2) Device tree generalities
+    3) Device tree "structure" block
+    4) Device tree "strings" block
+  
+  III - Required content of the device tree
+    1) Note about cells and address representation
+    2) Note about "compatible" properties
+    3) Note about "name" properties
+    4) Note about node and property names and character set
+    5) Required nodes and properties
+      a) The root node
+      b) The /cpus node
+      c) The /cpus/* nodes
+      d) the /memory node(s)
+      e) The /chosen node
+      f) the /soc<SOCname> node
+  
+  IV - "dtc", the device tree compiler
+  
+  V - Recommendations for a bootloader
+  
+  VI - System-on-a-chip devices and nodes
+    1) Defining child nodes of an SOC
+    2) Representing devices without a current OF specification
+      a) MDIO IO device
+      c) PHY nodes
+      b) Gianfar-compatible ethernet nodes
+      d) Interrupt controllers
+      e) I2C
+      f) Freescale SOC USB controllers
+      g) Freescale SOC SEC Security Engines
+      h) Board Control and Status (BCSR)
+      i) Freescale QUICC Engine module (QE)
+      g) Flash chip nodes
+  
+  VII - Specifying interrupt information for devices
+    1) interrupts property
+    2) interrupt-parent property
+    3) OpenPIC Interrupt Controllers
+    4) ISA Interrupt Controllers
+  
+  Appendix A - Sample SOC node for MPC8540
+
+
+Revision Information
+====================
+
    May 18, 2005: Rev 0.1 - Initial draft, no chapter III yet.
 
    May 19, 2005: Rev 0.2 - Add chapter III and bits & pieces here or
-- 
1.5.0.3
