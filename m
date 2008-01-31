Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B0EADE20E
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 05:57:15 +1100 (EST)
Date: Thu, 31 Jan 2008 12:56:58 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: correct 2nd pci controller interrupt value in
	mpc834x_mds dts
Message-Id: <20080131125658.c40b830f.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: peter.vanackeren@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

according to the 8349EA ref man, pci2 IRQ is 67.  Thanks to Peter
Van Ackeren for finding this.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc834x_mds.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 7480eda..0199c5c 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -332,7 +332,7 @@
 				 0xc000 0x0 0x0 0x3 &ipic 23 0x8
 				 0xc000 0x0 0x0 0x4 &ipic 20 0x8>;
 		interrupt-parent = <&ipic>;
-		interrupts = <66 0x8>;
+		interrupts = <67 0x8>;
 		bus-range = <0 0>;
 		ranges = <0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
 			  0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
-- 
1.5.2.2
