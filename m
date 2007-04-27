Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id BCCF5DE074
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 05:50:38 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org,
	paulus@samba.org
Subject: [PATCH 6/7] [PPC] Add sane defaults for Xilinx EDK generated
	xparameters files
Date: Fri, 27 Apr 2007 13:50:04 -0600
Message-Id: <11777034164090-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11777034153009-git-send-email-grant.likely@secretlab.ca>
References: <11777034052773-git-send-email-grant.likely@secretlab.ca>
	<1177703413970-git-send-email-grant.likely@secretlab.ca>
	<1177703413868-git-send-email-grant.likely@secretlab.ca>
	<11777034143069-git-send-email-grant.likely@secretlab.ca>
	<11777034141879-git-send-email-grant.likely@secretlab.ca>
	<11777034152490-git-send-email-grant.likely@secretlab.ca>
	<11777034153009-git-send-email-grant.likely@secretlab.ca>
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/ppc/platforms/4xx/xparameters/xparameters.h |   60 ++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters.h b/arch/ppc/platforms/4xx/xparameters/xparameters.h
index 66ec5f3..01aa043 100644
--- a/arch/ppc/platforms/4xx/xparameters/xparameters.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters.h
@@ -34,3 +34,63 @@
 	.io_type	 = SERIAL_IO_MEM,				\
   },
 #endif
+
+/*
+ * A few reasonable defaults for the #defines which could be missing depending
+ * on the IP version or variant (e.g. OPB vs PLB)
+ */
+
+#ifndef XPAR_EMAC_0_CAM_EXIST
+#define XPAR_EMAC_0_CAM_EXIST 0
+#endif
+#ifndef XPAR_EMAC_0_JUMBO_EXIST
+#define XPAR_EMAC_0_JUMBO_EXIST 0
+#endif
+#ifndef XPAR_EMAC_0_TX_DRE_TYPE
+#define XPAR_EMAC_0_TX_DRE_TYPE 0
+#endif
+#ifndef XPAR_EMAC_0_RX_DRE_TYPE
+#define XPAR_EMAC_0_RX_DRE_TYPE 0
+#endif
+#ifndef XPAR_EMAC_0_TX_INCLUDE_CSUM
+#define XPAR_EMAC_0_TX_INCLUDE_CSUM 0
+#endif
+#ifndef XPAR_EMAC_0_RX_INCLUDE_CSUM
+#define XPAR_EMAC_0_RX_INCLUDE_CSUM 0
+#endif
+
+#ifndef XPAR_EMAC_1_CAM_EXIST
+#define XPAR_EMAC_1_CAM_EXIST 0
+#endif
+#ifndef XPAR_EMAC_1_JUMBO_EXIST
+#define XPAR_EMAC_1_JUMBO_EXIST 0
+#endif
+#ifndef XPAR_EMAC_1_TX_DRE_TYPE
+#define XPAR_EMAC_1_TX_DRE_TYPE 0
+#endif
+#ifndef XPAR_EMAC_1_RX_DRE_TYPE
+#define XPAR_EMAC_1_RX_DRE_TYPE 0
+#endif
+#ifndef XPAR_EMAC_1_TX_INCLUDE_CSUM
+#define XPAR_EMAC_1_TX_INCLUDE_CSUM 0
+#endif
+#ifndef XPAR_EMAC_1_RX_INCLUDE_CSUM
+#define XPAR_EMAC_1_RX_INCLUDE_CSUM 0
+#endif
+
+#ifndef XPAR_GPIO_0_IS_DUAL
+#define XPAR_GPIO_0_IS_DUAL 0
+#endif
+#ifndef XPAR_GPIO_1_IS_DUAL
+#define XPAR_GPIO_1_IS_DUAL 0
+#endif
+#ifndef XPAR_GPIO_2_IS_DUAL
+#define XPAR_GPIO_2_IS_DUAL 0
+#endif
+#ifndef XPAR_GPIO_3_IS_DUAL
+#define XPAR_GPIO_3_IS_DUAL 0
+#endif
+#ifndef XPAR_GPIO_4_IS_DUAL
+#define XPAR_GPIO_4_IS_DUAL 0
+#endif
+
-- 
1.5.1
