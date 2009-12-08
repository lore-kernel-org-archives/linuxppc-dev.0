Return-Path: <b08308@lc1105.zin33.ap.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14EDFB7BBA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 18:31:23 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB87VKZP002936
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Dec 2009 00:31:20 -0700 (MST)
From: Vivek Mahajan <vivek.mahajan@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/fsl: 85xx: p2020rdb: add cache sram node
Date: Tue,  8 Dec 2009 13:01:16 +0530
Message-Id: <1260257477-21942-2-git-send-email-vivek.mahajan@freescale.com>
In-Reply-To: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
References: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
Cc: kumar.gala@freescale.com, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
---
 arch/powerpc/boot/dts/p2020rdb.dts |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index da4cb0d..8a26050 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -583,4 +583,10 @@
 				  0x0 0x100000>;
 		};
 	};
+
+	cache-sram@fff00000 {
+		fsl,cache-sram-ctlr-handle = <&L2>;
+		reg = <0 0xfff00000 0 0x10000>;
+		compatible = "fsl,p2020-cache-sram";
+	};
 };
-- 
1.5.6.5
