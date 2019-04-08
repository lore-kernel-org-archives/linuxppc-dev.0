Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D59DC282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 07:48:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB4E20880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 07:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FkvfZPfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB4E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d2bR1ZsszDqKN
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 17:48:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="FkvfZPfR"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d28v4DklzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 17:28:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=0jqs/0gl1ByisjPtYwG6G07nI6LPLQb8LLWWcvJBVxU=; b=FkvfZPfR5cId
 8V9CpPrHEGNeSSGDvDshSF6+5mx7F7saWhxKCpFzzxOPDOsegUsyTXLZOLnrNEfoCRWdy4YcLvVdD
 M54hXtkp0jERbsXnXNObwtgTdQlyYqieD8s3eqm5ObvrvooY4V+IyqF4gt8O131dyn21V+yBXuAVu
 D6kTU=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hDOhs-0003ro-Qk; Mon, 08 Apr 2019 07:28:42 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 83E4A441D3B; Mon,  8 Apr 2019 14:28:23 +0700 (+07)
From: Mark Brown <broonie@kernel.org>
To: Andra Danciu <andradanciu1997@gmail.com>
Subject: Applied "ASoC: imx-ssi: Switch to SPDX identifier" to the asoc tree
In-Reply-To: <20190405115010.28838-11-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408072823.83E4A441D3B@finisterre.ee.mobilebroadband>
Date: Mon,  8 Apr 2019 14:28:23 +0700 (+07)
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
Cc: daniel.baluta@nxp.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: imx-ssi: Switch to SPDX identifier

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

From bdc16b5748926412ca90cf0521c718a46e2ca2b7 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:00 +0300
Subject: [PATCH] ASoC: imx-ssi: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-ssi.c | 57 ++++++++++++++++++-----------------------
 sound/soc/fsl/imx-ssi.h |  6 +----
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 06790615e04e..9038b61317be 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -1,35 +1,28 @@
-/*
- * imx-ssi.c  --  ALSA Soc Audio Layer
- *
- * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
- *
- * This code is based on code copyrighted by Freescale,
- * Liam Girdwood, Javier Martin and probably others.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *
- * The i.MX SSI core has some nasty limitations in AC97 mode. While most
- * sane processor vendors have a FIFO per AC97 slot, the i.MX has only
- * one FIFO which combines all valid receive slots. We cannot even select
- * which slots we want to receive. The WM9712 with which this driver
- * was developed with always sends GPIO status data in slot 12 which
- * we receive in our (PCM-) data stream. The only chance we have is to
- * manually skip this data in the FIQ handler. With sampling rates different
- * from 48000Hz not every frame has valid receive data, so the ratio
- * between pcm data and GPIO status data changes. Our FIQ handler is not
- * able to handle this, hence this driver only works with 48000Hz sampling
- * rate.
- * Reading and writing AC97 registers is another challenge. The core
- * provides us status bits when the read register is updated with *another*
- * value. When we read the same register two times (and the register still
- * contains the same value) these status bits are not set. We work
- * around this by not polling these bits but only wait a fixed delay.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-ssi.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
+//
+// The i.MX SSI core has some nasty limitations in AC97 mode. While most
+// sane processor vendors have a FIFO per AC97 slot, the i.MX has only
+// one FIFO which combines all valid receive slots. We cannot even select
+// which slots we want to receive. The WM9712 with which this driver
+// was developed with always sends GPIO status data in slot 12 which
+// we receive in our (PCM-) data stream. The only chance we have is to
+// manually skip this data in the FIQ handler. With sampling rates different
+// from 48000Hz not every frame has valid receive data, so the ratio
+// between pcm data and GPIO status data changes. Our FIQ handler is not
+// able to handle this, hence this driver only works with 48000Hz sampling
+// rate.
+// Reading and writing AC97 registers is another challenge. The core
+// provides us status bits when the read register is updated with *another*
+// value. When we read the same register two times (and the register still
+// contains the same value) these status bits are not set. We work
+// around this by not polling these bits but only wait a fixed delay.
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index be6562365b6a..19cd0937e740 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -1,8 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _IMX_SSI_H
 #define _IMX_SSI_H
-- 
2.20.1

