Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0F922C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 10:07:10 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v5 02/17] dts: mpc512x: introduce dt-bindings/clock/ header
Date: Mon, 18 Nov 2013 00:06:02 +0100
Message-Id: <1384729577-7336-3-git-send-email-gsi@denx.de>
In-Reply-To: <1384729577-7336-1-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Detlev Zundel <dzu@denx.de>, Pawel Moll <pawel.moll@arm.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Scott Wood <scottwood@freescale.com>,
 Ian Campbell <ian.campbell@citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

introduce a dt-bindings/ header file for MPC512x clocks,
providing symbolic identifiers for those SoC clocks which
clients will reference from their device tree nodes

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mike Turquette <mturquette@linaro.org>	# for v3: w/o bdlc, PSC ipg
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 include/dt-bindings/clock/mpc512x-clock.h |   69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 include/dt-bindings/clock/mpc512x-clock.h

diff --git a/include/dt-bindings/clock/mpc512x-clock.h b/include/dt-bindings/clock/mpc512x-clock.h
new file mode 100644
index 000000000000..9e81b3b99a32
--- /dev/null
+++ b/include/dt-bindings/clock/mpc512x-clock.h
@@ -0,0 +1,69 @@
+/*
+ * This header provides constants for MPC512x clock specs in DT bindings.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_MPC512x_CLOCK_H
+#define _DT_BINDINGS_CLOCK_MPC512x_CLOCK_H
+
+#define MPC512x_CLK_DUMMY		0
+#define MPC512x_CLK_REF			1
+#define MPC512x_CLK_SYS			2
+#define MPC512x_CLK_DIU			3
+#define MPC512x_CLK_VIU			4
+#define MPC512x_CLK_CSB			5
+#define MPC512x_CLK_E300		6
+#define MPC512x_CLK_IPS			7
+#define MPC512x_CLK_FEC			8
+#define MPC512x_CLK_SATA		9
+#define MPC512x_CLK_PATA		10
+#define MPC512x_CLK_NFC			11
+#define MPC512x_CLK_LPC			12
+#define MPC512x_CLK_MBX_BUS		13
+#define MPC512x_CLK_MBX			14
+#define MPC512x_CLK_MBX_3D		15
+#define MPC512x_CLK_AXE			16
+#define MPC512x_CLK_USB1		17
+#define MPC512x_CLK_USB2		18
+#define MPC512x_CLK_I2C			19
+#define MPC512x_CLK_MSCAN0_MCLK		20
+#define MPC512x_CLK_MSCAN1_MCLK		21
+#define MPC512x_CLK_MSCAN2_MCLK		22
+#define MPC512x_CLK_MSCAN3_MCLK		23
+#define MPC512x_CLK_BDLC		24
+#define MPC512x_CLK_SDHC		25
+#define MPC512x_CLK_PCI			26
+#define MPC512x_CLK_PSC_MCLK_IN		27
+#define MPC512x_CLK_SPDIF_TX		28
+#define MPC512x_CLK_SPDIF_RX		29
+#define MPC512x_CLK_SPDIF_MCLK		30
+#define MPC512x_CLK_SPDIF		31
+#define MPC512x_CLK_AC97		32
+#define MPC512x_CLK_PSC0_MCLK		33
+#define MPC512x_CLK_PSC1_MCLK		34
+#define MPC512x_CLK_PSC2_MCLK		35
+#define MPC512x_CLK_PSC3_MCLK		36
+#define MPC512x_CLK_PSC4_MCLK		37
+#define MPC512x_CLK_PSC5_MCLK		38
+#define MPC512x_CLK_PSC6_MCLK		39
+#define MPC512x_CLK_PSC7_MCLK		40
+#define MPC512x_CLK_PSC8_MCLK		41
+#define MPC512x_CLK_PSC9_MCLK		42
+#define MPC512x_CLK_PSC10_MCLK		43
+#define MPC512x_CLK_PSC11_MCLK		44
+#define MPC512x_CLK_PSC_FIFO		45
+#define MPC512x_CLK_PSC0		46
+#define MPC512x_CLK_PSC1		47
+#define MPC512x_CLK_PSC2		48
+#define MPC512x_CLK_PSC3		49
+#define MPC512x_CLK_PSC4		50
+#define MPC512x_CLK_PSC5		51
+#define MPC512x_CLK_PSC6		52
+#define MPC512x_CLK_PSC7		53
+#define MPC512x_CLK_PSC8		54
+#define MPC512x_CLK_PSC9		55
+#define MPC512x_CLK_PSC10		56
+#define MPC512x_CLK_PSC11		57
+
+#define MPC512x_CLK_LAST_PUBLIC		57
+
+#endif
-- 
1.7.10.4
