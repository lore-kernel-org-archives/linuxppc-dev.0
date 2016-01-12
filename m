Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D24901A1803
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 04:48:18 +1100 (AEDT)
From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Anson Huang <b20788@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
 Bai Ping <b51503@freescale.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Frank Li <Frank.Li@freescale.com>, Fugang Duan <B38611@freescale.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Jaroslav Kysela <perex@perex.cz>, Kumar Gala <galak@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 1/2] clk: imx: whitespace cleanup; no functional change
Date: Tue, 12 Jan 2016 18:29:18 +0100
Message-Id: <1452619759-14474-2-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
References: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

remove whitespace before TAB.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
 drivers/clk/imx/clk-imx6ul.c             |  62 ++++++-------
 include/dt-bindings/clock/imx6ul-clock.h | 146 +++++++++++++++----------------
 2 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 08692d7..3e31ec0 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -157,9 +157,9 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(clks[IMX6UL_PLL7_BYPASS], clks[IMX6UL_CLK_PLL7]);
 
 	clks[IMX6UL_CLK_PLL1_SYS]	= imx_clk_fixed_factor("pll1_sys",	"pll1_bypass", 1, 1);
-	clks[IMX6UL_CLK_PLL2_BUS]	= imx_clk_gate("pll2_bus", 	"pll2_bypass", base + 0x30, 13);
-	clks[IMX6UL_CLK_PLL3_USB_OTG]	= imx_clk_gate("pll3_usb_otg", 	"pll3_bypass", base + 0x10, 13);
-	clks[IMX6UL_CLK_PLL4_AUDIO]	= imx_clk_gate("pll4_audio", 	"pll4_bypass", base + 0x70, 13);
+	clks[IMX6UL_CLK_PLL2_BUS]	= imx_clk_gate("pll2_bus",	"pll2_bypass", base + 0x30, 13);
+	clks[IMX6UL_CLK_PLL3_USB_OTG]	= imx_clk_gate("pll3_usb_otg",	"pll3_bypass", base + 0x10, 13);
+	clks[IMX6UL_CLK_PLL4_AUDIO]	= imx_clk_gate("pll4_audio",	"pll4_bypass", base + 0x70, 13);
 	clks[IMX6UL_CLK_PLL5_VIDEO]	= imx_clk_gate("pll5_video",	"pll5_bypass", base + 0xa0, 13);
 	clks[IMX6UL_CLK_PLL6_ENET]	= imx_clk_gate("pll6_enet",	"pll6_bypass", base + 0xe0, 13);
 	clks[IMX6UL_CLK_PLL7_USB_HOST]	= imx_clk_gate("pll7_usb_host",	"pll7_bypass", base + 0x20, 13);
@@ -196,8 +196,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 			base + 0xe0, 2, 2, 0, clk_enet_ref_table, &imx_ccm_lock);
 
 	clks[IMX6UL_CLK_ENET2_REF_125M] = imx_clk_gate("enet_ref_125m", "enet2_ref", base + 0xe0, 20);
-	clks[IMX6UL_CLK_ENET_PTP_REF] 	= imx_clk_fixed_factor("enet_ptp_ref", "pll6_enet", 1, 20);
-	clks[IMX6UL_CLK_ENET_PTP] 	= imx_clk_gate("enet_ptp", "enet_ptp_ref", base + 0xe0, 21);
+	clks[IMX6UL_CLK_ENET_PTP_REF]	= imx_clk_fixed_factor("enet_ptp_ref", "pll6_enet", 1, 20);
+	clks[IMX6UL_CLK_ENET_PTP]	= imx_clk_gate("enet_ptp", "enet_ptp_ref", base + 0xe0, 21);
 
 	clks[IMX6UL_CLK_PLL4_POST_DIV]  = clk_register_divider_table(NULL, "pll4_post_div", "pll4_audio",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x70, 19, 2, 0, post_div_table, &imx_ccm_lock);
@@ -210,8 +210,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 
 	/*						   name		parent_name	 mult  div */
 	clks[IMX6UL_CLK_PLL2_198M] = imx_clk_fixed_factor("pll2_198m", "pll2_pfd2_396m", 1,	2);
