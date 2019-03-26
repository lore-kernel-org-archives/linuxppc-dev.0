Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E24C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 14:46:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9193E2075E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 14:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tpUCojfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9193E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TDV344yXzDqP4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 01:46:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="tpUCojfA"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TDPr1Q7tzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 01:42:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=kdonwSPMkJngR+jQ5QiyeXR3LHkn2h4fb+FNyMIqOdk=; b=tpUCojfATtwt
 jYjKTZoBEFHr6lM15Ia+c6xAii8Oacdcsa4iWTBEFtBLhKiMqy8AAswdXyvatu+BfCM+kWKJLgTDJ
 jIFPp+5JNA8ySrXcEWLwer8qqTqoc/JKOUskohzuI7/exSYfAuYMHmtFLxJtrKAiasXtHkCN4z31+
 a3O5U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1h8nHq-0007iP-T8; Tue, 26 Mar 2019 14:42:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 5CDE71121B57; Tue, 26 Mar 2019 14:42:46 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Applied "ASoC: fsl: Add Audio Mixer CPU DAI driver" to the asoc tree
In-Reply-To: <1548155654-12985-2-git-send-email-viorel.suman@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190326144246.5CDE71121B57@debutante.sirena.org.uk>
Date: Tue, 26 Mar 2019 14:42:46 +0000 (GMT)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: fsl: Add Audio Mixer CPU DAI driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From be1df61cf06efb355c90702e46b8d46f055acb4e Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Tue, 22 Jan 2019 11:14:26 +0000
Subject: [PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver

This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
The Audio Mixer is a on-chip functional module that allows mixing of
two audio streams into a single audio stream.

Audio Mixer datasheet is available here:
https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/Kconfig      |   7 +
 sound/soc/fsl/Makefile     |   3 +
 sound/soc/fsl/fsl_audmix.c | 576 +++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_audmix.h | 102 +++++++
 4 files changed, 688 insertions(+)
 create mode 100644 sound/soc/fsl/fsl_audmix.c
 create mode 100644 sound/soc/fsl/fsl_audmix.h

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 7b1d9970be8b..0af2e056d211 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -24,6 +24,13 @@ config SND_SOC_FSL_SAI
 	  This option is only useful for out-of-tree drivers since
 	  in-tree drivers select it automatically.
 
+config SND_SOC_FSL_AUDMIX
+	tristate "Audio Mixer (AUDMIX) module support"
+	select REGMAP_MMIO
+	help
+	  Say Y if you want to add Audio Mixer (AUDMIX)
+	  support for the NXP iMX CPUs.
+
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module (SSI) support"
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 3c0ff315b971..4172d5a3e36c 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -12,6 +12,7 @@ snd-soc-p1022-rdk-objs := p1022_rdk.o
 obj-$(CONFIG_SND_SOC_P1022_RDK) += snd-soc-p1022-rdk.o
 
 # Freescale SSI/DMA/SAI/SPDIF Support
+snd-soc-fsl-audmix-objs := fsl_audmix.o
 snd-soc-fsl-asoc-card-objs := fsl-asoc-card.o
 snd-soc-fsl-asrc-objs := fsl_asrc.o fsl_asrc_dma.o
 snd-soc-fsl-sai-objs := fsl_sai.o
@@ -22,6 +23,8 @@ snd-soc-fsl-esai-objs := fsl_esai.o
 snd-soc-fsl-micfil-objs := fsl_micfil.o
 snd-soc-fsl-utils-objs := fsl_utils.o
 snd-soc-fsl-dma-objs := fsl_dma.o
+
+obj-$(CONFIG_SND_SOC_FSL_AUDMIX) += snd-soc-fsl-audmix.o
 obj-$(CONFIG_SND_SOC_FSL_ASOC_CARD) += snd-soc-fsl-asoc-card.o
 obj-$(CONFIG_SND_SOC_FSL_ASRC) += snd-soc-fsl-asrc.o
 obj-$(CONFIG_SND_SOC_FSL_SAI) += snd-soc-fsl-sai.o
diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
new file mode 100644
index 000000000000..3356cb617713
--- /dev/null
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP AUDMIX ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ * Copyright 2017 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include "fsl_audmix.h"
+
+#define SOC_ENUM_SINGLE_S(xreg, xshift, xtexts) \
+	SOC_ENUM_SINGLE(xreg, xshift, ARRAY_SIZE(xtexts), xtexts)
+
+static const char
+	*tdm_sel[] = { "TDM1", "TDM2", },
+	*mode_sel[] = { "Disabled", "TDM1", "TDM2", "Mixed", },
+	*width_sel[] = { "16b", "18b", "20b", "24b", "32b", },
+	*endis_sel[] = { "Disabled", "Enabled", },
+	*updn_sel[] = { "Downward", "Upward", },
+	*mask_sel[] = { "Unmask", "Mask", };
+
+static const struct soc_enum fsl_audmix_enum[] = {
+/* FSL_AUDMIX_CTR enums */
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_MIXCLK_SHIFT, tdm_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_OUTSRC_SHIFT, mode_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_OUTWIDTH_SHIFT, width_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_MASKRTDF_SHIFT, mask_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_MASKCKDF_SHIFT, mask_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_SYNCMODE_SHIFT, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_CTR, FSL_AUDMIX_CTR_SYNCSRC_SHIFT, tdm_sel),
+/* FSL_AUDMIX_ATCR0 enums */
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR0, 0, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR0, 1, updn_sel),
+/* FSL_AUDMIX_ATCR1 enums */
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR1, 0, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AUDMIX_ATCR1, 1, updn_sel),
+};
+
+struct fsl_audmix_state {
+	u8 tdms;
+	u8 clk;
+	char msg[64];
+};
+
+static const struct fsl_audmix_state prms[4][4] = {{
+	/* DIS->DIS, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" },
+	/* DIS->TDM1*/
+	{ .tdms = 1, .clk = 1, .msg = "DIS->TDM1: TDM1 not started!\n" },
+	/* DIS->TDM2*/
+	{ .tdms = 2, .clk = 2, .msg = "DIS->TDM2: TDM2 not started!\n" },
+	/* DIS->MIX */
+	{ .tdms = 3, .clk = 0, .msg = "DIS->MIX: Please start both TDMs!\n" }
+}, {	/* TDM1->DIS */
+	{ .tdms = 1, .clk = 0, .msg = "TDM1->DIS: TDM1 not started!\n" },
+	/* TDM1->TDM1, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" },
+	/* TDM1->TDM2 */
+	{ .tdms = 3, .clk = 2, .msg = "TDM1->TDM2: Please start both TDMs!\n" },
+	/* TDM1->MIX */
+	{ .tdms = 3, .clk = 0, .msg = "TDM1->MIX: Please start both TDMs!\n" }
+}, {	/* TDM2->DIS */
+	{ .tdms = 2, .clk = 0, .msg = "TDM2->DIS: TDM2 not started!\n" },
+	/* TDM2->TDM1 */
+	{ .tdms = 3, .clk = 1, .msg = "TDM2->TDM1: Please start both TDMs!\n" },
+	/* TDM2->TDM2, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" },
+	/* TDM2->MIX */
+	{ .tdms = 3, .clk = 0, .msg = "TDM2->MIX: Please start both TDMs!\n" }
+}, {	/* MIX->DIS */
+	{ .tdms = 3, .clk = 0, .msg = "MIX->DIS: Please start both TDMs!\n" },
+	/* MIX->TDM1 */
+	{ .tdms = 3, .clk = 1, .msg = "MIX->TDM1: Please start both TDMs!\n" },
+	/* MIX->TDM2 */
+	{ .tdms = 3, .clk = 2, .msg = "MIX->TDM2: Please start both TDMs!\n" },
+	/* MIX->MIX, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" }
+}, };
+
+static int fsl_audmix_state_trans(struct snd_soc_component *comp,
+				  unsigned int *mask, unsigned int *ctr,
+				  const struct fsl_audmix_state prm)
+{
+	struct fsl_audmix *priv = snd_soc_component_get_drvdata(comp);
+	/* Enforce all required TDMs are started */
+	if ((priv->tdms & prm.tdms) != prm.tdms) {
+		dev_dbg(comp->dev, prm.msg);
+		return -EINVAL;
+	}
+
+	switch (prm.clk) {
+	case 1:
+	case 2:
+		/* Set mix clock */
+		(*mask) |= FSL_AUDMIX_CTR_MIXCLK_MASK;
+		(*ctr)  |= FSL_AUDMIX_CTR_MIXCLK(prm.clk - 1);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int fsl_audmix_put_mix_clk_src(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct fsl_audmix *priv = snd_soc_component_get_drvdata(comp);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	unsigned int reg_val, val, mix_clk;
+	int ret = 0;
+
+	/* Get current state */
+	ret = snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
+	if (ret)
+		return ret;
+
+	mix_clk = ((reg_val & FSL_AUDMIX_CTR_MIXCLK_MASK)
+			>> FSL_AUDMIX_CTR_MIXCLK_SHIFT);
+	val = snd_soc_enum_item_to_val(e, item[0]);
+
+	dev_dbg(comp->dev, "TDMs=x%08x, val=x%08x\n", priv->tdms, val);
+
+	/**
+	 * Ensure the current selected mixer clock is available
+	 * for configuration propagation
+	 */
+	if (!(priv->tdms & BIT(mix_clk))) {
+		dev_err(comp->dev,
+			"Started TDM%d needed for config propagation!\n",
+			mix_clk + 1);
+		return -EINVAL;
+	}
+
+	if (!(priv->tdms & BIT(val))) {
+		dev_err(comp->dev,
+			"The selected clock source has no TDM%d enabled!\n",
+			val + 1);
+		return -EINVAL;
+	}
+
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
+}
+
+static int fsl_audmix_put_out_src(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct fsl_audmix *priv = snd_soc_component_get_drvdata(comp);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	u32 out_src, mix_clk;
+	unsigned int reg_val, val, mask = 0, ctr = 0;
+	int ret = 0;
+
+	/* Get current state */
+	ret = snd_soc_component_read(comp, FSL_AUDMIX_CTR, &reg_val);
+	if (ret)
+		return ret;
+
+	/* "From" state */
+	out_src = ((reg_val & FSL_AUDMIX_CTR_OUTSRC_MASK)
+			>> FSL_AUDMIX_CTR_OUTSRC_SHIFT);
+	mix_clk = ((reg_val & FSL_AUDMIX_CTR_MIXCLK_MASK)
+			>> FSL_AUDMIX_CTR_MIXCLK_SHIFT);
+
+	/* "To" state */
+	val = snd_soc_enum_item_to_val(e, item[0]);
+
+	dev_dbg(comp->dev, "TDMs=x%08x, val=x%08x\n", priv->tdms, val);
+
+	/* Check if state is changing ... */
+	if (out_src == val)
+		return 0;
+	/**
+	 * Ensure the current selected mixer clock is available
+	 * for configuration propagation
+	 */
+	if (!(priv->tdms & BIT(mix_clk))) {
+		dev_err(comp->dev,
+			"Started TDM%d needed for config propagation!\n",
+			mix_clk + 1);
+		return -EINVAL;
+	}
+
+	/* Check state transition constraints */
+	ret = fsl_audmix_state_trans(comp, &mask, &ctr, prms[out_src][val]);
+	if (ret)
+		return ret;
+
+	/* Complete transition to new state */
+	mask |= FSL_AUDMIX_CTR_OUTSRC_MASK;
+	ctr  |= FSL_AUDMIX_CTR_OUTSRC(val);
+
+	return snd_soc_component_update_bits(comp, FSL_AUDMIX_CTR, mask, ctr);
+}
+
+static const struct snd_kcontrol_new fsl_audmix_snd_controls[] = {
+	/* FSL_AUDMIX_CTR controls */
+	SOC_ENUM_EXT("Mixing Clock Source", fsl_audmix_enum[0],
+		     snd_soc_get_enum_double, fsl_audmix_put_mix_clk_src),
+	SOC_ENUM_EXT("Output Source", fsl_audmix_enum[1],
+		     snd_soc_get_enum_double, fsl_audmix_put_out_src),
+	SOC_ENUM("Output Width", fsl_audmix_enum[2]),
+	SOC_ENUM("Frame Rate Diff Error", fsl_audmix_enum[3]),
+	SOC_ENUM("Clock Freq Diff Error", fsl_audmix_enum[4]),
+	SOC_ENUM("Sync Mode Config", fsl_audmix_enum[5]),
+	SOC_ENUM("Sync Mode Clk Source", fsl_audmix_enum[6]),
+	/* TDM1 Attenuation controls */
+	SOC_ENUM("TDM1 Attenuation", fsl_audmix_enum[7]),
+	SOC_ENUM("TDM1 Attenuation Direction", fsl_audmix_enum[8]),
+	SOC_SINGLE("TDM1 Attenuation Step Divider", FSL_AUDMIX_ATCR0,
+		   2, 0x00fff, 0),
+	SOC_SINGLE("TDM1 Attenuation Initial Value", FSL_AUDMIX_ATIVAL0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Up Factor", FSL_AUDMIX_ATSTPUP0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Down Factor", FSL_AUDMIX_ATSTPDN0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Target", FSL_AUDMIX_ATSTPTGT0,
+		   0, 0x3ffff, 0),
+	/* TDM2 Attenuation controls */
+	SOC_ENUM("TDM2 Attenuation", fsl_audmix_enum[9]),
+	SOC_ENUM("TDM2 Attenuation Direction", fsl_audmix_enum[10]),
+	SOC_SINGLE("TDM2 Attenuation Step Divider", FSL_AUDMIX_ATCR1,
+		   2, 0x00fff, 0),
+	SOC_SINGLE("TDM2 Attenuation Initial Value", FSL_AUDMIX_ATIVAL1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Up Factor", FSL_AUDMIX_ATSTPUP1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Down Factor", FSL_AUDMIX_ATSTPDN1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Target", FSL_AUDMIX_ATSTPTGT1,
+		   0, 0x3ffff, 0),
+};
+
+static int fsl_audmix_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *comp = dai->component;
+	u32 mask = 0, ctr = 0;
+
+	/* AUDMIX is working in DSP_A format only */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* For playback the AUDMIX is slave, and for record is master */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Output data will be written on positive edge of the clock */
+		ctr |= FSL_AUDMIX_CTR_OUTCKPOL(0);
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* Output data will be written on negative edge of the clock */
+		ctr |= FSL_AUDMIX_CTR_OUTCKPOL(1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mask |= FSL_AUDMIX_CTR_OUTCKPOL_MASK;
+
+	return snd_soc_component_update_bits(comp, FSL_AUDMIX_CTR, mask, ctr);
+}
+
+static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+				  struct snd_soc_dai *dai)
+{
+	struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
+
+	/* Capture stream shall not be handled */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		priv->tdms |= BIT(dai->driver->id);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->tdms &= ~BIT(dai->driver->id);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops fsl_audmix_dai_ops = {
+	.set_fmt      = fsl_audmix_dai_set_fmt,
+	.trigger      = fsl_audmix_dai_trigger,
+};
+
+static struct snd_soc_dai_driver fsl_audmix_dai[] = {
+	{
+		.id   = 0,
+		.name = "audmix-0",
+		.playback = {
+			.stream_name = "AUDMIX-Playback-0",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AUDMIX_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AUDMIX-Capture-0",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AUDMIX_FORMATS,
+		},
+		.ops = &fsl_audmix_dai_ops,
+	},
+	{
+		.id   = 1,
+		.name = "audmix-1",
+		.playback = {
+			.stream_name = "AUDMIX-Playback-1",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AUDMIX_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AUDMIX-Capture-1",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AUDMIX_FORMATS,
+		},
+		.ops = &fsl_audmix_dai_ops,
+	},
+};
+
+static const struct snd_soc_component_driver fsl_audmix_component = {
+	.name		  = "fsl-audmix-dai",
+	.controls	  = fsl_audmix_snd_controls,
+	.num_controls	  = ARRAY_SIZE(fsl_audmix_snd_controls),
+};
+
+static bool fsl_audmix_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FSL_AUDMIX_CTR:
+	case FSL_AUDMIX_STR:
+	case FSL_AUDMIX_ATCR0:
+	case FSL_AUDMIX_ATIVAL0:
+	case FSL_AUDMIX_ATSTPUP0:
+	case FSL_AUDMIX_ATSTPDN0:
+	case FSL_AUDMIX_ATSTPTGT0:
+	case FSL_AUDMIX_ATTNVAL0:
+	case FSL_AUDMIX_ATSTP0:
+	case FSL_AUDMIX_ATCR1:
+	case FSL_AUDMIX_ATIVAL1:
+	case FSL_AUDMIX_ATSTPUP1:
+	case FSL_AUDMIX_ATSTPDN1:
+	case FSL_AUDMIX_ATSTPTGT1:
+	case FSL_AUDMIX_ATTNVAL1:
+	case FSL_AUDMIX_ATSTP1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fsl_audmix_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FSL_AUDMIX_CTR:
+	case FSL_AUDMIX_ATCR0:
+	case FSL_AUDMIX_ATIVAL0:
+	case FSL_AUDMIX_ATSTPUP0:
+	case FSL_AUDMIX_ATSTPDN0:
+	case FSL_AUDMIX_ATSTPTGT0:
+	case FSL_AUDMIX_ATCR1:
+	case FSL_AUDMIX_ATIVAL1:
+	case FSL_AUDMIX_ATSTPUP1:
+	case FSL_AUDMIX_ATSTPDN1:
+	case FSL_AUDMIX_ATSTPTGT1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct reg_default fsl_audmix_reg[] = {
+	{ FSL_AUDMIX_CTR,       0x00060 },
+	{ FSL_AUDMIX_STR,       0x00003 },
+	{ FSL_AUDMIX_ATCR0,     0x00000 },
+	{ FSL_AUDMIX_ATIVAL0,   0x3FFFF },
+	{ FSL_AUDMIX_ATSTPUP0,  0x2AAAA },
+	{ FSL_AUDMIX_ATSTPDN0,  0x30000 },
+	{ FSL_AUDMIX_ATSTPTGT0, 0x00010 },
+	{ FSL_AUDMIX_ATTNVAL0,  0x00000 },
+	{ FSL_AUDMIX_ATSTP0,    0x00000 },
+	{ FSL_AUDMIX_ATCR1,     0x00000 },
+	{ FSL_AUDMIX_ATIVAL1,   0x3FFFF },
+	{ FSL_AUDMIX_ATSTPUP1,  0x2AAAA },
+	{ FSL_AUDMIX_ATSTPDN1,  0x30000 },
+	{ FSL_AUDMIX_ATSTPTGT1, 0x00010 },
+	{ FSL_AUDMIX_ATTNVAL1,  0x00000 },
+	{ FSL_AUDMIX_ATSTP1,    0x00000 },
+};
+
+static const struct regmap_config fsl_audmix_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = FSL_AUDMIX_ATSTP1,
+	.reg_defaults = fsl_audmix_reg,
+	.num_reg_defaults = ARRAY_SIZE(fsl_audmix_reg),
+	.readable_reg = fsl_audmix_readable_reg,
+	.writeable_reg = fsl_audmix_writeable_reg,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int fsl_audmix_probe(struct platform_device *pdev)
+{
+	struct fsl_audmix *priv;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+	const char *sprop;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Get the addresses */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "ipg", regs,
+						 &fsl_audmix_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "failed to init regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(priv->ipg_clk)) {
+		dev_err(&pdev->dev, "failed to get ipg clock\n");
+		return PTR_ERR(priv->ipg_clk);
+	}
+
+	platform_set_drvdata(pdev, priv);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_audmix_component,
+					      fsl_audmix_dai,
+					      ARRAY_SIZE(fsl_audmix_dai));
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
+		return ret;
+	}
+
+	sprop = of_get_property(pdev->dev.of_node, "model", NULL);
+	if (sprop) {
+		priv->pdev = platform_device_register_data(&pdev->dev, sprop, 0,
+							   NULL, 0);
+		if (IS_ERR(priv->pdev)) {
+			ret = PTR_ERR(priv->pdev);
+			dev_err(&pdev->dev,
+				"failed to register platform %s: %d\n", sprop,
+				 ret);
+		}
+	} else {
+		dev_err(&pdev->dev, "[model] attribute missing.\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int fsl_audmix_remove(struct platform_device *pdev)
+{
+	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
+
+	if (priv->pdev)
+		platform_device_unregister(priv->pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int fsl_audmix_runtime_resume(struct device *dev)
+{
+	struct fsl_audmix *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->ipg_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable IPG clock: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(priv->regmap, false);
+	regcache_mark_dirty(priv->regmap);
+
+	return regcache_sync(priv->regmap);
+}
+
+static int fsl_audmix_runtime_suspend(struct device *dev)
+{
+	struct fsl_audmix *priv = dev_get_drvdata(dev);
+
+	regcache_cache_only(priv->regmap, true);
+
+	clk_disable_unprepare(priv->ipg_clk);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops fsl_audmix_pm = {
+	SET_RUNTIME_PM_OPS(fsl_audmix_runtime_suspend,
+			   fsl_audmix_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static const struct of_device_id fsl_audmix_ids[] = {
+	{ .compatible = "fsl,imx8qm-audmix", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
+
+static struct platform_driver fsl_audmix_driver = {
+	.probe = fsl_audmix_probe,
+	.remove = fsl_audmix_remove,
+	.driver = {
+		.name = "fsl-audmix",
+		.of_match_table = fsl_audmix_ids,
+		.pm = &fsl_audmix_pm,
+	},
+};
+module_platform_driver(fsl_audmix_driver);
+
+MODULE_DESCRIPTION("NXP AUDMIX ASoC DAI driver");
+MODULE_AUTHOR("Viorel Suman <viorel.suman@nxp.com>");
+MODULE_ALIAS("platform:fsl-audmix");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_audmix.h b/sound/soc/fsl/fsl_audmix.h
new file mode 100644
index 000000000000..7812ffec45c5
--- /dev/null
+++ b/sound/soc/fsl/fsl_audmix.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NXP AUDMIX ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ * Copyright 2017 NXP
+ */
+
+#ifndef __FSL_AUDMIX_H
+#define __FSL_AUDMIX_H
+
+#define FSL_AUDMIX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			SNDRV_PCM_FMTBIT_S24_LE |\
+			SNDRV_PCM_FMTBIT_S32_LE)
+/* AUDMIX Registers */
+#define FSL_AUDMIX_CTR		0x200 /* Control */
+#define FSL_AUDMIX_STR		0x204 /* Status */
+
+#define FSL_AUDMIX_ATCR0	0x208 /* Attenuation Control */
+#define FSL_AUDMIX_ATIVAL0	0x20c /* Attenuation Initial Value */
+#define FSL_AUDMIX_ATSTPUP0	0x210 /* Attenuation step up factor */
+#define FSL_AUDMIX_ATSTPDN0	0x214 /* Attenuation step down factor */
+#define FSL_AUDMIX_ATSTPTGT0	0x218 /* Attenuation step target */
+#define FSL_AUDMIX_ATTNVAL0	0x21c /* Attenuation Value */
+#define FSL_AUDMIX_ATSTP0	0x220 /* Attenuation step number */
+
+#define FSL_AUDMIX_ATCR1	0x228 /* Attenuation Control */
+#define FSL_AUDMIX_ATIVAL1	0x22c /* Attenuation Initial Value */
+#define FSL_AUDMIX_ATSTPUP1	0x230 /* Attenuation step up factor */
+#define FSL_AUDMIX_ATSTPDN1	0x234 /* Attenuation step down factor */
+#define FSL_AUDMIX_ATSTPTGT1	0x238 /* Attenuation step target */
+#define FSL_AUDMIX_ATTNVAL1	0x23c /* Attenuation Value */
+#define FSL_AUDMIX_ATSTP1	0x240 /* Attenuation step number */
+
+/* AUDMIX Control Register */
+#define FSL_AUDMIX_CTR_MIXCLK_SHIFT	0
+#define FSL_AUDMIX_CTR_MIXCLK_MASK	BIT(FSL_AUDMIX_CTR_MIXCLK_SHIFT)
+#define FSL_AUDMIX_CTR_MIXCLK(i)	((i) << FSL_AUDMIX_CTR_MIXCLK_SHIFT)
+#define FSL_AUDMIX_CTR_OUTSRC_SHIFT	1
+#define FSL_AUDMIX_CTR_OUTSRC_MASK	(0x3 << FSL_AUDMIX_CTR_OUTSRC_SHIFT)
+#define FSL_AUDMIX_CTR_OUTSRC(i)	(((i) << FSL_AUDMIX_CTR_OUTSRC_SHIFT)\
+					      & FSL_AUDMIX_CTR_OUTSRC_MASK)
+#define FSL_AUDMIX_CTR_OUTWIDTH_SHIFT	3
+#define FSL_AUDMIX_CTR_OUTWIDTH_MASK	(0x7 << FSL_AUDMIX_CTR_OUTWIDTH_SHIFT)
+#define FSL_AUDMIX_CTR_OUTWIDTH(i)	(((i) << FSL_AUDMIX_CTR_OUTWIDTH_SHIFT)\
+					      & FSL_AUDMIX_CTR_OUTWIDTH_MASK)
+#define FSL_AUDMIX_CTR_OUTCKPOL_SHIFT	6
+#define FSL_AUDMIX_CTR_OUTCKPOL_MASK	BIT(FSL_AUDMIX_CTR_OUTCKPOL_SHIFT)
+#define FSL_AUDMIX_CTR_OUTCKPOL(i)	((i) << FSL_AUDMIX_CTR_OUTCKPOL_SHIFT)
+#define FSL_AUDMIX_CTR_MASKRTDF_SHIFT	7
+#define FSL_AUDMIX_CTR_MASKRTDF_MASK	BIT(FSL_AUDMIX_CTR_MASKRTDF_SHIFT)
+#define FSL_AUDMIX_CTR_MASKRTDF(i)	((i) << FSL_AUDMIX_CTR_MASKRTDF_SHIFT)
+#define FSL_AUDMIX_CTR_MASKCKDF_SHIFT	8
+#define FSL_AUDMIX_CTR_MASKCKDF_MASK	BIT(FSL_AUDMIX_CTR_MASKCKDF_SHIFT)
+#define FSL_AUDMIX_CTR_MASKCKDF(i)	((i) << FSL_AUDMIX_CTR_MASKCKDF_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCMODE_SHIFT	9
+#define FSL_AUDMIX_CTR_SYNCMODE_MASK	BIT(FSL_AUDMIX_CTR_SYNCMODE_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCMODE(i)	((i) << FSL_AUDMIX_CTR_SYNCMODE_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCSRC_SHIFT	10
+#define FSL_AUDMIX_CTR_SYNCSRC_MASK	BIT(FSL_AUDMIX_CTR_SYNCSRC_SHIFT)
+#define FSL_AUDMIX_CTR_SYNCSRC(i)	((i) << FSL_AUDMIX_CTR_SYNCSRC_SHIFT)
+
+/* AUDMIX Status Register */
+#define FSL_AUDMIX_STR_RATEDIFF		BIT(0)
+#define FSL_AUDMIX_STR_CLKDIFF		BIT(1)
+#define FSL_AUDMIX_STR_MIXSTAT_SHIFT	2
+#define FSL_AUDMIX_STR_MIXSTAT_MASK	(0x3 << FSL_AUDMIX_STR_MIXSTAT_SHIFT)
+#define FSL_AUDMIX_STR_MIXSTAT(i)	(((i) & FSL_AUDMIX_STR_MIXSTAT_MASK) \
+					   >> FSL_AUDMIX_STR_MIXSTAT_SHIFT)
+/* AUDMIX Attenuation Control Register */
+#define FSL_AUDMIX_ATCR_AT_EN		BIT(0)
+#define FSL_AUDMIX_ATCR_AT_UPDN		BIT(1)
+#define FSL_AUDMIX_ATCR_ATSTPDIF_SHIFT	2
+#define FSL_AUDMIX_ATCR_ATSTPDFI_MASK	\
+				(0xfff << FSL_AUDMIX_ATCR_ATSTPDIF_SHIFT)
+
+/* AUDMIX Attenuation Initial Value Register */
+#define FSL_AUDMIX_ATIVAL_ATINVAL_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Up Factor Register */
+#define FSL_AUDMIX_ATSTPUP_ATSTEPUP_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Down Factor Register */
+#define FSL_AUDMIX_ATSTPDN_ATSTEPDN_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Target Register */
+#define FSL_AUDMIX_ATSTPTGT_ATSTPTG_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Value Register */
+#define FSL_AUDMIX_ATTNVAL_ATCURVAL_MASK	0x3FFFF
+
+/* AUDMIX Attenuation Step Number Register */
+#define FSL_AUDMIX_ATSTP_STPCTR_MASK	0x3FFFF
+
+#define FSL_AUDMIX_MAX_DAIS		2
+struct fsl_audmix {
+	struct platform_device *pdev;
+	struct regmap *regmap;
+	struct clk *ipg_clk;
+	u8 tdms;
+};
+
+#endif /* __FSL_AUDMIX_H */
-- 
2.20.1

