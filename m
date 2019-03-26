Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C42C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 14:44:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021FF2075E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 14:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gIrUObsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021FF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TDS52FvxzDqHf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 01:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="gIrUObsd"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TDPq658BzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 01:42:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=DOHhCEz+iDroYMF001WfcHeeQfKShlpC7zIxtP6sZSU=; b=gIrUObsd2sji
 /GsPT26O6UzWEjyqSOTME0SKs6YWqQmQF8GfZKtuESZYIX3+JXr59CXHhFSDgDKXILJEH6YtjxrCQ
 P69fJCqSJfdz3oanYUuxPv/ayl4DUbambvN0wbVyU6rEkh1g4Ue3Cn7/84Wk6jYY78txXDlMQiY/4
 uLBg4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1h8nHo-0007iI-Kr; Tue, 26 Mar 2019 14:42:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 33CE11121B57; Tue, 26 Mar 2019 14:42:44 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Applied "ASoC: add fsl_audmix DT binding documentation" to the asoc
 tree
In-Reply-To: <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190326144244.33CE11121B57@debutante.sirena.org.uk>
Date: Tue, 26 Mar 2019 14:42:44 +0000 (GMT)
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

   ASoC: add fsl_audmix DT binding documentation

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

From d0d9071b724123ebde89bdf6b52b86c3289abe85 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Tue, 22 Jan 2019 11:14:27 +0000
Subject: [PATCH] ASoC: add fsl_audmix DT binding documentation

Add the DT binding documentation for NXP Audio Mixer
CPU DAI driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/fsl,audmix.txt  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
new file mode 100644
index 000000000000..45f807ec21a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
@@ -0,0 +1,54 @@
+NXP Audio Mixer (AUDMIX).
+
+The Audio Mixer is a on-chip functional module that allows mixing of two
+audio streams into a single audio stream. Audio Mixer has two input serial
+audio interfaces. These are driven by two Synchronous Audio interface
+modules (SAI). Each input serial interface carries 8 audio channels in its
+frame in TDM manner. Mixer mixes audio samples of corresponding channels
+from two interfaces into a single sample. Before mixing, audio samples of
+two inputs can be attenuated based on configuration. The output of the
+Audio Mixer is also a serial audio interface. Like input interfaces it has
+the same TDM frame format. This output is used to drive the serial DAC TDM
+interface of audio codec and also sent to the external pins along with the
+receive path of normal audio SAI module for readback by the CPU.
+
+The output of Audio Mixer can be selected from any of the three streams
+ - serial audio input 1
+ - serial audio input 2
+ - mixed audio
+
+Mixing operation is independent of audio sample rate but the two audio
+input streams must have same audio sample rate with same number of channels
+in TDM frame to be eligible for mixing.
+
+Device driver required properties:
+=================================
+  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
+
+  - reg			: Offset and length of the register set for the device.
+
+  - clocks		: Must contain an entry for each entry in clock-names.
+
+  - clock-names		: Must include the "ipg" for register access.
+
+  - power-domains	: Must contain the phandle to AUDMIX power domain node
+
+  - dais		: Must contain a list of phandles to AUDMIX connected
+			  DAIs. The current implementation requires two phandles
+			  to SAI interfaces to be provided, the first SAI in the
+			  list being used to route the AUDMIX output.
+
+  - model		: Must contain machine driver name which will configure
+			  and instantiate the appropriate audio card.
+
+Device driver configuration example:
+======================================
+  audmix: audmix@59840000 {
+    compatible = "fsl,imx8qm-audmix";
+    reg = <0x0 0x59840000 0x0 0x10000>;
+    clocks = <&clk IMX8QXP_AUD_AUDMIX_IPG>;
+    clock-names = "ipg";
+    power-domains = <&pd_audmix>;
+    dais = <&sai4>, <&sai5>;
+    model = "imx-audmix";
+  };
-- 
2.20.1

