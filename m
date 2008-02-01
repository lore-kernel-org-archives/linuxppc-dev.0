Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63CBCDDE1B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 12:40:13 +1100 (EST)
Date: Thu, 31 Jan 2008 19:40:05 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: add rtc node to mpc8313erdb dts
Message-Id: <20080131194005.55ee9fc3.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

the 8313 rdb has a ds1339 at address 0x68.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 2d6653f..e1f0dca 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -118,6 +118,10 @@
 			interrupts = <14 0x8>;
 			interrupt-parent = <&ipic>;
 			dfsrr;
+			rtc@68 {
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
 		};
 
 		i2c@3100 {
-- 
1.5.2.2
