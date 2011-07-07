Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDE07B6F6F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jul 2011 17:38:00 +1000 (EST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/p1022ds: Remove fixed-link property from ethernet
	nodes.
Date: Thu,  7 Jul 2011 10:37:50 +0300
Message-Id: <1310024270-2675-1-git-send-email-felix@embedded-sol.com>
Cc: Felix Radensky <felix@embedded-sol.com>, B04825@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On P1022DS both ethernet controllers are connected to RGMII PHYs
accessible via MDIO bus. Remove fixed-link property from ethernet
nodes as they only required when fixed link PHYs without MDIO bus
are used.

Signed-off-by: Felix Radensky <felix@embedded-sol.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 98d9426..1be9743 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -412,7 +412,6 @@
 			fsl,magic-packet;
 			fsl,wake-on-filer;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			fixed-link = <1 1 1000 0 0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "rgmii-id";
 			queue-group@0{
@@ -439,7 +438,6 @@
 			fsl,num_rx_queues = <0x8>;
 			fsl,num_tx_queues = <0x8>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			fixed-link = <1 1 1000 0 0>;
 			phy-handle = <&phy1>;
 			phy-connection-type = "rgmii-id";
 			queue-group@0{
-- 
1.7.4.4
