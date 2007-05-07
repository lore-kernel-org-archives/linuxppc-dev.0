Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C6D0DDF19
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:15 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l47IT9tM003298
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:10 -0700 (MST)
Date: Mon, 7 May 2007 13:29:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/13] Clean up formatting in
	Documentation/booting-without-of.txt.
Message-ID: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Clean up whitespace issues (the indentation level of SOC device bindings
was moving around as one goes through the list).

2. Number QE devices with numbers rather than roman numerals; it's rather
confusing to have two "i)"s right next to each other, especially without
additional indentation.

3. Label flash chip nodes as "j)" (the next one in sequence), not "g)"
(which is used by Freescale SOC SEC Security Engines).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   80 +++++++++++++-------------
 1 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index d4bfae7..aaea829 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1134,20 +1134,20 @@ descriptions for the SOC devices for which new nodes have been
 defined; this list will expand as more and more SOC-containing
 platforms are moved over to use the flattened-device-tree model.
 
-  a) MDIO IO device
+   a) MDIO IO device
 
-  The MDIO is a bus to which the PHY devices are connected.  For each
-  device that exists on this bus, a child node should be created.  See
-  the definition of the PHY node below for an example of how to define
-  a PHY.
+   The MDIO is a bus to which the PHY devices are connected.  For each
+   device that exists on this bus, a child node should be created.  See
+   the definition of the PHY node below for an example of how to define
+   a PHY.
 
-  Required properties:
+   Required properties:
     - reg : Offset and length of the register set for the device
     - device_type : Should be "mdio"
     - compatible : Should define the compatible device type for the
       mdio.  Currently, this is most likely to be "gianfar"
 
-  Example:
+   Example:
 
 	mdio@24520 {
 		reg = <24520 20>;
@@ -1160,9 +1160,9 @@ platforms are moved over to use the flattened-device-tree model.
 	};
 
 
-  b) Gianfar-compatible ethernet nodes
+   b) Gianfar-compatible ethernet nodes
 
-  Required properties:
+   Required properties:
 
     - device_type : Should be "network"
     - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
@@ -1180,14 +1180,14 @@ platforms are moved over to use the flattened-device-tree model.
     - phy-handle : The phandle for the PHY connected to this ethernet
       controller.
 
-  Recommended properties:
+   Recommended properties:
 
     - linux,network-index : This is the intended "index" of this
       network device.  This is used by the bootwrapper to interpret
       MAC addresses passed by the firmware when no information other
       than indices is available to associate an address with a device.
 
-  Example:
+   Example:
 
 	ethernet@24000 {
 		#size-cells = <0>;
@@ -1202,7 +1202,6 @@ platforms are moved over to use the flattened-device-tree model.
 	};
 
 
-
    c) PHY nodes
 
    Required properties:
@@ -1219,7 +1218,6 @@ platforms are moved over to use the flattened-device-tree model.
     - linux,phandle :  phandle for this node; likely referenced by an
       ethernet controller node.
 
-
    Example:
 
 	ethernet-phy@0 {
@@ -1447,7 +1445,7 @@ platforms are moved over to use the flattened-device-tree model.
    The description below applies to the the qe of MPC8360 and
    more nodes and properties would be extended in the future.
 
-   i) Root QE device
+   1) Root QE device
 
    Required properties:
    - device_type : should be "qe";
@@ -1473,7 +1471,7 @@ platforms are moved over to use the flattened-device-tree model.
 	}
 
 
-   ii) SPI (Serial Peripheral Interface)
+   2) SPI (Serial Peripheral Interface)
 
    Required properties:
    - device_type : should be "spi".
@@ -1499,7 +1497,7 @@ platforms are moved over to use the flattened-device-tree model.
 	};
 
 
-   iii) USB (Universal Serial Bus Controller)
+   3) USB (Universal Serial Bus Controller)
 
    Required properties:
    - device_type : should be "usb".
@@ -1525,7 +1523,7 @@ platforms are moved over to use the flattened-device-tree model.
 	};
 
 
-   iv) UCC (Unified Communications Controllers)
+   4) UCC (Unified Communications Controllers)
 
    Required properties:
    - device_type : should be "network", "hldc", "uart", "transparent"
@@ -1582,7 +1580,7 @@ platforms are moved over to use the flattened-device-tree model.
 	};
 
 
-   v) Parallel I/O Ports
+   5) Parallel I/O Ports
 
    This node configures Parallel I/O ports for CPUs with QE support.
    The node should reside in the "soc" node of the tree.  For each
@@ -1607,7 +1605,7 @@ platforms are moved over to use the flattened-device-tree model.
 		};
 
 
-   vi) Pin configuration nodes
+   6) Pin configuration nodes
 
    Required properties:
    - linux,phandle : phandle of this node; likely referenced by a QE
@@ -1666,7 +1664,7 @@ platforms are moved over to use the flattened-device-tree model.
 			2  8  2  0  1  0>;	/* GTX125 - CLK9 */
 	};
 
-   vii) Multi-User RAM (MURAM)
+   7) Multi-User RAM (MURAM)
 
    Required properties:
    - device_type : should be "muram".
@@ -1687,32 +1685,32 @@ platforms are moved over to use the flattened-device-tree model.
 		};
 	};
 
-    g) Flash chip nodes
+   j) Flash chip nodes
 
-    Flash chips (Memory Technology Devices) are often used for solid state
-    file systems on embedded devices.
+   Flash chips (Memory Technology Devices) are often used for solid state
+   file systems on embedded devices.
 
-    Required properties:
+   Required properties:
 
-     - device_type : has to be "rom"
-     - compatible : Should specify what this flash device is compatible with.
-       Currently, this is most likely to be "direct-mapped" (which
-       corresponds to the MTD physmap mapping driver).
-     - reg : Offset and length of the register set (or memory mapping) for
-       the device.
-     - bank-width : Width of the flash data bus in bytes. Required
-       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
+    - device_type : has to be "rom"
+    - compatible : Should specify what this flash device is compatible with.
+      Currently, this is most likely to be "direct-mapped" (which
+      corresponds to the MTD physmap mapping driver).
+    - reg : Offset and length of the register set (or memory mapping) for
+      the device.
+    - bank-width : Width of the flash data bus in bytes. Required
+      for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
 
-    Recommended properties :
+   Recommended properties :
 
-     - partitions : Several pairs of 32-bit values where the first value is
-       partition's offset from the start of the device and the second one is
-       partition size in bytes with LSB used to signify a read only
-       partition (so, the partition size should always be an even number).
-     - partition-names : The list of concatenated zero terminated strings
-       representing the partition names.
-     - probe-type : The type of probe which should be done for the chip
-       (JEDEC vs CFI actually). Valid ONLY for NOR flashes.
+    - partitions : Several pairs of 32-bit values where the first value is
+      partition's offset from the start of the device and the second one is
+      partition size in bytes with LSB used to signify a read only
+      partition (so, the partition size should always be an even number).
+    - partition-names : The list of concatenated zero terminated strings
+      representing the partition names.
+    - probe-type : The type of probe which should be done for the chip
+      (JEDEC vs CFI actually). Valid ONLY for NOR flashes.
 
    Example:
 
-- 
1.5.0.3
