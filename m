Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CBF8ADDFDB
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 03:49:13 +1000 (EST)
Date: Tue, 1 May 2007 12:49:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/2] Fix the PCI ranges in the MPC834x_MDS device tree.
Message-ID: <20070501174904.GB31612@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI ranges on the MPC834x_MDS don't match what u-boot configures.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc834x_mds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 07bcc51..df773fa 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -223,7 +223,7 @@
 			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 a0000000 0 10000000
+			ranges = <02000000 0 90000000 90000000 0 10000000
 				  42000000 0 80000000 80000000 0 10000000
 				  01000000 0 00000000 e2000000 0 00100000>;
 			clock-frequency = <3f940aa>;
@@ -284,7 +284,7 @@
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 b0000000 b0000000 0 10000000
-				  42000000 0 90000000 90000000 0 10000000
+				  42000000 0 a0000000 a0000000 0 10000000
 				  01000000 0 00000000 e2100000 0 00100000>;
 			clock-frequency = <3f940aa>;
 			#interrupt-cells = <1>;
-- 
1.5.0.3
