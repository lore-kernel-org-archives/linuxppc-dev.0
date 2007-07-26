Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FBFEDDFE5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:33:20 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] [POWERPC] Fix mpc7448hpc2 tsi108 device_type bug
Date: Thu, 26 Jul 2007 01:32:36 -0500
Message-Id: <11854315661820-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Fix mpc7448hpc2 tsi108 device_type bug.
Wrong device type will break the board startup.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc7448hpc2.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 0e3d314..b9158eb 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -45,7 +45,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
-		device_type = "tsi108-bridge";
+		device_type = "tsi-bridge";
 		ranges = <00000000 c0000000 00010000>;
 		reg = <c0000000 00010000>;
 		bus-frequency = <0>;
-- 
1.5.2.2
