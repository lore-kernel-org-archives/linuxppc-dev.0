Return-Path: <claudiu.manoil@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F89E1A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 20:30:52 +1000 (AEST)
From: Claudiu Manoil <claudiu.manoil@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <galak@codeaurora.org>, "David S. Miller"
 <davem@davemloft.net>, Li Yang <leoli@freescale.com>, Zhao Chenhui
 <chenhui.zhao@freescale.com>
Subject: [PATCH 2/3] powerpc: dts: p1022si: Add fsl,wake-on-filer for eTSEC
Date: Thu, 1 Oct 2015 13:10:22 +0300
Message-ID: <1443694222-29519-1-git-send-email-claudiu.manoil@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the "wake-on-filer" (aka. wake on user defined packet)
wake on lan capability for the eTSEC ethernet nodes.

Cc: Li Yang <leoli@freescale.com>
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>

Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 426bf41..5f51b7b 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -224,10 +224,12 @@
 
 /include/ "pq3-etsec2-0.dtsi"
 	enet0: enet0_grp2: ethernet@b0000 {
+		fsl,wake-on-filer;
 	};
 
 /include/ "pq3-etsec2-1.dtsi"
 	enet1: enet1_grp2: ethernet@b1000 {
+		fsl,wake-on-filer;
 	};
 
 	global-utilities@e0000 {
-- 
1.7.11.7