-	clks[IMX6UL_CLK_PLL3_80M]  = imx_clk_fixed_factor("pll3_80m",  "pll3_usb_otg",   1, 	6);
-	clks[IMX6UL_CLK_PLL3_60M]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 	8);
+	clks[IMX6UL_CLK_PLL3_80M]  = imx_clk_fixed_factor("pll3_80m",  "pll3_usb_otg",   1,	6);
+	clks[IMX6UL_CLK_PLL3_60M]  = imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1,	8);
 	clks[IMX6UL_CLK_GPT_3M]	   = imx_clk_fixed_factor("gpt_3m",	"osc",		 1,	8);
 
 	np = ccm_node;
@@ -219,34 +219,34 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	WARN_ON(!base);
 
 	clks[IMX6UL_CA7_SECONDARY_SEL]	  = imx_clk_mux("ca7_secondary_sel", base + 0xc, 3, 1, ca7_secondary_sels, ARRAY_SIZE(ca7_secondary_sels));
-	clks[IMX6UL_CLK_STEP] 	 	  = imx_clk_mux("step", base + 0x0c, 8, 1, step_sels, ARRAY_SIZE(step_sels));
-	clks[IMX6UL_CLK_PLL1_SW] 	  = imx_clk_mux_flags("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
+	clks[IMX6UL_CLK_STEP]		  = imx_clk_mux("step", base + 0x0c, 8, 1, step_sels, ARRAY_SIZE(step_sels));
+	clks[IMX6UL_CLK_PLL1_SW]	  = imx_clk_mux_flags("pll1_sw",   base + 0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
 	clks[IMX6UL_CLK_AXI_ALT_SEL]	  = imx_clk_mux("axi_alt_sel",		base + 0x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
-	clks[IMX6UL_CLK_AXI_SEL] 	  = imx_clk_mux_flags("axi_sel", 	base + 0x14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
-	clks[IMX6UL_CLK_PERIPH_PRE] 	  = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
-	clks[IMX6UL_CLK_PERIPH2_PRE] 	  = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
+	clks[IMX6UL_CLK_AXI_SEL]	  = imx_clk_mux_flags("axi_sel",	base + 0x14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
+	clks[IMX6UL_CLK_PERIPH_PRE]	  = imx_clk_mux("periph_pre",       base + 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
+	clks[IMX6UL_CLK_PERIPH2_PRE]	  = imx_clk_mux("periph2_pre",      base + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
 	clks[IMX6UL_CLK_PERIPH_CLK2_SEL]  = imx_clk_mux("periph_clk2_sel",  base + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
 	clks[IMX6UL_CLK_PERIPH2_CLK2_SEL] = imx_clk_mux("periph2_clk2_sel", base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
-	clks[IMX6UL_CLK_EIM_SLOW_SEL] 	  = imx_clk_mux("eim_slow_sel", base + 0x1c, 29, 2, eim_slow_sels, ARRAY_SIZE(eim_slow_sels));
+	clks[IMX6UL_CLK_EIM_SLOW_SEL]	  = imx_clk_mux("eim_slow_sel", base + 0x1c, 29, 2, eim_slow_sels, ARRAY_SIZE(eim_slow_sels));
 	clks[IMX6UL_CLK_GPMI_SEL]	  = imx_clk_mux("gpmi_sel",     base + 0x1c, 19, 1, gpmi_sels, ARRAY_SIZE(gpmi_sels));
-	clks[IMX6UL_CLK_BCH_SEL]      	  = imx_clk_mux("bch_sel", 	base + 0x1c, 18, 1, bch_sels, ARRAY_SIZE(bch_sels));
+	clks[IMX6UL_CLK_BCH_SEL]	  = imx_clk_mux("bch_sel",	base + 0x1c, 18, 1, bch_sels, ARRAY_SIZE(bch_sels));
 	clks[IMX6UL_CLK_USDHC2_SEL]	  = imx_clk_mux("usdhc2_sel",   base + 0x1c, 17, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
 	clks[IMX6UL_CLK_USDHC1_SEL]	  = imx_clk_mux("usdhc1_sel",   base + 0x1c, 16, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
-	clks[IMX6UL_CLK_SAI3_SEL]     	  = imx_clk_mux("sai3_sel",     base + 0x1c, 14, 2, sai_sels, ARRAY_SIZE(sai_sels));
+	clks[IMX6UL_CLK_SAI3_SEL]	  = imx_clk_mux("sai3_sel",     base + 0x1c, 14, 2, sai_sels, ARRAY_SIZE(sai_sels));
 	clks[IMX6UL_CLK_SAI2_SEL]         = imx_clk_mux("sai2_sel",     base + 0x1c, 12, 2, sai_sels, ARRAY_SIZE(sai_sels));
-	clks[IMX6UL_CLK_SAI1_SEL]    	  = imx_clk_mux("sai1_sel",     base + 0x1c, 10, 2, sai_sels, ARRAY_SIZE(sai_sels));
-	clks[IMX6UL_CLK_QSPI1_SEL] 	  = imx_clk_mux("qspi1_sel",    base + 0x1c, 7,  3, qspi1_sels, ARRAY_SIZE(qspi1_sels));
-	clks[IMX6UL_CLK_PERCLK_SEL] 	  = imx_clk_mux("perclk_sel",	base + 0x1c, 6,  1, perclk_sels, ARRAY_SIZE(perclk_sels));
-	clks[IMX6UL_CLK_CAN_SEL]      	  = imx_clk_mux("can_sel",	base + 0x20, 8,  2, can_sels, ARRAY_SIZE(can_sels));
+	clks[IMX6UL_CLK_SAI1_SEL]	  = imx_clk_mux("sai1_sel",     base + 0x1c, 10, 2, sai_sels, ARRAY_SIZE(sai_sels));
+	clks[IMX6UL_CLK_QSPI1_SEL]	  = imx_clk_mux("qspi1_sel",    base + 0x1c, 7,  3, qspi1_sels, ARRAY_SIZE(qspi1_sels));
+	clks[IMX6UL_CLK_PERCLK_SEL]	  = imx_clk_mux("perclk_sel",	base + 0x1c, 6,  1, perclk_sels, ARRAY_SIZE(perclk_sels));
+	clks[IMX6UL_CLK_CAN_SEL]	  = imx_clk_mux("can_sel",	base + 0x20, 8,  2, can_sels, ARRAY_SIZE(can_sels));
 	clks[IMX6UL_CLK_UART_SEL]	  = imx_clk_mux("uart_sel",	base + 0x24, 6,  1, uart_sels, ARRAY_SIZE(uart_sels));
 	clks[IMX6UL_CLK_ENFC_SEL]	  = imx_clk_mux("enfc_sel",	base + 0x2c, 15, 3, enfc_sels, ARRAY_SIZE(enfc_sels));
 	clks[IMX6UL_CLK_LDB_DI0_SEL]	  = imx_clk_mux("ldb_di0_sel",	base + 0x2c, 9,  3, ldb_di0_sels, ARRAY_SIZE(ldb_di0_sels));
 	clks[IMX6UL_CLK_SPDIF_SEL]	  = imx_clk_mux("spdif_sel",	base + 0x30, 20, 2, spdif_sels, ARRAY_SIZE(spdif_sels));
-	clks[IMX6UL_CLK_SIM_PRE_SEL] 	  = imx_clk_mux("sim_pre_sel",	base + 0x34, 15, 3, sim_pre_sels, ARRAY_SIZE(sim_pre_sels));
-	clks[IMX6UL_CLK_SIM_SEL]	  = imx_clk_mux("sim_sel", 	base + 0x34, 9, 3, sim_sels, ARRAY_SIZE(sim_sels));
+	clks[IMX6UL_CLK_SIM_PRE_SEL]	  = imx_clk_mux("sim_pre_sel",	base + 0x34, 15, 3, sim_pre_sels, ARRAY_SIZE(sim_pre_sels));
+	clks[IMX6UL_CLK_SIM_SEL]	  = imx_clk_mux("sim_sel",	base + 0x34, 9, 3, sim_sels, ARRAY_SIZE(sim_sels));
 	clks[IMX6UL_CLK_ECSPI_SEL]	  = imx_clk_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
 	clks[IMX6UL_CLK_LCDIF_PRE_SEL]	  = imx_clk_mux("lcdif_pre_sel", base + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels));
-	clks[IMX6UL_CLK_LCDIF_SEL]	  = imx_clk_mux("lcdif_sel", 	base + 0x38, 9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
+	clks[IMX6UL_CLK_LCDIF_SEL]	  = imx_clk_mux("lcdif_sel",	base + 0x38, 9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
 
 	clks[IMX6UL_CLK_LDB_DI0_DIV_SEL]  = imx_clk_mux("ldb_di0", base + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels));
 	clks[IMX6UL_CLK_LDB_DI1_DIV_SEL]  = imx_clk_mux("ldb_di1", base + 0x20, 11, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels));
@@ -259,11 +259,11 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_PERIPH]  = imx_clk_busy_mux("periph",  base + 0x14, 25, 1, base + 0x48, 5, periph_sels, ARRAY_SIZE(periph_sels));
 	clks[IMX6UL_CLK_PERIPH2] = imx_clk_busy_mux("periph2", base + 0x14, 26, 1, base + 0x48, 3, periph2_sels, ARRAY_SIZE(periph2_sels));
 
-	clks[IMX6UL_CLK_PERIPH_CLK2]	= imx_clk_divider("periph_clk2",   "periph_clk2_sel",  	base + 0x14, 27, 3);
-	clks[IMX6UL_CLK_PERIPH2_CLK2]	= imx_clk_divider("periph2_clk2",  "periph2_clk2_sel", 	base + 0x14, 0,  3);
+	clks[IMX6UL_CLK_PERIPH_CLK2]	= imx_clk_divider("periph_clk2",   "periph_clk2_sel",	base + 0x14, 27, 3);
+	clks[IMX6UL_CLK_PERIPH2_CLK2]	= imx_clk_divider("periph2_clk2",  "periph2_clk2_sel",	base + 0x14, 0,  3);
 	clks[IMX6UL_CLK_IPG]		= imx_clk_divider("ipg",	   "ahb",		base + 0x14, 8,	 2);
 	clks[IMX6UL_CLK_LCDIF_PODF]	= imx_clk_divider("lcdif_podf",	   "lcdif_pred",	base + 0x18, 23, 3);
-	clks[IMX6UL_CLK_QSPI1_PDOF] 	= imx_clk_divider("qspi1_podf",	   "qspi1_sel",		base + 0x1c, 26, 3);
+	clks[IMX6UL_CLK_QSPI1_PDOF]	= imx_clk_divider("qspi1_podf",	   "qspi1_sel",		base + 0x1c, 26, 3);
 	clks[IMX6UL_CLK_EIM_SLOW_PODF]	= imx_clk_divider("eim_slow_podf", "eim_slow_sel",	base + 0x1c, 23, 3);
 	clks[IMX6UL_CLK_PERCLK]		= imx_clk_divider("perclk",	   "perclk_sel",	base + 0x1c, 0,  6);
 	clks[IMX6UL_CLK_CAN_PODF]	= imx_clk_divider("can_podf",	   "can_sel",		base + 0x20, 2,  6);
@@ -287,14 +287,14 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_LCDIF_PRED]	= imx_clk_divider("lcdif_pred",	   "lcdif_pre_sel",	base + 0x38, 12, 3);
 	clks[IMX6UL_CLK_CSI_PODF]       = imx_clk_divider("csi_podf",      "csi_sel",           base + 0x3c, 11, 3);
 
-	clks[IMX6UL_CLK_ARM]		= imx_clk_busy_divider("arm", 	    "pll1_sw",	base +	0x10, 0,  3,  base + 0x48, 16);
+	clks[IMX6UL_CLK_ARM]		= imx_clk_busy_divider("arm",	    "pll1_sw",	base +	0x10, 0,  3,  base + 0x48, 16);
 	clks[IMX6UL_CLK_MMDC_PODF]	= imx_clk_busy_divider("mmdc_podf", "periph2",	base +  0x14, 3,  3,  base + 0x48, 2);
 	clks[IMX6UL_CLK_AXI_PODF]	= imx_clk_busy_divider("axi_podf",  "axi_sel",	base +  0x14, 16, 3,  base + 0x48, 0);
 	clks[IMX6UL_CLK_AHB]		= imx_clk_busy_divider("ahb",	    "periph",	base +  0x14, 10, 3,  base + 0x48, 1);
 
 	/* CCGR0 */
-	clks[IMX6UL_CLK_AIPSTZ1]	= imx_clk_gate2("aips_tz1", 	"ahb",		base + 0x68,	0);
-	clks[IMX6UL_CLK_AIPSTZ2]	= imx_clk_gate2("aips_tz2", 	"ahb",		base + 0x68,	2);
+	clks[IMX6UL_CLK_AIPSTZ1]	= imx_clk_gate2("aips_tz1",	"ahb",		base + 0x68,	0);
+	clks[IMX6UL_CLK_AIPSTZ2]	= imx_clk_gate2("aips_tz2",	"ahb",		base + 0x68,	2);
 	clks[IMX6UL_CLK_APBHDMA]	= imx_clk_gate2("apbh_dma",	"bch_podf",	base + 0x68,	4);
 	clks[IMX6UL_CLK_ASRC_IPG]	= imx_clk_gate2_shared("asrc_ipg",	"ahb",	base + 0x68,	6, &share_count_asrc);
 	clks[IMX6UL_CLK_ASRC_MEM]	= imx_clk_gate2_shared("asrc_mem",	"ahb",	base + 0x68,	6, &share_count_asrc);
@@ -302,7 +302,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_CAAM_ACLK]	= imx_clk_gate2("caam_aclk",	"ahb",		base + 0x68,	10);
 	clks[IMX6UL_CLK_CAAM_IPG]	= imx_clk_gate2("caam_ipg",	"ipg",		base + 0x68,	12);
 	clks[IMX6UL_CLK_CAN1_IPG]	= imx_clk_gate2("can1_ipg",	"ipg",		base + 0x68,	14);
-	clks[IMX6UL_CLK_CAN1_SERIAL]	= imx_clk_gate2("can1_serial",	"can_podf",	base + 0x68, 	16);
+	clks[IMX6UL_CLK_CAN1_SERIAL]	= imx_clk_gate2("can1_serial",	"can_podf",	base + 0x68,	16);
 	clks[IMX6UL_CLK_CAN2_IPG]	= imx_clk_gate2("can2_ipg",	"ipg",		base + 0x68,	18);
 	clks[IMX6UL_CLK_CAN2_SERIAL]	= imx_clk_gate2("can2_serial",	"can_podf",	base + 0x68,	20);
 	clks[IMX6UL_CLK_GPT2_BUS]	= imx_clk_gate2("gpt_bus",	"perclk",	base + 0x68,	24);
@@ -331,7 +331,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_CSI]		= imx_clk_gate2("csi",		"csi_podf",		base + 0x70,	2);
 	clks[IMX6UL_CLK_I2C1]		= imx_clk_gate2("i2c1",		"perclk",	base + 0x70,	6);
 	clks[IMX6UL_CLK_I2C2]		= imx_clk_gate2("i2c2",		"perclk",	base + 0x70,	8);
-	clks[IMX6UL_CLK_I2C3] 		= imx_clk_gate2("i2c3",		"perclk",	base + 0x70,	10);
+	clks[IMX6UL_CLK_I2C3]		= imx_clk_gate2("i2c3",		"perclk",	base + 0x70,	10);
 	clks[IMX6UL_CLK_OCOTP]		= imx_clk_gate2("ocotp",	"ipg",		base + 0x70,	12);
 	clks[IMX6UL_CLK_IOMUXC]		= imx_clk_gate2("iomuxc",	"lcdif_podf",	base + 0x70,	14);
 	clks[IMX6UL_CLK_LCDIF_APB]	= imx_clk_gate2("lcdif_apb",	"axi",		base + 0x70,	28);
@@ -391,7 +391,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_UART8_IPG]	= imx_clk_gate2("uart8_ipg",	"ipg",		 base + 0x80,	14);
 	clks[IMX6UL_CLK_UART8_SERIAL]	= imx_clk_gate2("uart8_serial", "uart_podf",	 base + 0x80,	14);
 	clks[IMX6UL_CLK_WDOG3]		= imx_clk_gate2("wdog3",	"ipg",		 base + 0x80,	20);
-	clks[IMX6UL_CLK_I2C4]		= imx_clk_gate2("i2c4",		"perclk", 	 base + 0x80,	24);
+	clks[IMX6UL_CLK_I2C4]		= imx_clk_gate2("i2c4",		"perclk",	 base + 0x80,	24);
 	clks[IMX6UL_CLK_PWM5]		= imx_clk_gate2("pwm5",		"perclk",	 base + 0x80,	26);
 	clks[IMX6UL_CLK_PWM6]		= imx_clk_gate2("pwm6",		"perclk",	 base +	0x80,	28);
 	clks[IMX6UL_CLK_PWM7]		= imx_clk_gate2("Pwm7",		"perclk",	 base + 0x80,	30);
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index c343894..08ce4a7 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -21,13 +21,13 @@
 #define IMX6UL_PLL5_BYPASS_SRC		8
 #define IMX6UL_PLL6_BYPASS_SRC		9
 #define IMX6UL_PLL7_BYPASS_SRC		10
-#define IMX6UL_CLK_PLL1 		11
-#define IMX6UL_CLK_PLL2 		12
-#define IMX6UL_CLK_PLL3 		13
-#define IMX6UL_CLK_PLL4 		14
-#define IMX6UL_CLK_PLL5 		15
-#define IMX6UL_CLK_PLL6 		16
-#define IMX6UL_CLK_PLL7 		17
+#define IMX6UL_CLK_PLL1			11
+#define IMX6UL_CLK_PLL2			12
+#define IMX6UL_CLK_PLL3			13
+#define IMX6UL_CLK_PLL4			14
+#define IMX6UL_CLK_PLL5			15
+#define IMX6UL_CLK_PLL6			16
+#define IMX6UL_CLK_PLL7			17
 #define IMX6UL_PLL1_BYPASS		18
 #define IMX6UL_PLL2_BYPASS		19
 #define IMX6UL_PLL3_BYPASS		20
@@ -37,7 +37,7 @@
 #define IMX6UL_PLL7_BYPASS		24
 #define IMX6UL_CLK_PLL1_SYS		25
 #define IMX6UL_CLK_PLL2_BUS		26
-#define IMX6UL_CLK_PLL3_USB_OTG 	27
+#define IMX6UL_CLK_PLL3_USB_OTG		27
 #define IMX6UL_CLK_PLL4_AUDIO		28
 #define IMX6UL_CLK_PLL5_VIDEO		29
 #define IMX6UL_CLK_PLL6_ENET		30
@@ -66,7 +66,7 @@
 #define IMX6UL_CLK_PLL2_198M		53
 #define IMX6UL_CLK_PLL3_80M		54
 #define IMX6UL_CLK_PLL3_60M		55
-#define IMX6UL_CLK_STEP 		56
+#define IMX6UL_CLK_STEP			56
 #define IMX6UL_CLK_PLL1_SW		57
 #define IMX6UL_CLK_AXI_ALT_SEL		58
 #define IMX6UL_CLK_AXI_SEL		59
@@ -78,7 +78,7 @@
 #define IMX6UL_CLK_USDHC2_SEL		65
 #define IMX6UL_CLK_BCH_SEL		66
 #define IMX6UL_CLK_GPMI_SEL		67
-#define IMX6UL_CLK_EIM_SLOW_SEL 	68
+#define IMX6UL_CLK_EIM_SLOW_SEL		68
 #define IMX6UL_CLK_SPDIF_SEL		69
 #define IMX6UL_CLK_SAI1_SEL		70
 #define IMX6UL_CLK_SAI2_SEL		71
@@ -105,9 +105,9 @@
 #define IMX6UL_CLK_LDB_DI1_DIV_SEL	92
 #define IMX6UL_CLK_ARM			93
 #define IMX6UL_CLK_PERIPH_CLK2		94
-#define IMX6UL_CLK_PERIPH2_CLK2 	95
+#define IMX6UL_CLK_PERIPH2_CLK2		95
 #define IMX6UL_CLK_AHB			96
-#define IMX6UL_CLK_MMDC_PODF 		97
+#define IMX6UL_CLK_MMDC_PODF		97
 #define IMX6UL_CLK_AXI_PODF		98
 #define IMX6UL_CLK_PERCLK		99
 #define IMX6UL_CLK_IPG			100
@@ -133,16 +133,16 @@
 #define IMX6UL_CLK_CAN_PODF		120
 #define IMX6UL_CLK_ECSPI_PODF		121
 #define IMX6UL_CLK_UART_PODF		122
-#define IMX6UL_CLK_ADC1 		123
-#define IMX6UL_CLK_ADC2 		124
+#define IMX6UL_CLK_ADC1			123
+#define IMX6UL_CLK_ADC2			124
 #define IMX6UL_CLK_AIPSTZ1		125
 #define IMX6UL_CLK_AIPSTZ2		126
 #define IMX6UL_CLK_AIPSTZ3		127
 #define IMX6UL_CLK_APBHDMA		128
 #define IMX6UL_CLK_ASRC_IPG		129
 #define IMX6UL_CLK_ASRC_MEM		130
-#define IMX6UL_CLK_GPMI_BCH_APB  	131
-#define IMX6UL_CLK_GPMI_BCH 		132
+#define IMX6UL_CLK_GPMI_BCH_APB		131
+#define IMX6UL_CLK_GPMI_BCH		132
 #define IMX6UL_CLK_GPMI_IO		133
 #define IMX6UL_CLK_GPMI_APB		134
 #define IMX6UL_CLK_CAAM_MEM		135
@@ -154,7 +154,7 @@
 #define IMX6UL_CLK_ECSPI3		141
 #define IMX6UL_CLK_ECSPI4		142
 #define IMX6UL_CLK_EIM			143
-#define IMX6UL_CLK_ENET  		144
+#define IMX6UL_CLK_ENET			144
 #define IMX6UL_CLK_ENET_AHB		145
 #define IMX6UL_CLK_EPIT1		146
 #define IMX6UL_CLK_EPIT2		147
@@ -166,63 +166,63 @@
 #define IMX6UL_CLK_GPT1_SERIAL		153
 #define IMX6UL_CLK_GPT2_BUS		154
 #define IMX6UL_CLK_GPT2_SERIAL		155
-#define IMX6UL_CLK_I2C1 		156
-#define IMX6UL_CLK_I2C2 		157
-#define IMX6UL_CLK_I2C3 		158
-#define IMX6UL_CLK_I2C4 		159
-#define IMX6UL_CLK_IOMUXC 		160
-#define IMX6UL_CLK_LCDIF_APB 		161
-#define IMX6UL_CLK_LCDIF_PIX 		162
-#define IMX6UL_CLK_MMDC_P0_FAST 	163
-#define IMX6UL_CLK_MMDC_P0_IPG  	164
-#define IMX6UL_CLK_OCOTP 		165
-#define IMX6UL_CLK_OCRAM 		166
-#define IMX6UL_CLK_PWM1 		167
-#define IMX6UL_CLK_PWM2 		168
-#define IMX6UL_CLK_PWM3 		169
-#define IMX6UL_CLK_PWM4 		170
-#define IMX6UL_CLK_PWM5 		171
-#define IMX6UL_CLK_PWM6 		172
-#define IMX6UL_CLK_PWM7 		173
-#define IMX6UL_CLK_PWM8 		174
-#define IMX6UL_CLK_PXP  		175
-#define IMX6UL_CLK_QSPI 		176
-#define IMX6UL_CLK_ROM  		177
-#define IMX6UL_CLK_SAI1 		178
-#define IMX6UL_CLK_SAI1_IPG 		179
-#define IMX6UL_CLK_SAI2 		180
-#define IMX6UL_CLK_SAI2_IPG 		181
-#define IMX6UL_CLK_SAI3 		182
-#define IMX6UL_CLK_SAI3_IPG 		183
-#define IMX6UL_CLK_SDMA 		184
-#define IMX6UL_CLK_SIM  		185
-#define IMX6UL_CLK_SIM_S 		186
-#define IMX6UL_CLK_SPBA 		187
-#define IMX6UL_CLK_SPDIF 		188
-#define IMX6UL_CLK_UART1_IPG 		189
-#define IMX6UL_CLK_UART1_SERIAL 	190
-#define IMX6UL_CLK_UART2_IPG 		191
-#define IMX6UL_CLK_UART2_SERIAL 	192
-#define IMX6UL_CLK_UART3_IPG 		193
-#define IMX6UL_CLK_UART3_SERIAL 	194
-#define IMX6UL_CLK_UART4_IPG 		195
-#define IMX6UL_CLK_UART4_SERIAL 	196
-#define IMX6UL_CLK_UART5_IPG 		197
-#define IMX6UL_CLK_UART5_SERIAL 	198
-#define IMX6UL_CLK_UART6_IPG 		199
-#define IMX6UL_CLK_UART6_SERIAL 	200
-#define IMX6UL_CLK_UART7_IPG 		201
-#define IMX6UL_CLK_UART7_SERIAL 	202
-#define IMX6UL_CLK_UART8_IPG 		203
-#define IMX6UL_CLK_UART8_SERIAL 	204
-#define IMX6UL_CLK_USBOH3 		205
-#define IMX6UL_CLK_USDHC1 		206
-#define IMX6UL_CLK_USDHC2 		207
-#define IMX6UL_CLK_WDOG1 		208
-#define IMX6UL_CLK_WDOG2 		209
-#define IMX6UL_CLK_WDOG3 		210
+#define IMX6UL_CLK_I2C1			156
+#define IMX6UL_CLK_I2C2			157
+#define IMX6UL_CLK_I2C3			158
+#define IMX6UL_CLK_I2C4			159
+#define IMX6UL_CLK_IOMUXC		160
+#define IMX6UL_CLK_LCDIF_APB		161
+#define IMX6UL_CLK_LCDIF_PIX		162
+#define IMX6UL_CLK_MMDC_P0_FAST		163
+#define IMX6UL_CLK_MMDC_P0_IPG		164
+#define IMX6UL_CLK_OCOTP		165
+#define IMX6UL_CLK_OCRAM		166
+#define IMX6UL_CLK_PWM1			167
+#define IMX6UL_CLK_PWM2			168
+#define IMX6UL_CLK_PWM3			169
+#define IMX6UL_CLK_PWM4			170
+#define IMX6UL_CLK_PWM5			171
+#define IMX6UL_CLK_PWM6			172
+#define IMX6UL_CLK_PWM7			173
+#define IMX6UL_CLK_PWM8			174
+#define IMX6UL_CLK_PXP			175
+#define IMX6UL_CLK_QSPI			176
+#define IMX6UL_CLK_ROM			177
+#define IMX6UL_CLK_SAI1			178
+#define IMX6UL_CLK_SAI1_IPG		179
+#define IMX6UL_CLK_SAI2			180
+#define IMX6UL_CLK_SAI2_IPG		181
+#define IMX6UL_CLK_SAI3			182
+#define IMX6UL_CLK_SAI3_IPG		183
+#define IMX6UL_CLK_SDMA			184
+#define IMX6UL_CLK_SIM			185
+#define IMX6UL_CLK_SIM_S		186
+#define IMX6UL_CLK_SPBA			187
+#define IMX6UL_CLK_SPDIF		188
+#define IMX6UL_CLK_UART1_IPG		189
+#define IMX6UL_CLK_UART1_SERIAL		190
+#define IMX6UL_CLK_UART2_IPG		191
+#define IMX6UL_CLK_UART2_SERIAL		192
+#define IMX6UL_CLK_UART3_IPG		193
+#define IMX6UL_CLK_UART3_SERIAL		194
+#define IMX6UL_CLK_UART4_IPG		195
+#define IMX6UL_CLK_UART4_SERIAL		196
+#define IMX6UL_CLK_UART5_IPG		197
+#define IMX6UL_CLK_UART5_SERIAL		198
+#define IMX6UL_CLK_UART6_IPG		199
+#define IMX6UL_CLK_UART6_SERIAL		200
+#define IMX6UL_CLK_UART7_IPG		201
+#define IMX6UL_CLK_UART7_SERIAL		202
+#define IMX6UL_CLK_UART8_IPG		203
+#define IMX6UL_CLK_UART8_SERIAL		204
+#define IMX6UL_CLK_USBOH3		205
+#define IMX6UL_CLK_USDHC1		206
+#define IMX6UL_CLK_USDHC2		207
+#define IMX6UL_CLK_WDOG1		208
+#define IMX6UL_CLK_WDOG2		209
+#define IMX6UL_CLK_WDOG3		210
 #define IMX6UL_CLK_LDB_DI0		211
-#define IMX6UL_CLK_AXI  		212
+#define IMX6UL_CLK_AXI			212
 #define IMX6UL_CLK_SPDIF_GCLK		213
 #define IMX6UL_CLK_GPT_3M		214
 #define IMX6UL_CLK_SIM2			215
-- 
2.1.4
