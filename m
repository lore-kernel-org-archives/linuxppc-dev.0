Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY2FN6MfjzDrKy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 20:16:56 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 83so9163349pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 03:16:56 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 3/6] ASoC: Intel: Skylake: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 15:46:09 +0530
Message-Id: <1502964972-22722-4-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make this const as it is only passed as the 2nd argument to the
function snd_soc_set_runtime_hwparams, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index e98d825..f6c9adb 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -33,7 +33,7 @@
 #define HDA_STEREO 2
 #define HDA_QUAD 4
 
-static struct snd_pcm_hardware azx_pcm_hw = {
+static const struct snd_pcm_hardware azx_pcm_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-- 
1.9.1
