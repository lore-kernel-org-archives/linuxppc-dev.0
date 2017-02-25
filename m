Return-Path: <alin.grig93@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVl706ZG3zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 21:47:56 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id v77so6412344wmv.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 02:47:56 -0800 (PST)
From: Alin Grigorean <alin.grig93@gmail.com>
To: timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 perex@perex.cz, tiwai@suse.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, lgirdwood@gmail.com,
 broonie@kernel.org, Alin Grigorean <alin.grig93@gmail.com>
Subject: [PATCH] ASoC: fsl: Remove unneeded init of static variable
Date: Sat, 25 Feb 2017 12:47:26 +0200
Message-Id: <20170225104726.15936-1-alin.grig93@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was reported by checkpatch.pl

Signed-off-by: Alin Grigorean <alin.grig93@gmail.com>
---
 sound/soc/fsl/imx-pcm-fiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index dac6688540dc..92410f7ca1fa 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -282,7 +282,7 @@ static int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int ssi_irq = 0;
+static int ssi_irq;
 
 static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.11.1
