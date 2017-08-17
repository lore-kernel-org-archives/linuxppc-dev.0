Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYDNp1TYxzDrKZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 03:54:02 +1000 (AEST)
From: Mark Brown <broonie@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, julia.lawall@lip6.fr, timur@tabi.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: Intel: Atom: make snd_pcm_hardware const" to the asoc
 tree
In-Reply-To: <1502964972-22722-3-git-send-email-bhumirks@gmail.com>
Message-Id: <E1diOML-00005L-BB@debutante>
Date: Thu, 17 Aug 2017 18:13:29 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: Intel: Atom: make snd_pcm_hardware const

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From a7468e478a95db31c0f64e8497fadd9df5c49789 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 17 Aug 2017 15:46:08 +0530
Subject: [PATCH] ASoC: Intel: Atom: make snd_pcm_hardware const

Make this const as it is only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index b272df5ce0e8..43e7fdd19f29 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -76,7 +76,7 @@ int sst_unregister_dsp(struct sst_device *dev)
 }
 EXPORT_SYMBOL_GPL(sst_unregister_dsp);
 
-static struct snd_pcm_hardware sst_platform_pcm_hw = {
+static const struct snd_pcm_hardware sst_platform_pcm_hw = {
 	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
 			SNDRV_PCM_INFO_DOUBLE |
 			SNDRV_PCM_INFO_PAUSE |
-- 
2.13.3
