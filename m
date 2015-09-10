Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0139.outbound.protection.outlook.com [157.56.111.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B97901A0796
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 12:14:06 +1000 (AEST)
From: Poonam Aggrwal <poonam.aggrwal@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <scottwood@freescale.com>, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>
Subject: [PATCH] fsl/powerpc/b4860: Removed LIODN register from sRIO node
Date: Thu, 10 Sep 2015 07:31:20 +0530
Message-ID: <1441850480-17813-1-git-send-email-poonam.aggrwal@freescale.com>
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

In case of B4860 LIODN register for sRIO is not in GUTs block but in the sRIO
register space.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
- based of: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  branch master 

 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 9ba904b..d1e26a7 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -51,14 +51,12 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <1>;
-		fsl,liodn-reg = <&guts 0x510>; /* RIO1LIODNR */
 	};
 
 	port2 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		cell-index = <2>;
-		fsl,liodn-reg = <&guts 0x514>; /* RIO2LIODNR */
 	};
 };
 
-- 
1.9.1
