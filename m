Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 11ECA100C0D
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:24 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGELqt031529
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:21 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 05/30] powerpc/85xx: Add ethernet magic packet property
 to P1020 device tree
Date: Thu, 10 Nov 2011 10:13:48 -0600
Message-Id: <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All eTSEC2 controllers support waking on magic packet so fixup device
tree to report that.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020si.dtsi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
index 5514e1d..14dff69 100644
--- a/arch/powerpc/boot/dts/p1020si.dtsi
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -200,6 +200,7 @@
 			compatible = "fsl,etsec2";
 			fsl,num_rx_queues = <0x8>;
 			fsl,num_tx_queues = <0x8>;
+			fsl,magic-packet;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&mpic>;
 
@@ -226,6 +227,7 @@
 			compatible = "fsl,etsec2";
 			fsl,num_rx_queues = <0x8>;
 			fsl,num_tx_queues = <0x8>;
+			fsl,magic-packet;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&mpic>;
 
@@ -252,6 +254,7 @@
 			compatible = "fsl,etsec2";
 			fsl,num_rx_queues = <0x8>;
 			fsl,num_tx_queues = <0x8>;
+			fsl,magic-packet;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&mpic>;
 
-- 
1.7.3.4
