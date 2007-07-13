Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4A08DDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 19:35:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6D9ZkSk027722
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 02:35:46 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6D9ZiuU023985
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 04:35:45 -0500 (CDT)
Subject: [PATCH] Add global-utilities node for mpc8544ds and mpc8572mds boards
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184319333.30789.17.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jul 2007 17:35:33 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Add global-utilities node for mpc8544ds and mpc8572mds boards

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8544ds.dts  |    6 ++++++
 arch/powerpc/boot/dts/mpc8568mds.dts |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 8285925..43bf5c1 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -137,6 +137,12 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8548-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index c6cd1d6..5eeb0e6 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -170,6 +170,12 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8548-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+
 		pci@8000 {
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
-- 
1.5.1
