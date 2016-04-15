Return-Path: <chenhui.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0099.outbound.protection.outlook.com [157.56.110.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmZfV1XB2zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 21:13:37 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <oss@buserror.net>
CC: <jason.jin@nxp.com>, <chenhui.zhao@nxp.com>
Subject: [PATCH v2 3/5] powerpc/dts: add a compatible string to gpio0
Date: Fri, 15 Apr 2016 19:13:15 +0800
Message-ID: <1460718797-21744-4-git-send-email-chenhui.zhao@nxp.com>
In-Reply-To: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
References: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
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

All gpio nodes used the same compatible string "fsl,qoriq-gpio".
To identify the node corresponding to the GPIO1 pins, add a
compatible string "fsl,qoriq-gpio-1".

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
index cf714f5..1a26d6b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
@@ -33,7 +33,7 @@
  */
 
 gpio0: gpio@130000 {
-	compatible = "fsl,qoriq-gpio";
+	compatible = "fsl,qoriq-gpio-1", "fsl,qoriq-gpio";
 	reg = <0x130000 0x1000>;
 	interrupts = <55 2 0 0>;
 	#gpio-cells = <2>;
-- 
1.9.1
