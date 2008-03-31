Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 49A07DE135
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:48:50 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCHv2] powerpc: Describe memory-mapped RAM&ROM chips OF bindings
MIME-Version: 1.0
Date: Mon, 31 Mar 2008 18:39:10 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803311839.10519.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 Documentation/powerpc/booting-without-of.txt |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/p=
owerpc/booting-without-of.txt
index 7b4e8a7..3e1963b 100644
=2D-- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -57,7 +57,8 @@ Table of Contents
       n) 4xx/Axon EMAC ethernet nodes
       o) Xilinx IP cores
       p) Freescale Synchronous Serial Interface
=2D	  q) USB EHCI controllers
+      q) USB EHCI controllers
+      r) Memory-mapped RAM & ROM
=20
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -2816,6 +2817,16 @@ platforms are moved over to use the flattened-device=
=2Dtree model.
 		   big-endian;
 	   };
=20
+   r) Memory-mapped RAM & ROM
+
+    Dedicated RAM and ROM chips are often used as storage for temporary or
+    permanent data in embedded devices. Possible usage include non-volatile
+    storage in battery-backed SRAM, semi-permanent storage in dedicated SR=
AM
+    to preserve data accross reboots and firmware storage in dedicated ROM.
+
+     - name : should be either "ram" or "rom"
+     - reg : Address range of the RAM/ROM chip
+
=20
    More devices will be defined as this spec matures.
=20
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
