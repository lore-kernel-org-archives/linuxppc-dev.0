Return-Path: <Diana.Craciun@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 152E31401FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 22:23:54 +1000 (EST)
Received: from mail125-tx2 (localhost [127.0.0.1])	by
 mail125-tx2-R.bigfish.com (Postfix) with ESMTP id 8B5204000DD	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 12:23:30 +0000 (UTC)
From: Diana Craciun <diana.craciun@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2][powerpc/fsl] Updated T4240 corenet-cf node in device tree
Date: Wed, 9 Apr 2014 15:23:18 +0300
Message-ID: <1397046198-8496-2-git-send-email-diana.craciun@freescale.com>
In-Reply-To: <1397046198-8496-1-git-send-email-diana.craciun@freescale.com>
References: <1397046198-8496-1-git-send-email-diana.craciun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Diana Craciun <Diana.Craciun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <Diana.Craciun@freescale.com>

Updated the compatible to reflect that CCF hardware
is different on T4240

Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index f99d74f..e1a8734 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -343,7 +343,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet2-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
-- 
1.7.11.7
