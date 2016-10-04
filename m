Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe44::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp9d63zNFzDskn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 18:33:30 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linuxdev.baldrick@gmail.com>
Subject: [net-next 13/13] MAINTAINERS: net: add entry for Freescale QorIQ DPAA
 FMan driver
Date: Tue, 4 Oct 2016 10:32:59 +0300
Message-ID: <1475566379-5078-14-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1475566379-5078-1-git-send-email-madalin.bucur@nxp.com>
References: <1475566379-5078-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

Add record for Freescale QORIQ DPAA FMan driver adding myself as
maintainer.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 669909e..3460152 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4980,6 +4980,13 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
 F:	drivers/net/ethernet/freescale/fec.h
 F:	Documentation/devicetree/bindings/net/fsl-fec.txt
 
+FREESCALE QORIQ DPAA FMAN DRIVER
+M:	Madalin Bucur <madalin.bucur@nxp.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/freescale/fman
+F:	Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+
 FREESCALE QUICC ENGINE LIBRARY
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Orphan
-- 
2.1.0
