Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E49EDDF68
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 03:48:58 +1000 (EST)
Date: Tue, 1 May 2007 12:48:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/2] Fix the PCI ranges in the MPC832x_MDS device tree.
Message-ID: <20070501174847.GA31612@ld0162-tx32.am.freescale.net>
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

The MPC832x_MDS device tree's PCI non-prefetchable MMIO range was
specified incorrectly.  Both the local and bus addresses start at
0x90000000.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index c798491..3c0eeb7 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -146,7 +146,7 @@
 			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 90000000 0 10000000
+			ranges = <02000000 0 90000000 90000000 0 10000000
 			          42000000 0 80000000 80000000 0 10000000
 			          01000000 0 00000000 d0000000 0 00100000>;
 			clock-frequency = <0>;
-- 
1.5.0.3
