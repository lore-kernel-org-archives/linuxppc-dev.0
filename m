Return-Path: <yangbo.lu@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0090.outbound.protection.outlook.com [157.56.111.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrmC762HDzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 16:37:55 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <netdev@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <scott.wood@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jochen Friedrich
 <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>, Zhao Qiang <qiang.zhao@freescale.com>, "Kumar
 Gala" <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific driver
Date: Fri, 22 Apr 2016 14:27:43 +0800
Message-ID: <1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
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

Add maintainer entry for Freescale SoC specific driver including
the QE library and the GUTS driver. Also add entry for GUTS driver
and add maintainer for QE library.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v8:
	- Added this patch
---
 MAINTAINERS | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d5b4be..d20aeb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4622,13 +4622,27 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
 F:	drivers/net/ethernet/freescale/fec.h
 F:	Documentation/devicetree/bindings/net/fsl-fec.txt
 
+FREESCALE SOC SPECIFIC DRIVER
+M:	Scott Wood <oss@buserror.net>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	drivers/soc/fsl/
+F:	include/linux/fsl/
+
 FREESCALE QUICC ENGINE LIBRARY
+M:	Qiang Zhao <qiang.zhao@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Orphan
+S:	Maintained
 F:	drivers/soc/fsl/qe/
 F:	include/soc/fsl/*qe*.h
 F:	include/soc/fsl/*ucc*.h
 
+FREESCALE GUTS DRIVER
+M:	Yangbo Lu <yangbo.lu@nxp.com>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	drivers/soc/fsl/guts.c
+
 FREESCALE USB PERIPHERAL DRIVERS
 M:	Li Yang <leoli@freescale.com>
 L:	linux-usb@vger.kernel.org
-- 
2.1.0.27.g96db324
