Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A2FD2DDEC2
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 20:08:59 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l1598w2j027677
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 02:08:58 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1598tc1027081
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 03:08:56 -0600 (CST)
Message-ID: <45C6F472.4090408@freescale.com>
Date: Mon, 05 Feb 2007 17:10:10 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH 3/3] 8349emds default dts updates for USB change
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8349emds.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index efceb34..ba31af1 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -39,6 +39,11 @@
 		reg = <00000000 10000000>;	// 256MB at 0
 	};
 
+	bcsr@f8000000 {
+		device_type = "board-control";
+		reg = <e2400000 8000>;
+	};
+
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -103,6 +108,7 @@
 			#size-cells = <0>;
 			interrupt-parent = <700>;
 			interrupts = <26 2>;
+			dr_mode = "otg";
 			phy_type = "ulpi";
 		};
 
