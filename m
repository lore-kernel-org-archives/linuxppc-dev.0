Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B702E1A0D65
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 02:00:38 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so94321208pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2015 09:00:36 -0700 (PDT)
From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/4] ASoC: fsl: Constify platform_device_id
Date: Sat,  2 May 2015 01:00:13 +0900
Message-Id: <1430496014-32309-3-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 sound/soc/fsl/imx-audmux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index d9050d946ae7..fc57da341d61 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -184,7 +184,7 @@ static enum imx_audmux_type {
 	IMX31_AUDMUX,
 } audmux_type;
 
-static struct platform_device_id imx_audmux_ids[] = {
+static const struct platform_device_id imx_audmux_ids[] = {
 	{
 		.name = "imx21-audmux",
 		.driver_data = IMX21_AUDMUX,
-- 
2.1.4
