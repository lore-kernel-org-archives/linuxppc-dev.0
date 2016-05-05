Return-Path: <yangbo.lu@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0074.outbound.protection.outlook.com [157.56.110.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0gFg4XT7zDqCF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 13:22:31 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <netdev@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Scott Wood <oss@buserror.net>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King
 <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>, Joerg Roedel
 <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>, "Bhupesh
 Sharma" <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 "Kumar Gala" <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v10, 1/7] Documentation: DT: update Freescale DCFG compatible
Date: Thu, 5 May 2016 11:12:24 +0800
Message-ID: <1462417950-46796-2-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
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

Update Freescale DCFG compatible with 'fsl,<chip>-dcfg' instead
of 'fsl,ls1021a-dcfg' to include more chips such as ls1021a,
ls1043a, and ls2080a.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v8:
	- Added this patch
Changes for v9:
	- Added a list for the possible compatibles
Changes for v10:
	- None
---
 Documentation/devicetree/bindings/arm/fsl.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 752a685..465cba1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -119,7 +119,11 @@ Freescale DCFG
 configuration and status for the device. Such as setting the secondary
 core start address and release the secondary core from holdoff and startup.
   Required properties:
-  - compatible: should be "fsl,ls1021a-dcfg"
+  - compatible: should be "fsl,<chip>-dcfg"
+    Possible compatibles:
+	"fsl,ls1021a-dcfg"
+	"fsl,ls1043a-dcfg"
+	"fsl,ls2080a-dcfg"
   - reg : should contain base address and length of DCFG memory-mapped registers
 
 Example:
-- 
2.1.0.27.g96db324
