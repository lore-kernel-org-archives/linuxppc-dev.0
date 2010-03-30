Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FBA7B7C06
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 12:39:42 +1100 (EST)
From: Andy Fleming <afleming@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] 85xx: Enable support for ports 3 and 4 on 8548 CDS
Date: Mon, 29 Mar 2010 20:39:08 -0500
Message-Id: <1269913148-6450-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I believe support was disabled due to issues with earlier versions of
the board/processor.  At worst, adding the ports back into the device
tree should result in enabling ports that don't work on older systems,
so the default should be to enable them.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 4173af3..0f52624 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -20,10 +20,8 @@
 	aliases {
 		ethernet0 = &enet0;
 		ethernet1 = &enet1;
-/*
 		ethernet2 = &enet2;
 		ethernet3 = &enet3;
-*/
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
@@ -254,7 +252,6 @@
 			};
 		};
 
-/* eTSEC 3/4 are currently broken
 		enet2: ethernet@26000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -310,7 +307,6 @@
 				};
 			};
 		};
- */
 
 		serial0: serial@4500 {
 			cell-index = <0>;
-- 
1.6.5.2.g6ff9a
