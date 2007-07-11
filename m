Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6724DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 16:39:42 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6B6dUjA028647
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 23:39:31 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6B6dTdx020521
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:39:30 -0500 (CDT)
Subject: [PATCH] Fix mpc7448hpc2 tsi108 device_type bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184135957.23157.6.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jul 2007 14:39:17 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
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
---
Please apply this patch. The bug breaks the board
startup.
Please copy patches about 74xx and tsi bridge
to me.

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
1.5.1
