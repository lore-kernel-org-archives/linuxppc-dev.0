Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93D20B7D62
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 06:02:40 +1000 (EST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] 85xx: Fix PCI-E interrupt mapping for slot 0 of P2020DS
Date: Mon, 10 May 2010 22:15:17 +0300
Message-Id: <1273518917-10229-1-git-send-email-felix@embedded-sol.com>
In-Reply-To: <>
References: <>
Cc: Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix legacy PCI-E interrupt mapping for PCI-E slot 0 of
P2020DS evaluation board. The patch is based on P2020DS
device tree from Freescale BSP for this board.

Signed-off-by: Felix Radensky <felix@embedded-sol.com>
---
 arch/powerpc/boot/dts/p2020ds.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 1101914..7c5fc07 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -507,10 +507,10 @@
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x8 0x1
-			0000 0x0 0x0 0x2 &mpic 0x9 0x1
-			0000 0x0 0x0 0x3 &mpic 0xa 0x1
-			0000 0x0 0x0 0x4 &mpic 0xb 0x1
+			0000 0x0 0x0 0x1 &mpic 0x8 0x2
+			0000 0x0 0x0 0x2 &mpic 0x9 0x2
+			0000 0x0 0x0 0x3 &mpic 0xa 0x2
+			0000 0x0 0x0 0x4 &mpic 0xb 0x2
 			>;
 		pcie@0 {
 			reg = <0x0 0x0 0x0 0x0 0x0>;
-- 
1.5.4.3
