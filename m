Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v1 07/24] dts: mpc512x: introduce dt-bindings/clock/ header
Date: Mon, 15 Jul 2013 20:47:36 +0200
Message-Id: <1373914074-20889-8-git-send-email-gsi@denx.de>
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
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

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 include/dt-bindings/clock/mpc512x-clock.h |   59 +++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 include/dt-bindings/clock/mpc512x-clock.h

diff --git a/include/dt-bindings/clock/mpc512x-clock.h b/include/dt-bindings/clock/mpc512x-clock.h
new file mode 100644
index 0000000..46c560e
--- /dev/null
+++ b/include/dt-bindings/clock/mpc512x-clock.h
@@ -0,0 +1,59 @@
+/*
+ * This header provides constants for MPC512x clock specs in DT bindings.
+ *
+ * Unfortunately the clock number declaration cannot be an enum but
+ * needs to be a list of #define directives since when referenced from
+ * within DTS files they need to get resolved "at compile time".
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
+#define MPC512x_CLK_SDHC		24
+#define MPC512x_CLK_PCI			25
+#define MPC512x_CLK_PSC_MCLK_IN		26
+#define MPC512x_CLK_SPDIF_TX		27
+#define MPC512x_CLK_SPDIF_RX		28
+#define MPC512x_CLK_SPDIF_MCLK		29
+#define MPC512x_CLK_AC97		30
+#define MPC512x_CLK_PSC0_MCLK		31
+#define MPC512x_CLK_PSC1_MCLK		32
+#define MPC512x_CLK_PSC2_MCLK		33
+#define MPC512x_CLK_PSC3_MCLK		34
+#define MPC512x_CLK_PSC4_MCLK		35
+#define MPC512x_CLK_PSC5_MCLK		36
+#define MPC512x_CLK_PSC6_MCLK		37
+#define MPC512x_CLK_PSC7_MCLK		38
+#define MPC512x_CLK_PSC8_MCLK		39
+#define MPC512x_CLK_PSC9_MCLK		40
+#define MPC512x_CLK_PSC10_MCLK		41
+#define MPC512x_CLK_PSC11_MCLK		42
+#define MPC512x_CLK_PSC_FIFO		43
+
+#define MPC512x_CLK_LAST_PUBLIC		43
+
+#endif
-- 
1.7.10.4
