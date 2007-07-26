Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3AE3DDF78
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:33:14 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] [POWERPC] Fix ethernet PHY support on MPC8544 DS
Date: Thu, 26 Jul 2007 01:32:34 -0500
Message-Id: <11854315641059-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MPC8544 dts needed to set the new phy-connection-type to rgmii-id
for the Vitesse PHY on the board to work properly.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8544ds.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 4a900c6..d8ee4a0 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -104,6 +104,7 @@
 			interrupts = <1d 2 1e 2 22 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
 		};
 
 		ethernet@26000 {
@@ -117,6 +118,7 @@
 			interrupts = <1f 2 20 2 21 2>;
 			interrupt-parent = <&mpic>;
 			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
 		};
 
 		serial@4500 {
-- 
1.5.2.2
