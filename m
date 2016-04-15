Return-Path: <chenhui.zhao@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0072.outbound.protection.outlook.com [157.56.111.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmZpQ3YdHzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 21:20:29 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: <oss@buserror.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <jason.jin@nxp.com>, <chenhui.zhao@nxp.com>
Subject: [PATCH] powerpc/dts: fix rcpm compatible string
Date: Fri, 15 Apr 2016 18:47:46 +0800
Message-ID: <1460717266-21314-1-git-send-email-chenhui.zhao@nxp.com>
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

For T1040, T1042, T1023, and T1024, they should use the compatible
string "fsl,qoriq-rcpm-2.1".

Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index 99e421d..6e0b489 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -263,7 +263,7 @@
 	};
 
 	rcpm: global-utilities@e2000 {
-		compatible = "fsl,t1023-rcpm", "fsl,qoriq-rcpm-2.0";
+		compatible = "fsl,t1023-rcpm", "fsl,qoriq-rcpm-2.1";
 		reg = <0xe2000 0x1000>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index e0f4da5..507649e 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -472,7 +472,7 @@
 	};
 
 	rcpm: global-utilities@e2000 {
-		compatible = "fsl,t1040-rcpm", "fsl,qoriq-rcpm-2.0";
+		compatible = "fsl,t1040-rcpm", "fsl,qoriq-rcpm-2.1";
 		reg = <0xe2000 0x1000>;
 	};
 
-- 
1.9.1
