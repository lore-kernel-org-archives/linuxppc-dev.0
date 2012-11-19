Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 9B6D32C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:02 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 146/493] ASoC: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:35 -0500
Message-Id: <1353349642-3677-146-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linux-arm-kernel@lists.infradead.org,
 device-drivers-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org,
 Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>,
 Ben Dooks <ben-linux@fluff.org>, Takashi Iwai <tiwai@suse.de>,
 linuxppc-dev@lists.ozlabs.org, patches@opensource.wolfsonmicro.com,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
 linux-samsung-soc@vger.kernel.org, M R Swami Reddy <mr.swami.reddy@ti.com>,
 Philipp Zabel <philipp.zabel@gmail.com>,
 Paul Parsons <lost.distance@yahoo.com>, Russell King <linux@arm.linux.org.uk>,
 linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: M R Swami Reddy <mr.swami.reddy@ti.com> 
Cc: Vishwas A Deshpande <vishwas.a.deshpande@ti.com> 
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com> 
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: Philipp Zabel <philipp.zabel@gmail.com> 
Cc: Paul Parsons <lost.distance@yahoo.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: alsa-devel@alsa-project.org 
Cc: uclinux-dist-devel@blackfin.uclinux.org 
Cc: device-drivers-devel@blackfin.uclinux.org 
Cc: patches@opensource.wolfsonmicro.com 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-omap@vger.kernel.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 sound/soc/atmel/atmel-pcm.c                    | 2 +-
 sound/soc/atmel/atmel_ssc_dai.c                | 2 +-
 sound/soc/atmel/sam9g20_wm8731.c               | 2 +-
 sound/soc/au1x/ac97c.c                         | 2 +-
 sound/soc/au1x/db1000.c                        | 2 +-
 sound/soc/au1x/db1200.c                        | 2 +-
 sound/soc/au1x/dbdma2.c                        | 2 +-
 sound/soc/au1x/dma.c                           | 2 +-
 sound/soc/au1x/i2sc.c                          | 2 +-
 sound/soc/au1x/psc-ac97.c                      | 2 +-
 sound/soc/au1x/psc-i2s.c                       | 2 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c            | 2 +-
 sound/soc/blackfin/bf5xx-ac97.c                | 2 +-
 sound/soc/blackfin/bf5xx-ad1836.c              | 2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c             | 2 +-
 sound/soc/blackfin/bf5xx-i2s.c                 | 2 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c             | 2 +-
 sound/soc/blackfin/bf5xx-tdm.c                 | 2 +-
 sound/soc/blackfin/bf6xx-i2s.c                 | 2 +-
 sound/soc/blackfin/bfin-eval-adau1373.c        | 2 +-
 sound/soc/blackfin/bfin-eval-adau1701.c        | 2 +-
 sound/soc/blackfin/bfin-eval-adav80x.c         | 2 +-
 sound/soc/cirrus/edb93xx.c                     | 2 +-
 sound/soc/cirrus/ep93xx-ac97.c                 | 2 +-
 sound/soc/cirrus/ep93xx-i2s.c                  | 2 +-
 sound/soc/cirrus/ep93xx-pcm.c                  | 2 +-
 sound/soc/cirrus/simone.c                      | 2 +-
 sound/soc/cirrus/snappercl15.c                 | 2 +-
 sound/soc/codecs/88pm860x-codec.c              | 2 +-
 sound/soc/codecs/ab8500-codec.c                | 2 +-
 sound/soc/codecs/ac97.c                        | 2 +-
 sound/soc/codecs/ad1836.c                      | 2 +-
 sound/soc/codecs/ad193x.c                      | 4 ++--
 sound/soc/codecs/ad1980.c                      | 2 +-
 sound/soc/codecs/ad73311.c                     | 2 +-
 sound/soc/codecs/adau1373.c                    | 2 +-
 sound/soc/codecs/adau1701.c                    | 2 +-
 sound/soc/codecs/adav80x.c                     | 4 ++--
 sound/soc/codecs/ads117x.c                     | 2 +-
 sound/soc/codecs/ak4104.c                      | 2 +-
 sound/soc/codecs/ak4535.c                      | 2 +-
 sound/soc/codecs/ak4641.c                      | 2 +-
 sound/soc/codecs/ak4642.c                      | 2 +-
 sound/soc/codecs/ak4671.c                      | 2 +-
 sound/soc/codecs/alc5623.c                     | 2 +-
 sound/soc/codecs/alc5632.c                     | 2 +-
 sound/soc/codecs/cq93vc.c                      | 2 +-
 sound/soc/codecs/cs4271.c                      | 4 ++--
 sound/soc/codecs/cs42l52.c                     | 2 +-
 sound/soc/codecs/cs42l73.c                     | 2 +-
 sound/soc/codecs/da7210.c                      | 4 ++--
 sound/soc/codecs/da732x.c                      | 2 +-
 sound/soc/codecs/da9055.c                      | 2 +-
 sound/soc/codecs/dfbmcs320.c                   | 2 +-
 sound/soc/codecs/dmic.c                        | 2 +-
 sound/soc/codecs/isabelle.c                    | 2 +-
 sound/soc/codecs/jz4740.c                      | 2 +-
 sound/soc/codecs/lm4857.c                      | 2 +-
 sound/soc/codecs/lm49453.c                     | 2 +-
 sound/soc/codecs/max9768.c                     | 2 +-
 sound/soc/codecs/max98095.c                    | 2 +-
 sound/soc/codecs/max9850.c                     | 2 +-
 sound/soc/codecs/max9877.c                     | 2 +-
 sound/soc/codecs/mc13783.c                     | 2 +-
 sound/soc/codecs/ml26124.c                     | 2 +-
 sound/soc/codecs/omap-hdmi.c                   | 2 +-
 sound/soc/codecs/pcm3008.c                     | 2 +-
 sound/soc/codecs/rt5631.c                      | 2 +-
 sound/soc/codecs/sgtl5000.c                    | 2 +-
 sound/soc/codecs/si476x.c                      | 2 +-
 sound/soc/codecs/sn95031.c                     | 2 +-
 sound/soc/codecs/ssm2602.c                     | 4 ++--
 sound/soc/codecs/sta32x.c                      | 2 +-
 sound/soc/codecs/sta529.c                      | 2 +-
 sound/soc/codecs/stac9766.c                    | 2 +-
 sound/soc/codecs/tlv320aic32x4.c               | 2 +-
 sound/soc/codecs/tlv320dac33.c                 | 2 +-
 sound/soc/codecs/tpa6130a2.c                   | 2 +-
 sound/soc/codecs/twl4030.c                     | 2 +-
 sound/soc/codecs/twl6040.c                     | 2 +-
 sound/soc/codecs/uda134x.c                     | 2 +-
 sound/soc/codecs/uda1380.c                     | 2 +-
 sound/soc/codecs/wl1273.c                      | 2 +-
 sound/soc/codecs/wm0010.c                      | 2 +-
 sound/soc/codecs/wm1250-ev1.c                  | 2 +-
 sound/soc/codecs/wm2000.c                      | 2 +-
 sound/soc/codecs/wm2200.c                      | 2 +-
 sound/soc/codecs/wm5100.c                      | 2 +-
 sound/soc/codecs/wm5102.c                      | 2 +-
 sound/soc/codecs/wm5110.c                      | 2 +-
 sound/soc/codecs/wm8350.c                      | 2 +-
 sound/soc/codecs/wm8400.c                      | 2 +-
 sound/soc/codecs/wm8510.c                      | 4 ++--
 sound/soc/codecs/wm8523.c                      | 2 +-
 sound/soc/codecs/wm8711.c                      | 4 ++--
 sound/soc/codecs/wm8727.c                      | 2 +-
 sound/soc/codecs/wm8728.c                      | 4 ++--
 sound/soc/codecs/wm8731.c                      | 4 ++--
 sound/soc/codecs/wm8737.c                      | 4 ++--
 sound/soc/codecs/wm8741.c                      | 2 +-
 sound/soc/codecs/wm8750.c                      | 4 ++--
 sound/soc/codecs/wm8753.c                      | 4 ++--
 sound/soc/codecs/wm8770.c                      | 2 +-
 sound/soc/codecs/wm8776.c                      | 4 ++--
 sound/soc/codecs/wm8782.c                      | 2 +-
 sound/soc/codecs/wm8804.c                      | 4 ++--
 sound/soc/codecs/wm8900.c                      | 4 ++--
 sound/soc/codecs/wm8903.c                      | 2 +-
 sound/soc/codecs/wm8904.c                      | 2 +-
 sound/soc/codecs/wm8940.c                      | 2 +-
 sound/soc/codecs/wm8955.c                      | 2 +-
 sound/soc/codecs/wm8960.c                      | 2 +-
 sound/soc/codecs/wm8961.c                      | 2 +-
 sound/soc/codecs/wm8962.c                      | 2 +-
 sound/soc/codecs/wm8971.c                      | 2 +-
 sound/soc/codecs/wm8974.c                      | 2 +-
 sound/soc/codecs/wm8978.c                      | 2 +-
 sound/soc/codecs/wm8983.c                      | 4 ++--
 sound/soc/codecs/wm8985.c                      | 4 ++--
 sound/soc/codecs/wm8988.c                      | 4 ++--
 sound/soc/codecs/wm8990.c                      | 2 +-
 sound/soc/codecs/wm8991.c                      | 2 +-
 sound/soc/codecs/wm8993.c                      | 2 +-
 sound/soc/codecs/wm8994.c                      | 2 +-
 sound/soc/codecs/wm8995.c                      | 4 ++--
 sound/soc/codecs/wm8996.c                      | 2 +-
 sound/soc/codecs/wm9081.c                      | 2 +-
 sound/soc/codecs/wm9090.c                      | 2 +-
 sound/soc/codecs/wm9705.c                      | 2 +-
 sound/soc/codecs/wm9712.c                      | 2 +-
 sound/soc/codecs/wm9713.c                      | 2 +-
 sound/soc/fsl/eukrea-tlv320.c                  | 2 +-
 sound/soc/fsl/fsl_dma.c                        | 2 +-
 sound/soc/fsl/imx-audmux.c                     | 2 +-
 sound/soc/fsl/imx-mc13783.c                    | 2 +-
 sound/soc/fsl/imx-pcm-dma.c                    | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c                    | 2 +-
 sound/soc/fsl/imx-sgtl5000.c                   | 2 +-
 sound/soc/fsl/imx-ssi.c                        | 2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c               | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                | 2 +-
 sound/soc/fsl/mpc8610_hpcd.c                   | 2 +-
 sound/soc/fsl/mx27vis-aic32x4.c                | 2 +-
 sound/soc/fsl/p1022_ds.c                       | 2 +-
 sound/soc/fsl/p1022_rdk.c                      | 2 +-
 sound/soc/fsl/pcm030-audio-fabric.c            | 2 +-
 sound/soc/jz4740/jz4740-i2s.c                  | 2 +-
 sound/soc/jz4740/jz4740-pcm.c                  | 2 +-
 sound/soc/jz4740/qi_lb60.c                     | 2 +-
 sound/soc/kirkwood/kirkwood-dma.c              | 2 +-
 sound/soc/kirkwood/kirkwood-i2s.c              | 2 +-
 sound/soc/kirkwood/kirkwood-openrd.c           | 2 +-
 sound/soc/kirkwood/kirkwood-t5325.c            | 2 +-
 sound/soc/mid-x86/mfld_machine.c               | 2 +-
 sound/soc/mxs/mxs-saif.c                       | 2 +-
 sound/soc/mxs/mxs-sgtl5000.c                   | 2 +-
 sound/soc/nuc900/nuc900-ac97.c                 | 2 +-
 sound/soc/nuc900/nuc900-pcm.c                  | 2 +-
 sound/soc/omap/ams-delta.c                     | 2 +-
 sound/soc/omap/omap-abe-twl6040.c              | 2 +-
 sound/soc/omap/omap-dmic.c                     | 2 +-
 sound/soc/omap/omap-hdmi-card.c                | 2 +-
 sound/soc/omap/omap-hdmi.c                     | 2 +-
 sound/soc/omap/omap-mcbsp.c                    | 2 +-
 sound/soc/omap/omap-mcpdm.c                    | 2 +-
 sound/soc/omap/omap-pcm.c                      | 2 +-
 sound/soc/omap/omap-twl4030.c                  | 2 +-
 sound/soc/pxa/brownstone.c                     | 2 +-
 sound/soc/pxa/corgi.c                          | 2 +-
 sound/soc/pxa/e740_wm9705.c                    | 2 +-
 sound/soc/pxa/e750_wm9705.c                    | 2 +-
 sound/soc/pxa/e800_wm9712.c                    | 2 +-
 sound/soc/pxa/hx4700.c                         | 2 +-
 sound/soc/pxa/imote2.c                         | 2 +-
 sound/soc/pxa/mioa701_wm9713.c                 | 2 +-
 sound/soc/pxa/mmp-pcm.c                        | 2 +-
 sound/soc/pxa/mmp-sspa.c                       | 2 +-
 sound/soc/pxa/palm27x.c                        | 2 +-
 sound/soc/pxa/poodle.c                         | 2 +-
 sound/soc/pxa/pxa-ssp.c                        | 2 +-
 sound/soc/pxa/pxa2xx-ac97.c                    | 2 +-
 sound/soc/pxa/pxa2xx-i2s.c                     | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c                     | 2 +-
 sound/soc/pxa/tosa.c                           | 2 +-
 sound/soc/pxa/ttc-dkb.c                        | 2 +-
 sound/soc/s6000/s6000-i2s.c                    | 2 +-
 sound/soc/s6000/s6000-pcm.c                    | 2 +-
 sound/soc/samsung/ac97.c                       | 2 +-
 sound/soc/samsung/bells.c                      | 2 +-
 sound/soc/samsung/dma.c                        | 2 +-
 sound/soc/samsung/i2s.c                        | 2 +-
 sound/soc/samsung/idma.c                       | 2 +-
 sound/soc/samsung/littlemill.c                 | 2 +-
 sound/soc/samsung/lowland.c                    | 2 +-
 sound/soc/samsung/pcm.c                        | 2 +-
 sound/soc/samsung/s3c2412-i2s.c                | 2 +-
 sound/soc/samsung/s3c24xx-i2s.c                | 2 +-
 sound/soc/samsung/s3c24xx_simtec_hermes.c      | 2 +-
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c | 2 +-
 sound/soc/samsung/smdk_wm8580pcm.c             | 2 +-
 sound/soc/samsung/smdk_wm8994.c                | 2 +-
 sound/soc/samsung/smdk_wm8994pcm.c             | 2 +-
 sound/soc/samsung/spdif.c                      | 2 +-
 sound/soc/samsung/speyside.c                   | 2 +-
 sound/soc/samsung/tobermory.c                  | 2 +-
 sound/soc/sh/dma-sh7760.c                      | 2 +-
 sound/soc/sh/hac.c                             | 2 +-
 sound/soc/sh/siu_dai.c                         | 2 +-
 sound/soc/sh/ssi.c                             | 2 +-
 sound/soc/soc-utils.c                          | 2 +-
 sound/soc/spear/spear_pcm.c                    | 2 +-
 sound/soc/tegra/tegra20_das.c                  | 2 +-
 sound/soc/tegra/tegra20_i2s.c                  | 2 +-
 sound/soc/tegra/tegra20_spdif.c                | 2 +-
 sound/soc/tegra/tegra30_ahub.c                 | 2 +-
 sound/soc/tegra/tegra30_i2s.c                  | 2 +-
 sound/soc/tegra/tegra_alc5632.c                | 2 +-
 sound/soc/tegra/tegra_wm8753.c                 | 2 +-
 sound/soc/tegra/tegra_wm8903.c                 | 2 +-
 sound/soc/tegra/trimslice.c                    | 2 +-
 sound/soc/txx9/txx9aclc-ac97.c                 | 2 +-
 sound/soc/txx9/txx9aclc.c                      | 2 +-
 sound/soc/ux500/mop500.c                       | 2 +-
 sound/soc/ux500/ux500_pcm.c                    | 2 +-
 224 files changed, 243 insertions(+), 243 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 9b84f98..194eb85 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -491,7 +491,7 @@ static struct platform_driver atmel_pcm_driver = {
 	},
 
 	.probe = atmel_soc_platform_probe,
-	.remove = __devexit_p(atmel_soc_platform_remove),
+	.remove = atmel_soc_platform_remove,
 };
 
 module_platform_driver(atmel_pcm_driver);
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 354341e..90a1188 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -807,7 +807,7 @@ static struct platform_driver asoc_ssc_driver = {
 	},
 
 	.probe = asoc_ssc_probe,
-	.remove = __devexit_p(asoc_ssc_remove),
+	.remove = asoc_ssc_remove,
 };
 
 /**
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 228ca6a..a1dfe46 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -261,7 +261,7 @@ static struct platform_driver at91sam9g20ek_audio_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= at91sam9g20ek_audio_probe,
-	.remove	= __devexit_p(at91sam9g20ek_audio_remove),
+	.remove	= at91sam9g20ek_audio_remove,
 };
 
 module_platform_driver(at91sam9g20ek_audio_driver);
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index c5ac244..f54edf4 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -330,7 +330,7 @@ static struct platform_driver au1xac97c_driver = {
 		.pm	= AU1XPSCAC97_PMOPS,
 	},
 	.probe		= au1xac97c_drvprobe,
-	.remove		= __devexit_p(au1xac97c_drvremove),
+	.remove		= au1xac97c_drvremove,
 };
 
 static int __init au1xac97c_load(void)
diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
index 511d83c..faf55ab 100644
--- a/sound/soc/au1x/db1000.c
+++ b/sound/soc/au1x/db1000.c
@@ -55,7 +55,7 @@ static struct platform_driver db1000_audio_driver = {
 		.pm	= &snd_soc_pm_ops,
 	},
 	.probe		= db1000_audio_probe,
-	.remove		= __devexit_p(db1000_audio_remove),
+	.remove		= db1000_audio_remove,
 };
 
 module_platform_driver(db1000_audio_driver);
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 30ea513..2d7f9b8 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -201,7 +201,7 @@ static struct platform_driver db1200_audio_driver = {
 	},
 	.id_table	= db1200_pids,
 	.probe		= db1200_audio_probe,
-	.remove		= __devexit_p(db1200_audio_remove),
+	.remove		= db1200_audio_remove,
 };
 
 module_platform_driver(db1200_audio_driver);
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 8372cd3..fe5bbf4 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -375,7 +375,7 @@ static struct platform_driver au1xpsc_pcm_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= au1xpsc_pcm_drvprobe,
-	.remove		= __devexit_p(au1xpsc_pcm_drvremove),
+	.remove		= au1xpsc_pcm_drvremove,
 };
 
 module_platform_driver(au1xpsc_pcm_driver);
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 0a91b18..264e820 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -348,7 +348,7 @@ static struct platform_driver alchemy_pcmdma_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= alchemy_pcm_drvprobe,
-	.remove		= __devexit_p(alchemy_pcm_drvremove),
+	.remove		= alchemy_pcm_drvremove,
 };
 
 module_platform_driver(alchemy_pcmdma_driver);
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index d4b9e36..329ec51 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -309,7 +309,7 @@ static struct platform_driver au1xi2s_driver = {
 		.pm	= AU1XI2SC_PMOPS,
 	},
 	.probe		= au1xi2s_drvprobe,
-	.remove		= __devexit_p(au1xi2s_drvremove),
+	.remove		= au1xi2s_drvremove,
 };
 
 module_platform_driver(au1xi2s_driver);
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 476b79a..dab4b75 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -495,7 +495,7 @@ static struct platform_driver au1xpsc_ac97_driver = {
 		.pm	= AU1XPSCAC97_PMOPS,
 	},
 	.probe		= au1xpsc_ac97_drvprobe,
-	.remove		= __devexit_p(au1xpsc_ac97_drvremove),
+	.remove		= au1xpsc_ac97_drvremove,
 };
 
 static int __init au1xpsc_ac97_load(void)
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 0607ba3..73800b2 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -418,7 +418,7 @@ static struct platform_driver au1xpsc_i2s_driver = {
 		.pm	= AU1XPSCI2S_PMOPS,
 	},
 	.probe		= au1xpsc_i2s_drvprobe,
-	.remove		= __devexit_p(au1xpsc_i2s_drvremove),
+	.remove		= au1xpsc_i2s_drvremove,
 };
 
 module_platform_driver(au1xpsc_i2s_driver);
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index d7dc9bd..cb29219 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -471,7 +471,7 @@ static struct platform_driver bf5xx_pcm_driver = {
 	},
 
 	.probe = bf5xx_soc_platform_probe,
-	.remove = __devexit_p(bf5xx_soc_platform_remove),
+	.remove = bf5xx_soc_platform_remove,
 };
 
 module_platform_driver(bf5xx_pcm_driver);
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index f4e9dc4..cce2e8d 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -372,7 +372,7 @@ static struct platform_driver asoc_bfin_ac97_driver = {
 	},
 
 	.probe = asoc_bfin_ac97_probe,
-	.remove = __devexit_p(asoc_bfin_ac97_remove),
+	.remove = asoc_bfin_ac97_remove,
 };
 
 module_platform_driver(asoc_bfin_ac97_driver);
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 16b9c9e..f34b99f 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -113,7 +113,7 @@ static struct platform_driver bf5xx_ad1836_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bf5xx_ad1836_driver_probe,
-	.remove = __devexit_p(bf5xx_ad1836_driver_remove),
+	.remove = bf5xx_ad1836_driver_remove,
 };
 module_platform_driver(bf5xx_ad1836_driver);
 
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 63205d7..a0fbb1e 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -310,7 +310,7 @@ static struct platform_driver bfin_i2s_pcm_driver = {
 	},
 
 	.probe = bfin_i2s_soc_platform_probe,
-	.remove = __devexit_p(bfin_i2s_soc_platform_remove),
+	.remove = bfin_i2s_soc_platform_remove,
 };
 
 module_platform_driver(bfin_i2s_pcm_driver);
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 4dccf03..990b6d1 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -281,7 +281,7 @@ static int __devexit bf5xx_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_i2s_driver = {
 	.probe  = bf5xx_i2s_probe,
-	.remove = __devexit_p(bf5xx_i2s_remove),
+	.remove = bf5xx_i2s_remove,
 	.driver = {
 		.name = "bfin-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 254490c..9740e0f 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -335,7 +335,7 @@ static struct platform_driver bfin_tdm_driver = {
 	},
 
 	.probe = bf5xx_soc_platform_probe,
-	.remove = __devexit_p(bf5xx_soc_platform_remove),
+	.remove = bf5xx_soc_platform_remove,
 };
 
 module_platform_driver(bfin_tdm_driver);
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 594f882..a4fe59c 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -307,7 +307,7 @@ static int __devexit bfin_tdm_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_tdm_driver = {
 	.probe  = bfin_tdm_probe,
-	.remove = __devexit_p(bfin_tdm_remove),
+	.remove = bfin_tdm_remove,
 	.driver = {
 		.name   = "bfin-tdm",
 		.owner  = THIS_MODULE,
diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
index c3c2466..0021bd6 100644
--- a/sound/soc/blackfin/bf6xx-i2s.c
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -220,7 +220,7 @@ static int __devexit bfin_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_i2s_driver = {
 	.probe  = bfin_i2s_probe,
-	.remove = __devexit_p(bfin_i2s_remove),
+	.remove = bfin_i2s_remove,
 	.driver = {
 		.name = "bfin-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index f3adbdb..c494e85 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -173,7 +173,7 @@ static struct platform_driver bfin_eval_adau1373_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adau1373_probe,
-	.remove = __devexit_p(bfin_eval_adau1373_remove),
+	.remove = bfin_eval_adau1373_remove,
 };
 
 module_platform_driver(bfin_eval_adau1373_driver);
diff --git a/sound/soc/blackfin/bfin-eval-adau1701.c b/sound/soc/blackfin/bfin-eval-adau1701.c
index b0531fc..eb2dab8 100644
--- a/sound/soc/blackfin/bfin-eval-adau1701.c
+++ b/sound/soc/blackfin/bfin-eval-adau1701.c
@@ -113,7 +113,7 @@ static struct platform_driver bfin_eval_adau1701_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adau1701_probe,
-	.remove = __devexit_p(bfin_eval_adau1701_remove),
+	.remove = bfin_eval_adau1701_remove,
 };
 
 module_platform_driver(bfin_eval_adau1701_driver);
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 84b0998..5d71f76 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -145,7 +145,7 @@ static struct platform_driver bfin_eval_adav80x_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adav80x_probe,
-	.remove = __devexit_p(bfin_eval_adav80x_remove),
+	.remove = bfin_eval_adav80x_remove,
 	.id_table = bfin_eval_adav80x_ids,
 };
 
diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index e01cb02..b610600 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -117,7 +117,7 @@ static struct platform_driver edb93xx_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= edb93xx_probe,
-	.remove		= __devexit_p(edb93xx_remove),
+	.remove		= edb93xx_remove,
 };
 
 module_platform_driver(edb93xx_driver);
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index c352165..2c15880 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -420,7 +420,7 @@ static int __devexit ep93xx_ac97_remove(struct platform_device *pdev)
 
 static struct platform_driver ep93xx_ac97_driver = {
 	.probe	= ep93xx_ac97_probe,
-	.remove	= __devexit_p(ep93xx_ac97_remove),
+	.remove	= ep93xx_ac97_remove,
 	.driver = {
 		.name = "ep93xx-ac97",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index ac4a751..fe62a61 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -436,7 +436,7 @@ static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver ep93xx_i2s_driver = {
 	.probe	= ep93xx_i2s_probe,
-	.remove	= __devexit_p(ep93xx_i2s_remove),
+	.remove	= ep93xx_i2s_remove,
 	.driver	= {
 		.name	= "ep93xx-i2s",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 665d9c9..4274ba2 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -231,7 +231,7 @@ static struct platform_driver ep93xx_pcm_driver = {
 	},
 
 	.probe = ep93xx_soc_platform_probe,
-	.remove = __devexit_p(ep93xx_soc_platform_remove),
+	.remove = ep93xx_soc_platform_remove,
 };
 
 module_platform_driver(ep93xx_pcm_driver);
diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
index dd99709..04f59a9 100644
--- a/sound/soc/cirrus/simone.c
+++ b/sound/soc/cirrus/simone.c
@@ -79,7 +79,7 @@ static struct platform_driver simone_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= simone_probe,
-	.remove		= __devexit_p(simone_remove),
+	.remove		= simone_remove,
 };
 
 module_platform_driver(simone_driver);
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index a193cea..a98bec1 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -135,7 +135,7 @@ static struct platform_driver snappercl15_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= snappercl15_probe,
-	.remove		= __devexit_p(snappercl15_remove),
+	.remove		= snappercl15_remove,
 };
 
 module_platform_driver(snappercl15_driver);
diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 9fd3b68..6e9d31b 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1476,7 +1476,7 @@ static struct platform_driver pm860x_codec_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe	= pm860x_codec_probe,
-	.remove	= __devexit_p(pm860x_codec_remove),
+	.remove	= pm860x_codec_remove,
 };
 
 module_platform_driver(pm860x_codec_driver);
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 4d96090..bf9db7f 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2595,7 +2595,7 @@ static struct platform_driver ab8500_codec_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ab8500_codec_driver_probe,
-	.remove		= __devexit_p(ab8500_codec_driver_remove),
+	.remove		= ab8500_codec_driver_remove,
 	.suspend	= NULL,
 	.resume		= NULL,
 };
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index ea06b83..0ae093b 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -137,7 +137,7 @@ static struct platform_driver ac97_codec_driver = {
 	},
 
 	.probe = ac97_probe,
-	.remove = __devexit_p(ac97_remove),
+	.remove = ac97_remove,
 };
 
 module_platform_driver(ac97_codec_driver);
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index dce6ebe..1613241 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -405,7 +405,7 @@ static struct spi_driver ad1836_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad1836_spi_probe,
-	.remove		= __devexit_p(ad1836_spi_remove),
+	.remove		= ad1836_spi_remove,
 	.id_table	= ad1836_ids,
 };
 
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 2f75266..9537b66 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -409,7 +409,7 @@ static struct spi_driver ad193x_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad193x_spi_probe,
-	.remove		= __devexit_p(ad193x_spi_remove),
+	.remove		= ad193x_spi_remove,
 };
 #endif
 
@@ -461,7 +461,7 @@ static struct i2c_driver ad193x_i2c_driver = {
 		.name = "ad193x",
 	},
 	.probe    = ad193x_i2c_probe,
-	.remove   = __devexit_p(ad193x_i2c_remove),
+	.remove   = ad193x_i2c_remove,
 	.id_table = ad193x_id,
 };
 #endif
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 8c39ddd..b095553 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -274,7 +274,7 @@ static struct platform_driver ad1980_codec_driver = {
 	},
 
 	.probe = ad1980_probe,
-	.remove = __devexit_p(ad1980_remove),
+	.remove = ad1980_remove,
 };
 
 module_platform_driver(ad1980_codec_driver);
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index ee7a68d..82c2a7e 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -60,7 +60,7 @@ static struct platform_driver ad73311_codec_driver = {
 	},
 
 	.probe = ad73311_probe,
-	.remove = __devexit_p(ad73311_remove),
+	.remove = ad73311_remove,
 };
 
 module_platform_driver(ad73311_codec_driver);
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 704544b..7f62721 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1388,7 +1388,7 @@ static struct i2c_driver adau1373_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adau1373_i2c_probe,
-	.remove = __devexit_p(adau1373_i2c_remove),
+	.remove = adau1373_i2c_remove,
 	.id_table = adau1373_i2c_id,
 };
 
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index 51f2f3c..f02b1c83 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -523,7 +523,7 @@ static struct i2c_driver adau1701_i2c_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= adau1701_i2c_probe,
-	.remove		= __devexit_p(adau1701_i2c_remove),
+	.remove		= adau1701_i2c_remove,
 	.id_table	= adau1701_i2c_id,
 };
 
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index ebd7b37..cd5d0f6 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -884,7 +884,7 @@ static struct spi_driver adav80x_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= adav80x_spi_probe,
-	.remove		= __devexit_p(adav80x_spi_remove),
+	.remove		= adav80x_spi_remove,
 };
 #endif
 
@@ -912,7 +912,7 @@ static struct i2c_driver adav80x_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adav80x_i2c_probe,
-	.remove = __devexit_p(adav80x_i2c_remove),
+	.remove = adav80x_i2c_remove,
 	.id_table = adav80x_id,
 };
 #endif
diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 8103b93..93aae10 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -55,7 +55,7 @@ static struct platform_driver ads117x_codec_driver = {
 	},
 
 	.probe = ads117x_probe,
-	.remove = __devexit_p(ads117x_remove),
+	.remove = ads117x_remove,
 };
 
 module_platform_driver(ads117x_codec_driver);
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index eec086b..b391f26 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -288,7 +288,7 @@ static struct spi_driver ak4104_spi_driver = {
 		.of_match_table = ak4104_of_match,
 	},
 	.probe  = ak4104_spi_probe,
-	.remove = __devexit_p(ak4104_spi_remove),
+	.remove = ak4104_spi_remove,
 };
 
 module_spi_driver(ak4104_spi_driver);
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 618fdc3..66b3669 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -485,7 +485,7 @@ static struct i2c_driver ak4535_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    ak4535_i2c_probe,
-	.remove =   __devexit_p(ak4535_i2c_remove),
+	.remove =   ak4535_i2c_remove,
 	.id_table = ak4535_i2c_id,
 };
 
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 543a12f..8c8ef10 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -640,7 +640,7 @@ static struct i2c_driver ak4641_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    ak4641_i2c_probe,
-	.remove =   __devexit_p(ak4641_i2c_remove),
+	.remove =   ak4641_i2c_remove,
 	.id_table = ak4641_i2c_id,
 };
 
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index b3e24f2..e2c3222 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -560,7 +560,7 @@ static struct i2c_driver ak4642_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= ak4642_i2c_probe,
-	.remove		= __devexit_p(ak4642_i2c_remove),
+	.remove		= ak4642_i2c_remove,
 	.id_table	= ak4642_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 2b45797..2fc0a5d 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -692,7 +692,7 @@ static struct i2c_driver ak4671_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ak4671_i2c_probe,
-	.remove = __devexit_p(ak4671_i2c_remove),
+	.remove = ak4671_i2c_remove,
 	.id_table = ak4671_i2c_id,
 };
 
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 1960478..cef214e 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -1079,7 +1079,7 @@ static struct i2c_driver alc5623_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = alc5623_i2c_probe,
-	.remove =  __devexit_p(alc5623_i2c_remove),
+	.remove =  alc5623_i2c_remove,
 	.id_table = alc5623_i2c_table,
 };
 
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 7dd0242..93fd94d 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1198,7 +1198,7 @@ static struct i2c_driver alc5632_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = alc5632_i2c_probe,
-	.remove =  __devexit_p(alc5632_i2c_remove),
+	.remove =  alc5632_i2c_remove,
 	.id_table = alc5632_i2c_table,
 };
 
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 064cd6a..23316c8 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -201,7 +201,7 @@ static struct platform_driver cq93vc_codec_driver = {
 	},
 
 	.probe = cq93vc_platform_probe,
-	.remove = __devexit_p(cq93vc_platform_remove),
+	.remove = cq93vc_platform_remove,
 };
 
 module_platform_driver(cq93vc_codec_driver);
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 6ad3878..976b9bd 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -598,7 +598,7 @@ static struct spi_driver cs4271_spi_driver = {
 		.of_match_table = of_match_ptr(cs4271_dt_ids),
 	},
 	.probe		= cs4271_spi_probe,
-	.remove		= __devexit_p(cs4271_spi_remove),
+	.remove		= cs4271_spi_remove,
 };
 #endif /* defined(CONFIG_SPI_MASTER) */
 
@@ -639,7 +639,7 @@ static struct i2c_driver cs4271_i2c_driver = {
 	},
 	.id_table	= cs4271_i2c_id,
 	.probe		= cs4271_i2c_probe,
-	.remove		= __devexit_p(cs4271_i2c_remove),
+	.remove		= cs4271_i2c_remove,
 };
 #endif /* defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE) */
 
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 97a8105..99bb1c6 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1271,7 +1271,7 @@ static struct i2c_driver cs42l52_i2c_driver = {
 	},
 	.id_table = cs42l52_id,
 	.probe =    cs42l52_i2c_probe,
-	.remove =   __devexit_p(cs42l52_i2c_remove),
+	.remove =   cs42l52_i2c_remove,
 };
 
 module_i2c_driver(cs42l52_i2c_driver);
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 2c08c4c..f68bbc7 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1426,7 +1426,7 @@ static struct i2c_driver cs42l73_i2c_driver = {
 		   },
 	.id_table = cs42l73_id,
 	.probe = cs42l73_i2c_probe,
-	.remove = __devexit_p(cs42l73_i2c_remove),
+	.remove = cs42l73_i2c_remove,
 
 };
 
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index af5db70..7ab571d 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1279,7 +1279,7 @@ static struct i2c_driver da7210_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= da7210_i2c_probe,
-	.remove		= __devexit_p(da7210_i2c_remove),
+	.remove		= da7210_i2c_remove,
 	.id_table	= da7210_i2c_id,
 };
 #endif
@@ -1373,7 +1373,7 @@ static struct spi_driver da7210_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = da7210_spi_probe,
-	.remove = __devexit_p(da7210_spi_remove)
+	.remove = da7210_spi_remove
 };
 #endif
 
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 01be2a3..c6f1ef9 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1615,7 +1615,7 @@ static struct i2c_driver da732x_i2c_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= da732x_i2c_probe,
-	.remove		= __devexit_p(da732x_i2c_remove),
+	.remove		= da732x_i2c_remove,
 	.id_table	= da732x_i2c_id,
 };
 
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index d3a6de2..468ad60 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1536,7 +1536,7 @@ static struct i2c_driver da9055_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= da9055_i2c_probe,
-	.remove		= __devexit_p(da9055_remove),
+	.remove		= da9055_remove,
 	.id_table	= da9055_i2c_id,
 };
 
diff --git a/sound/soc/codecs/dfbmcs320.c b/sound/soc/codecs/dfbmcs320.c
index bfe46aa..af7e38d 100644
--- a/sound/soc/codecs/dfbmcs320.c
+++ b/sound/soc/codecs/dfbmcs320.c
@@ -52,7 +52,7 @@ static struct platform_driver dfmcs320_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = dfbmcs320_probe,
-	.remove = __devexit_p(dfbmcs320_remove),
+	.remove = dfbmcs320_remove,
 };
 
 module_platform_driver(dfmcs320_driver);
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 3e929f0..95b39ac 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -86,7 +86,7 @@ static struct platform_driver dmic_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = dmic_dev_probe,
-	.remove = __devexit_p(dmic_dev_remove),
+	.remove = dmic_dev_remove,
 };
 
 module_platform_driver(dmic_driver);
diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 1bf5560..25e57ea 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1163,7 +1163,7 @@ static struct i2c_driver isabelle_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = isabelle_i2c_probe,
-	.remove = __devexit_p(isabelle_i2c_remove),
+	.remove = isabelle_i2c_remove,
 	.id_table = isabelle_i2c_id,
 };
 
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 9ad1da3..d295dcf 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -391,7 +391,7 @@ static int __devexit jz4740_codec_remove(struct platform_device *pdev)
 
 static struct platform_driver jz4740_codec_driver = {
 	.probe = jz4740_codec_probe,
-	.remove = __devexit_p(jz4740_codec_remove),
+	.remove = jz4740_codec_remove,
 	.driver = {
 		.name = "jz4740-codec",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 81a328c..b0db011 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -246,7 +246,7 @@ static struct i2c_driver lm4857_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = lm4857_i2c_probe,
-	.remove = __devexit_p(lm4857_i2c_remove),
+	.remove = lm4857_i2c_remove,
 	.id_table = lm4857_i2c_id,
 };
 
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 99b0a9d..af16b4a 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1538,7 +1538,7 @@ static struct i2c_driver lm49453_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = lm49453_i2c_probe,
-	.remove = __devexit_p(lm49453_i2c_remove),
+	.remove = lm49453_i2c_remove,
 	.id_table = lm49453_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 17b3ec2..367d886 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -237,7 +237,7 @@ static struct i2c_driver max9768_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = max9768_i2c_probe,
-	.remove = __devexit_p(max9768_i2c_remove),
+	.remove = max9768_i2c_remove,
 	.id_table = max9768_i2c_id,
 };
 module_i2c_driver(max9768_i2c_driver);
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 38d43c5..1e17aef 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2529,7 +2529,7 @@ static struct i2c_driver max98095_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe  = max98095_i2c_probe,
-	.remove = __devexit_p(max98095_i2c_remove),
+	.remove = max98095_i2c_remove,
 	.id_table = max98095_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index efe535c..adf2317 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -365,7 +365,7 @@ static struct i2c_driver max9850_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = max9850_i2c_probe,
-	.remove = __devexit_p(max9850_i2c_remove),
+	.remove = max9850_i2c_remove,
 	.id_table = max9850_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index d15e594..bc15f5a 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -287,7 +287,7 @@ static struct i2c_driver max9877_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = max9877_i2c_probe,
-	.remove = __devexit_p(max9877_i2c_remove),
+	.remove = max9877_i2c_remove,
 	.id_table = max9877_i2c_id,
 };
 
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index bc95599..5402dfb 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -779,7 +779,7 @@ static struct platform_driver mc13783_codec_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = mc13783_codec_probe,
-	.remove = __devexit_p(mc13783_codec_remove),
+	.remove = mc13783_codec_remove,
 };
 
 module_platform_driver(mc13783_codec_driver);
diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 96aa5fa..7b15fe8 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -667,7 +667,7 @@ static struct i2c_driver ml26124_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ml26124_i2c_probe,
-	.remove = __devexit_p(ml26124_i2c_remove),
+	.remove = ml26124_i2c_remove,
 	.id_table = ml26124_i2c_id,
 };
 
diff --git a/sound/soc/codecs/omap-hdmi.c b/sound/soc/codecs/omap-hdmi.c
index 1bf5c74..1437766 100644
--- a/sound/soc/codecs/omap-hdmi.c
+++ b/sound/soc/codecs/omap-hdmi.c
@@ -58,7 +58,7 @@ static struct platform_driver omap_hdmi_codec_driver = {
 	},
 
 	.probe		= omap_hdmi_codec_probe,
-	.remove		= __devexit_p(omap_hdmi_codec_remove),
+	.remove		= omap_hdmi_codec_remove,
 };
 
 module_platform_driver(omap_hdmi_codec_driver);
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index edcaa7e..bb48aa6 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -165,7 +165,7 @@ MODULE_ALIAS("platform:pcm3008-codec");
 
 static struct platform_driver pcm3008_codec_driver = {
 	.probe		= pcm3008_codec_probe,
-	.remove		= __devexit_p(pcm3008_codec_remove),
+	.remove		= pcm3008_codec_remove,
 	.driver		= {
 		.name	= "pcm3008-codec",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 960d0e9..32d5ff4 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1760,7 +1760,7 @@ static struct i2c_driver rt5631_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = rt5631_i2c_probe,
-	.remove   = __devexit_p(rt5631_i2c_remove),
+	.remove   = rt5631_i2c_remove,
 	.id_table = rt5631_i2c_id,
 };
 
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index df2f99d..66e6e43 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1449,7 +1449,7 @@ static struct i2c_driver sgtl5000_i2c_driver = {
 		   .of_match_table = sgtl5000_dt_ids,
 		   },
 	.probe = sgtl5000_i2c_probe,
-	.remove = __devexit_p(sgtl5000_i2c_remove),
+	.remove = sgtl5000_i2c_remove,
 	.id_table = sgtl5000_id,
 };
 
diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 38145ba..13fff24 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -246,7 +246,7 @@ static struct platform_driver si476x_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= si476x_platform_probe,
-	.remove		= __devexit_p(si476x_platform_remove),
+	.remove		= si476x_platform_remove,
 };
 module_platform_driver(si476x_platform_driver);
 
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 50dbdb9..97bad86 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -916,7 +916,7 @@ static struct platform_driver sn95031_codec_driver = {
 		.owner		= THIS_MODULE,
 	},
 	.probe		= sn95031_device_probe,
-	.remove		= __devexit_p(sn95031_device_remove),
+	.remove		= sn95031_device_remove,
 };
 
 module_platform_driver(sn95031_codec_driver);
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 079066f..c290fe10 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -725,7 +725,7 @@ static struct spi_driver ssm2602_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ssm2602_spi_probe,
-	.remove		= __devexit_p(ssm2602_spi_remove),
+	.remove		= ssm2602_spi_remove,
 };
 #endif
 
@@ -780,7 +780,7 @@ static struct i2c_driver ssm2602_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ssm2602_i2c_probe,
-	.remove = __devexit_p(ssm2602_i2c_remove),
+	.remove = ssm2602_i2c_remove,
 	.id_table = ssm2602_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 0935bfe..2b10e20 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1053,7 +1053,7 @@ static struct i2c_driver sta32x_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    sta32x_i2c_probe,
-	.remove =   __devexit_p(sta32x_i2c_remove),
+	.remove =   sta32x_i2c_remove,
 	.id_table = sta32x_i2c_id,
 };
 
diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 9e31448..34a73b8 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -431,7 +431,7 @@ static struct i2c_driver sta529_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= sta529_i2c_probe,
-	.remove		= __devexit_p(sta529_i2c_remove),
+	.remove		= sta529_i2c_remove,
 	.id_table	= sta529_i2c_id,
 };
 
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 982e437..29a8b391 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -404,7 +404,7 @@ static struct platform_driver stac9766_codec_driver = {
 	},
 
 	.probe = stac9766_probe,
-	.remove = __devexit_p(stac9766_remove),
+	.remove = stac9766_remove,
 };
 
 module_platform_driver(stac9766_codec_driver);
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e39e08d..4cc54d5 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -766,7 +766,7 @@ static struct i2c_driver aic32x4_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    aic32x4_i2c_probe,
-	.remove =   __devexit_p(aic32x4_i2c_remove),
+	.remove =   aic32x4_i2c_remove,
 	.id_table = aic32x4_i2c_id,
 };
 
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index d2e16c5..c1e3804 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1617,7 +1617,7 @@ static struct i2c_driver tlv320dac33_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe		= dac33_i2c_probe,
-	.remove		= __devexit_p(dac33_i2c_remove),
+	.remove		= dac33_i2c_remove,
 	.id_table	= tlv320dac33_i2c_id,
 };
 
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 565ff39..aea6262 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -483,7 +483,7 @@ static struct i2c_driver tpa6130a2_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = tpa6130a2_probe,
-	.remove = __devexit_p(tpa6130a2_remove),
+	.remove = tpa6130a2_remove,
 	.id_table = tpa6130a2_id,
 };
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e7f6089..d7e4e1b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2350,7 +2350,7 @@ MODULE_ALIAS("platform:twl4030-codec");
 
 static struct platform_driver twl4030_codec_driver = {
 	.probe		= twl4030_codec_probe,
-	.remove		= __devexit_p(twl4030_codec_remove),
+	.remove		= twl4030_codec_remove,
 	.driver		= {
 		.name	= "twl4030-codec",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 00b85cc..37f060e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1247,7 +1247,7 @@ static struct platform_driver twl6040_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = twl6040_codec_probe,
-	.remove = __devexit_p(twl6040_codec_remove),
+	.remove = twl6040_codec_remove,
 };
 
 module_platform_driver(twl6040_codec_driver);
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 6c3d43b..9c60366 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -619,7 +619,7 @@ static struct platform_driver uda134x_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = uda134x_codec_probe,
-	.remove = __devexit_p(uda134x_codec_remove),
+	.remove = uda134x_codec_remove,
 };
 
 module_platform_driver(uda134x_codec_driver);
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2502214..2f6c391 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -832,7 +832,7 @@ static struct i2c_driver uda1380_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    uda1380_i2c_probe,
-	.remove =   __devexit_p(uda1380_i2c_remove),
+	.remove =   uda1380_i2c_remove,
 	.id_table = uda1380_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 7b24d6d..1823a45 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -505,7 +505,7 @@ static struct platform_driver wl1273_platform_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wl1273_platform_probe,
-	.remove		= __devexit_p(wl1273_platform_remove),
+	.remove		= wl1273_platform_remove,
 };
 
 module_platform_driver(wl1273_platform_driver);
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 4b68ea8..5af91d6 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -985,7 +985,7 @@ static struct spi_driver wm0010_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm0010_spi_probe,
-	.remove		= __devexit_p(wm0010_spi_remove),
+	.remove		= wm0010_spi_remove,
 };
 
 module_spi_driver(wm0010_spi_driver);
diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 951d7b4..169fac1 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -257,7 +257,7 @@ static struct i2c_driver wm1250_ev1_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm1250_ev1_probe,
-	.remove =   __devexit_p(wm1250_ev1_remove),
+	.remove =   wm1250_ev1_remove,
 	.id_table = wm1250_ev1_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 683dc43..da4e707 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -890,7 +890,7 @@ static struct i2c_driver wm2000_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm2000_i2c_probe,
-	.remove = __devexit_p(wm2000_i2c_remove),
+	.remove = wm2000_i2c_remove,
 	.id_table = wm2000_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 1730df8..11cabda 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2461,7 +2461,7 @@ static struct i2c_driver wm2200_i2c_driver = {
 		.pm = &wm2200_pm,
 	},
 	.probe =    wm2200_i2c_probe,
-	.remove =   __devexit_p(wm2200_i2c_remove),
+	.remove =   wm2200_i2c_remove,
 	.id_table = wm2200_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 7f56758..96069ec 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2717,7 +2717,7 @@ static struct i2c_driver wm5100_i2c_driver = {
 		.pm = &wm5100_pm,
 	},
 	.probe =    wm5100_i2c_probe,
-	.remove =   __devexit_p(wm5100_i2c_remove),
+	.remove =   wm5100_i2c_remove,
 	.id_table = wm5100_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 05c2add..4a57802 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1509,7 +1509,7 @@ static struct platform_driver wm5102_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm5102_probe,
-	.remove = __devexit_p(wm5102_remove),
+	.remove = wm5102_remove,
 };
 
 module_platform_driver(wm5102_codec_driver);
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 3485b83..6f66b11 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1002,7 +1002,7 @@ static struct platform_driver wm5110_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm5110_probe,
-	.remove = __devexit_p(wm5110_remove),
+	.remove = wm5110_remove,
 };
 
 module_platform_driver(wm5110_codec_driver);
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index a4cae060..d0e35d3 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1645,7 +1645,7 @@ static struct platform_driver wm8350_codec_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = wm8350_probe,
-	.remove = __devexit_p(wm8350_remove),
+	.remove = wm8350_remove,
 };
 
 module_platform_driver(wm8350_codec_driver);
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 5d277a9..a9a85f6 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1457,7 +1457,7 @@ static struct platform_driver wm8400_codec_driver = {
 		   .owner = THIS_MODULE,
 		   },
 	.probe = wm8400_probe,
-	.remove = __devexit_p(wm8400_remove),
+	.remove = wm8400_remove,
 };
 
 module_platform_driver(wm8400_codec_driver);
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index c12a54e..91816eb 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -683,7 +683,7 @@ static struct spi_driver wm8510_spi_driver = {
 		.of_match_table = wm8510_of_match,
 	},
 	.probe		= wm8510_spi_probe,
-	.remove		= __devexit_p(wm8510_spi_remove),
+	.remove		= wm8510_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -730,7 +730,7 @@ static struct i2c_driver wm8510_i2c_driver = {
 		.of_match_table = wm8510_of_match,
 	},
 	.probe =    wm8510_i2c_probe,
-	.remove =   __devexit_p(wm8510_i2c_remove),
+	.remove =   wm8510_i2c_remove,
 	.id_table = wm8510_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 8d5c276..6004c17 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -547,7 +547,7 @@ static struct i2c_driver wm8523_i2c_driver = {
 		.of_match_table = wm8523_of_match,
 	},
 	.probe =    wm8523_i2c_probe,
-	.remove =   __devexit_p(wm8523_i2c_remove),
+	.remove =   wm8523_i2c_remove,
 	.id_table = wm8523_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 8b8bb70..c97eb50 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -465,7 +465,7 @@ static struct spi_driver wm8711_spi_driver = {
 		.of_match_table = wm8711_of_match,
 	},
 	.probe		= wm8711_spi_probe,
-	.remove		= __devexit_p(wm8711_spi_remove),
+	.remove		= wm8711_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -512,7 +512,7 @@ static struct i2c_driver wm8711_i2c_driver = {
 		.of_match_table = wm8711_of_match,
 	},
 	.probe =    wm8711_i2c_probe,
-	.remove =   __devexit_p(wm8711_i2c_remove),
+	.remove =   wm8711_i2c_remove,
 	.id_table = wm8711_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index e817056..a38c36b 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -64,7 +64,7 @@ static struct platform_driver wm8727_codec_driver = {
 	},
 
 	.probe = wm8727_probe,
-	.remove = __devexit_p(wm8727_remove),
+	.remove = wm8727_remove,
 };
 
 module_platform_driver(wm8727_codec_driver);
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 00a12a0..50aa6dd 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -316,7 +316,7 @@ static struct spi_driver wm8728_spi_driver = {
 		.of_match_table = wm8728_of_match,
 	},
 	.probe		= wm8728_spi_probe,
-	.remove		= __devexit_p(wm8728_spi_remove),
+	.remove		= wm8728_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -363,7 +363,7 @@ static struct i2c_driver wm8728_i2c_driver = {
 		.of_match_table = wm8728_of_match,
 	},
 	.probe =    wm8728_i2c_probe,
-	.remove =   __devexit_p(wm8728_i2c_remove),
+	.remove =   wm8728_i2c_remove,
 	.id_table = wm8728_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index bb1d269..c277327 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -674,7 +674,7 @@ static struct spi_driver wm8731_spi_driver = {
 		.of_match_table = wm8731_of_match,
 	},
 	.probe		= wm8731_spi_probe,
-	.remove		= __devexit_p(wm8731_spi_remove),
+	.remove		= wm8731_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -729,7 +729,7 @@ static struct i2c_driver wm8731_i2c_driver = {
 		.of_match_table = wm8731_of_match,
 	},
 	.probe =    wm8731_i2c_probe,
-	.remove =   __devexit_p(wm8731_i2c_remove),
+	.remove =   wm8731_i2c_remove,
 	.id_table = wm8731_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 5c9634f..46caa41 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -699,7 +699,7 @@ static struct i2c_driver wm8737_i2c_driver = {
 		.of_match_table = wm8737_of_match,
 	},
 	.probe =    wm8737_i2c_probe,
-	.remove =   __devexit_p(wm8737_i2c_remove),
+	.remove =   wm8737_i2c_remove,
 	.id_table = wm8737_i2c_id,
 };
 #endif
@@ -751,7 +751,7 @@ static struct spi_driver wm8737_spi_driver = {
 		.of_match_table = wm8737_of_match,
 	},
 	.probe		= wm8737_spi_probe,
-	.remove		= __devexit_p(wm8737_spi_remove),
+	.remove		= wm8737_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 4281a08..24c5576 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -609,7 +609,7 @@ static struct spi_driver wm8741_spi_driver = {
 		.of_match_table = wm8741_of_match,
 	},
 	.probe		= wm8741_spi_probe,
-	.remove		= __devexit_p(wm8741_spi_remove),
+	.remove		= wm8741_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 7665d68..b45575e 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -812,7 +812,7 @@ static struct spi_driver wm8750_spi_driver = {
 	},
 	.id_table	= wm8750_spi_ids,
 	.probe		= wm8750_spi_probe,
-	.remove		= __devexit_p(wm8750_spi_remove),
+	.remove		= wm8750_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -860,7 +860,7 @@ static struct i2c_driver wm8750_i2c_driver = {
 		.of_match_table = wm8750_of_match,
 	},
 	.probe =    wm8750_i2c_probe,
-	.remove =   __devexit_p(wm8750_i2c_remove),
+	.remove =   wm8750_i2c_remove,
 	.id_table = wm8750_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 2e4a775..0daacac 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1602,7 +1602,7 @@ static struct spi_driver wm8753_spi_driver = {
 		.of_match_table = wm8753_of_match,
 	},
 	.probe		= wm8753_spi_probe,
-	.remove		= __devexit_p(wm8753_spi_remove),
+	.remove		= wm8753_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -1665,7 +1665,7 @@ static struct i2c_driver wm8753_i2c_driver = {
 		.of_match_table = wm8753_of_match,
 	},
 	.probe =    wm8753_i2c_probe,
-	.remove =   __devexit_p(wm8753_i2c_remove),
+	.remove =   wm8753_i2c_remove,
 	.id_table = wm8753_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 0b690ba..849b5f3 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -718,7 +718,7 @@ static struct spi_driver wm8770_spi_driver = {
 		.of_match_table = wm8770_of_match,
 	},
 	.probe = wm8770_spi_probe,
-	.remove = __devexit_p(wm8770_spi_remove)
+	.remove = wm8770_spi_remove
 };
 
 module_spi_driver(wm8770_spi_driver);
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index c32249d..7bb0ee5 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -527,7 +527,7 @@ static struct spi_driver wm8776_spi_driver = {
 		.of_match_table = wm8776_of_match,
 	},
 	.probe		= wm8776_spi_probe,
-	.remove		= __devexit_p(wm8776_spi_remove),
+	.remove		= wm8776_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -575,7 +575,7 @@ static struct i2c_driver wm8776_i2c_driver = {
 		.of_match_table = wm8776_of_match,
 	},
 	.probe =    wm8776_i2c_probe,
-	.remove =   __devexit_p(wm8776_i2c_remove),
+	.remove =   wm8776_i2c_remove,
 	.id_table = wm8776_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 3fdea98..6b82ae6 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -60,7 +60,7 @@ static struct platform_driver wm8782_codec_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8782_probe,
-	.remove = __devexit_p(wm8782_remove),
+	.remove = wm8782_remove,
 };
 
 module_platform_driver(wm8782_codec_driver);
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index c088020..368fe09 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -740,7 +740,7 @@ static struct spi_driver wm8804_spi_driver = {
 		.of_match_table = wm8804_of_match,
 	},
 	.probe = wm8804_spi_probe,
-	.remove = __devexit_p(wm8804_spi_remove)
+	.remove = wm8804_spi_remove
 };
 #endif
 
@@ -798,7 +798,7 @@ static struct i2c_driver wm8804_i2c_driver = {
 		.of_match_table = wm8804_of_match,
 	},
 	.probe = wm8804_i2c_probe,
-	.remove = __devexit_p(wm8804_i2c_remove),
+	.remove = wm8804_i2c_remove,
 	.id_table = wm8804_i2c_id
 };
 #endif
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index e781f86..d68b2dd 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1281,7 +1281,7 @@ static struct spi_driver wm8900_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8900_spi_probe,
-	.remove		= __devexit_p(wm8900_spi_remove),
+	.remove		= wm8900_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -1327,7 +1327,7 @@ static struct i2c_driver wm8900_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8900_i2c_probe,
-	.remove =   __devexit_p(wm8900_i2c_remove),
+	.remove =   wm8900_i2c_remove,
 	.id_table = wm8900_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 839414f..8e9977b 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2237,7 +2237,7 @@ static struct i2c_driver wm8903_i2c_driver = {
 		.of_match_table = wm8903_of_match,
 	},
 	.probe =    wm8903_i2c_probe,
-	.remove =   __devexit_p(wm8903_i2c_remove),
+	.remove =   wm8903_i2c_remove,
 	.id_table = wm8903_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 7c8df52..b1d0ea5 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2267,7 +2267,7 @@ static struct i2c_driver wm8904_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8904_i2c_probe,
-	.remove =   __devexit_p(wm8904_i2c_remove),
+	.remove =   wm8904_i2c_remove,
 	.id_table = wm8904_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index b20aa4e..9a9a17f 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -781,7 +781,7 @@ static struct i2c_driver wm8940_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8940_i2c_probe,
-	.remove =   __devexit_p(wm8940_i2c_remove),
+	.remove =   wm8940_i2c_remove,
 	.id_table = wm8940_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 2f1c075..a18b15b 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -1067,7 +1067,7 @@ static struct i2c_driver wm8955_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8955_i2c_probe,
-	.remove =   __devexit_p(wm8955_i2c_remove),
+	.remove =   wm8955_i2c_remove,
 	.id_table = wm8955_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index f0f6f660..bb6eba5 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1080,7 +1080,7 @@ static struct i2c_driver wm8960_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8960_i2c_probe,
-	.remove =   __devexit_p(wm8960_i2c_remove),
+	.remove =   wm8960_i2c_remove,
 	.id_table = wm8960_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index f387670..aade82e 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1012,7 +1012,7 @@ static struct i2c_driver wm8961_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8961_i2c_probe,
-	.remove =   __devexit_p(wm8961_i2c_remove),
+	.remove =   wm8961_i2c_remove,
 	.id_table = wm8961_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index ce67200..de01896 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3773,7 +3773,7 @@ static struct i2c_driver wm8962_i2c_driver = {
 		.pm = &wm8962_pm,
 	},
 	.probe =    wm8962_i2c_probe,
-	.remove =   __devexit_p(wm8962_i2c_remove),
+	.remove =   wm8962_i2c_remove,
 	.id_table = wm8962_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 70dd27e..eea701e 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -759,7 +759,7 @@ static struct i2c_driver wm8971_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8971_i2c_probe,
-	.remove =   __devexit_p(wm8971_i2c_remove),
+	.remove =   wm8971_i2c_remove,
 	.id_table = wm8971_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 9a39511..ff5e507 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -655,7 +655,7 @@ static struct i2c_driver wm8974_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8974_i2c_probe,
-	.remove =   __devexit_p(wm8974_i2c_remove),
+	.remove =   wm8974_i2c_remove,
 	.id_table = wm8974_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 4c0a8e4..5a8a0a3 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1101,7 +1101,7 @@ static struct i2c_driver wm8978_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8978_i2c_probe,
-	.remove =   __devexit_p(wm8978_i2c_remove),
+	.remove =   wm8978_i2c_remove,
 	.id_table = wm8978_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index d8879f2..e29c736 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -1122,7 +1122,7 @@ static struct spi_driver wm8983_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8983_spi_probe,
-	.remove = __devexit_p(wm8983_spi_remove)
+	.remove = wm8983_spi_remove
 };
 #endif
 
@@ -1170,7 +1170,7 @@ static struct i2c_driver wm8983_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8983_i2c_probe,
-	.remove = __devexit_p(wm8983_i2c_remove),
+	.remove = wm8983_i2c_remove,
 	.id_table = wm8983_i2c_id
 };
 #endif
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 14f6663..4e1ef71 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1158,7 +1158,7 @@ static struct spi_driver wm8985_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8985_spi_probe,
-	.remove = __devexit_p(wm8985_spi_remove)
+	.remove = wm8985_spi_remove
 };
 #endif
 
@@ -1217,7 +1217,7 @@ static struct i2c_driver wm8985_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8985_i2c_probe,
-	.remove = __devexit_p(wm8985_i2c_remove),
+	.remove = wm8985_i2c_remove,
 	.id_table = wm8985_i2c_id
 };
 #endif
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 1d4c5cf..1e6cb3e 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -913,7 +913,7 @@ static struct spi_driver wm8988_spi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8988_spi_probe,
-	.remove		= __devexit_p(wm8988_spi_remove),
+	.remove		= wm8988_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -966,7 +966,7 @@ static struct i2c_driver wm8988_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8988_i2c_probe,
-	.remove =   __devexit_p(wm8988_i2c_remove),
+	.remove =   wm8988_i2c_remove,
 	.id_table = wm8988_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index c28c83e..db75bd2 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1420,7 +1420,7 @@ static struct i2c_driver wm8990_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8990_i2c_probe,
-	.remove =   __devexit_p(wm8990_i2c_remove),
+	.remove =   wm8990_i2c_remove,
 	.id_table = wm8990_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index fe439f0..e09efea 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1395,7 +1395,7 @@ static struct i2c_driver wm8991_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8991_i2c_probe,
-	.remove = __devexit_p(wm8991_i2c_remove),
+	.remove = wm8991_i2c_remove,
 	.id_table = wm8991_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 94737a3..d57ec80 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1775,7 +1775,7 @@ static struct i2c_driver wm8993_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8993_i2c_probe,
-	.remove =   __devexit_p(wm8993_i2c_remove),
+	.remove =   wm8993_i2c_remove,
 	.id_table = wm8993_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 88dbabc..52d4ec7 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4308,7 +4308,7 @@ static struct platform_driver wm8994_codec_driver = {
 		.pm = &wm8994_pm_ops,
 	},
 	.probe = wm8994_probe,
-	.remove = __devexit_p(wm8994_remove),
+	.remove = wm8994_remove,
 };
 
 module_platform_driver(wm8994_codec_driver);
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 28c89b0..2503294 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2305,7 +2305,7 @@ static struct spi_driver wm8995_spi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8995_spi_probe,
-	.remove = __devexit_p(wm8995_spi_remove)
+	.remove = wm8995_spi_remove
 };
 #endif
 
@@ -2370,7 +2370,7 @@ static struct i2c_driver wm8995_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8995_i2c_probe,
-	.remove = __devexit_p(wm8995_i2c_remove),
+	.remove = wm8995_i2c_remove,
 	.id_table = wm8995_i2c_id
 };
 #endif
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 6dcb02c..ed7d6ed 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -3107,7 +3107,7 @@ static struct i2c_driver wm8996_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8996_i2c_probe,
-	.remove =   __devexit_p(wm8996_i2c_remove),
+	.remove =   wm8996_i2c_remove,
 	.id_table = wm8996_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 2de74e1..d639602 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1414,7 +1414,7 @@ static struct i2c_driver wm9081_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm9081_i2c_probe,
-	.remove =   __devexit_p(wm9081_i2c_remove),
+	.remove =   wm9081_i2c_remove,
 	.id_table = wm9081_i2c_id,
 };
 #endif
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index c7ddc56..bfb22dc 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -691,7 +691,7 @@ static struct i2c_driver wm9090_i2c_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = wm9090_i2c_probe,
-	.remove = __devexit_p(wm9090_i2c_remove),
+	.remove = wm9090_i2c_remove,
 	.id_table = wm9090_id,
 };
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index e8e782a..9c380f6 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -401,7 +401,7 @@ static struct platform_driver wm9705_codec_driver = {
 	},
 
 	.probe = wm9705_probe,
-	.remove = __devexit_p(wm9705_remove),
+	.remove = wm9705_remove,
 };
 
 module_platform_driver(wm9705_codec_driver);
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 4dd73ea..73de205 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -704,7 +704,7 @@ static struct platform_driver wm9712_codec_driver = {
 	},
 
 	.probe = wm9712_probe,
-	.remove = __devexit_p(wm9712_remove),
+	.remove = wm9712_remove,
 };
 
 module_platform_driver(wm9712_codec_driver);
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 3eb19fb..5e5afeb 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1273,7 +1273,7 @@ static struct platform_driver wm9713_codec_driver = {
 	},
 
 	.probe = wm9713_probe,
-	.remove = __devexit_p(wm9713_remove),
+	.remove = wm9713_remove,
 };
 
 module_platform_driver(wm9713_codec_driver);
diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 267d5b4..855b851 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -155,7 +155,7 @@ static struct platform_driver eukrea_tlv320_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = eukrea_tlv320_probe,
-	.remove = __devexit_p(eukrea_tlv320_remove),};
+	.remove = eukrea_tlv320_remove,};
 
 module_platform_driver(eukrea_tlv320_driver);
 
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 6feb265..36fbf7a 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -983,7 +983,7 @@ static struct platform_driver fsl_soc_dma_driver = {
 		.of_match_table = fsl_soc_dma_ids,
 	},
 	.probe = fsl_soc_dma_probe,
-	.remove = __devexit_p(fsl_soc_dma_remove),
+	.remove = fsl_soc_dma_remove,
 };
 
 module_platform_driver(fsl_soc_dma_driver);
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 524ce62..ff0266b 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -289,7 +289,7 @@ static int __devexit imx_audmux_remove(struct platform_device *pdev)
 
 static struct platform_driver imx_audmux_driver = {
 	.probe		= imx_audmux_probe,
-	.remove		= __devexit_p(imx_audmux_remove),
+	.remove		= imx_audmux_remove,
 	.id_table	= imx_audmux_ids,
 	.driver	= {
 		.name	= DRIVER_NAME,
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 549b31f..ed027c2 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -161,7 +161,7 @@ static struct platform_driver imx_mc13783_audio_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = imx_mc13783_probe,
-	.remove = __devexit_p(imx_mc13783_remove)
+	.remove = imx_mc13783_remove
 };
 
 module_platform_driver(imx_mc13783_audio_driver);
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index d85929b..4252e16 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -171,7 +171,7 @@ static struct platform_driver imx_pcm_driver = {
 			.owner = THIS_MODULE,
 	},
 	.probe = imx_soc_platform_probe,
-	.remove = __devexit_p(imx_soc_platform_remove),
+	.remove = imx_soc_platform_remove,
 };
 
 module_platform_driver(imx_pcm_driver);
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 9ffc9e6..8d88642 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -328,7 +328,7 @@ static struct platform_driver imx_pcm_driver = {
 	},
 
 	.probe = imx_soc_platform_probe,
-	.remove = __devexit_p(imx_soc_platform_remove),
+	.remove = imx_soc_platform_remove,
 };
 
 module_platform_driver(imx_pcm_driver);
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 199408e..dc646b2 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -210,7 +210,7 @@ static struct platform_driver imx_sgtl5000_driver = {
 		.of_match_table = imx_sgtl5000_dt_ids,
 	},
 	.probe = imx_sgtl5000_probe,
-	.remove = __devexit_p(imx_sgtl5000_remove),
+	.remove = imx_sgtl5000_remove,
 };
 module_platform_driver(imx_sgtl5000_driver);
 
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index dd56644..0392e7b 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -659,7 +659,7 @@ static int __devexit imx_ssi_remove(struct platform_device *pdev)
 
 static struct platform_driver imx_ssi_driver = {
 	.probe = imx_ssi_probe,
-	.remove = __devexit_p(imx_ssi_remove),
+	.remove = imx_ssi_remove,
 
 	.driver = {
 		.name = "imx-ssi",
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index a313c0a..da6d6d9 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -327,7 +327,7 @@ MODULE_DEVICE_TABLE(of, psc_ac97_match);
 
 static struct platform_driver psc_ac97_driver = {
 	.probe = psc_ac97_of_probe,
-	.remove = __devexit_p(psc_ac97_of_remove),
+	.remove = psc_ac97_of_remove,
 	.driver = {
 		.name = "mpc5200-psc-ac97",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index ba1f0a6..e25c62d 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -222,7 +222,7 @@ MODULE_DEVICE_TABLE(of, psc_i2s_match);
 
 static struct platform_driver psc_i2s_driver = {
 	.probe = psc_i2s_of_probe,
-	.remove = __devexit_p(psc_i2s_of_remove),
+	.remove = psc_i2s_of_remove,
 	.driver = {
 		.name = "mpc5200-psc-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 9ff9318..2b6dc68 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -382,7 +382,7 @@ static int __devexit mpc8610_hpcd_remove(struct platform_device *pdev)
 
 static struct platform_driver mpc8610_hpcd_driver = {
 	.probe = mpc8610_hpcd_probe,
-	.remove = __devexit_p(mpc8610_hpcd_remove),
+	.remove = mpc8610_hpcd_remove,
 	.driver = {
 		/* The name must match 'compatible' property in the device tree,
 		 * in lowercase letters.
diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index 2b76877..687b830 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -232,7 +232,7 @@ static struct platform_driver mx27vis_aic32x4_audio_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = mx27vis_aic32x4_probe,
-	.remove = __devexit_p(mx27vis_aic32x4_remove),
+	.remove = mx27vis_aic32x4_remove,
 };
 
 module_platform_driver(mx27vis_aic32x4_audio_driver);
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 144d496..a54ad5b 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -390,7 +390,7 @@ static int __devexit p1022_ds_remove(struct platform_device *pdev)
 
 static struct platform_driver p1022_ds_driver = {
 	.probe = p1022_ds_probe,
-	.remove = __devexit_p(p1022_ds_remove),
+	.remove = p1022_ds_remove,
 	.driver = {
 		/*
 		 * The name must match 'compatible' property in the device tree,
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 897e32f..fa5fd14 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -340,7 +340,7 @@ static int __devexit p1022_rdk_remove(struct platform_device *pdev)
 
 static struct platform_driver p1022_rdk_driver = {
 	.probe = p1022_rdk_probe,
-	.remove = __devexit_p(p1022_rdk_remove),
+	.remove = p1022_rdk_remove,
 	.driver = {
 		/*
 		 * The name must match 'compatible' property in the device tree,
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 4d26192..b4b449c 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -120,7 +120,7 @@ MODULE_DEVICE_TABLE(of, pcm030_audio_match);
 
 static struct platform_driver pcm030_fabric_driver = {
 	.probe		= pcm030_fabric_probe,
-	.remove		= __devexit_p(pcm030_fabric_remove),
+	.remove		= pcm030_fabric_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 4134967..940e0f3 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -512,7 +512,7 @@ static int __devexit jz4740_i2s_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver jz4740_i2s_driver = {
 	.probe = jz4740_i2s_dev_probe,
-	.remove = __devexit_p(jz4740_i2s_dev_remove),
+	.remove = jz4740_i2s_dev_remove,
 	.driver = {
 		.name = "jz4740-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
index 9b8cf25..c7b61ab 100644
--- a/sound/soc/jz4740/jz4740-pcm.c
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -348,7 +348,7 @@ static int __devexit jz4740_pcm_remove(struct platform_device *pdev)
 
 static struct platform_driver jz4740_pcm_driver = {
 	.probe = jz4740_pcm_probe,
-	.remove = __devexit_p(jz4740_pcm_remove),
+	.remove = jz4740_pcm_remove,
 	.driver = {
 		.name = "jz4740-pcm-audio",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index e8aaff1..5c15950 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -131,7 +131,7 @@ static struct platform_driver qi_lb60_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= qi_lb60_probe,
-	.remove		= __devexit_p(qi_lb60_remove),
+	.remove		= qi_lb60_remove,
 };
 
 module_platform_driver(qi_lb60_driver);
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index b9f1659..da85321 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -387,7 +387,7 @@ static struct platform_driver kirkwood_pcm_driver = {
 	},
 
 	.probe = kirkwood_soc_platform_probe,
-	.remove = __devexit_p(kirkwood_soc_platform_remove),
+	.remove = kirkwood_soc_platform_remove,
 };
 
 module_platform_driver(kirkwood_pcm_driver);
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 542538d..4565dc3 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -494,7 +494,7 @@ static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver kirkwood_i2s_driver = {
 	.probe  = kirkwood_i2s_dev_probe,
-	.remove = __devexit_p(kirkwood_i2s_dev_remove),
+	.remove = kirkwood_i2s_dev_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index c28540a..f8518dc 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -99,7 +99,7 @@ static struct platform_driver openrd_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= openrd_probe,
-	.remove		= __devexit_p(openrd_remove),
+	.remove		= openrd_remove,
 };
 
 module_platform_driver(openrd_driver);
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index c67bbc5..d66b21e 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -120,7 +120,7 @@ static struct platform_driver t5325_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= t5325_probe,
-	.remove		= __devexit_p(t5325_remove),
+	.remove		= t5325_remove,
 };
 
 module_platform_driver(t5325_driver);
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 2cc7782..c703870 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -435,7 +435,7 @@ static struct platform_driver snd_mfld_mc_driver = {
 		.name = "msic_audio",
 	},
 	.probe = snd_mfld_mc_probe,
-	.remove = __devexit_p(snd_mfld_mc_remove),
+	.remove = snd_mfld_mc_remove,
 };
 
 module_platform_driver(snd_mfld_mc_driver);
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c294fbb..93fe366 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -806,7 +806,7 @@ MODULE_DEVICE_TABLE(of, mxs_saif_dt_ids);
 
 static struct platform_driver mxs_saif_driver = {
 	.probe = mxs_saif_probe,
-	.remove = __devexit_p(mxs_saif_remove),
+	.remove = mxs_saif_remove,
 
 	.driver = {
 		.name = "mxs-saif",
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 215113b..add904e 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -200,7 +200,7 @@ static struct platform_driver mxs_sgtl5000_audio_driver = {
 		.of_match_table = mxs_sgtl5000_dt_ids,
 	},
 	.probe = mxs_sgtl5000_probe,
-	.remove = __devexit_p(mxs_sgtl5000_remove),
+	.remove = mxs_sgtl5000_remove,
 };
 
 module_platform_driver(mxs_sgtl5000_audio_driver);
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 946020a..a2171bf 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -403,7 +403,7 @@ static struct platform_driver nuc900_ac97_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= nuc900_ac97_drvprobe,
-	.remove		= __devexit_p(nuc900_ac97_drvremove),
+	.remove		= nuc900_ac97_drvremove,
 };
 
 module_platform_driver(nuc900_ac97_driver);
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 37585b4..ca49f9d 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -355,7 +355,7 @@ static struct platform_driver nuc900_pcm_driver = {
 	},
 
 	.probe = nuc900_soc_platform_probe,
-	.remove = __devexit_p(nuc900_soc_platform_remove),
+	.remove = nuc900_soc_platform_remove,
 };
 
 module_platform_driver(nuc900_pcm_driver);
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index d8e96b2..9c0107e 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -616,7 +616,7 @@ static struct platform_driver ams_delta_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ams_delta_probe,
-	.remove = __devexit_p(ams_delta_remove),
+	.remove = ams_delta_remove,
 };
 
 module_platform_driver(ams_delta_driver);
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index a57a4e6..ab439fe 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -417,7 +417,7 @@ static struct platform_driver omap_abe_driver = {
 		.of_match_table = omap_abe_of_match,
 	},
 	.probe = omap_abe_probe,
-	.remove = __devexit_p(omap_abe_remove),
+	.remove = omap_abe_remove,
 };
 
 module_platform_driver(omap_abe_driver);
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 5a6aeaf..d101541 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -541,7 +541,7 @@ static struct platform_driver asoc_dmic_driver = {
 		.of_match_table = omap_dmic_of_match,
 	},
 	.probe = asoc_dmic_probe,
-	.remove = __devexit_p(asoc_dmic_remove),
+	.remove = asoc_dmic_remove,
 };
 
 module_platform_driver(asoc_dmic_driver);
diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index eaa2ea0..290b94c 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -76,7 +76,7 @@ static struct platform_driver omap_hdmi_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = omap_hdmi_probe,
-	.remove = __devexit_p(omap_hdmi_remove),
+	.remove = omap_hdmi_remove,
 };
 
 module_platform_driver(omap_hdmi_driver);
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index f59c69f..7225e7c 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -345,7 +345,7 @@ static struct platform_driver hdmi_dai_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = omap_hdmi_probe,
-	.remove = __devexit_p(omap_hdmi_remove),
+	.remove = omap_hdmi_remove,
 };
 
 module_platform_driver(hdmi_dai_driver);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index a6ee157..734a6dc 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -825,7 +825,7 @@ static struct platform_driver asoc_mcbsp_driver = {
 	},
 
 	.probe = asoc_mcbsp_probe,
-	.remove = __devexit_p(asoc_mcbsp_remove),
+	.remove = asoc_mcbsp_remove,
 };
 
 module_platform_driver(asoc_mcbsp_driver);
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 56965bb..9a37da1 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -507,7 +507,7 @@ static struct platform_driver asoc_mcpdm_driver = {
 	},
 
 	.probe	= asoc_mcpdm_probe,
-	.remove	= __devexit_p(asoc_mcpdm_remove),
+	.remove	= asoc_mcpdm_remove,
 };
 
 module_platform_driver(asoc_mcpdm_driver);
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 52977aa..0fb8614 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -321,7 +321,7 @@ static struct platform_driver omap_pcm_driver = {
 	},
 
 	.probe = omap_pcm_probe,
-	.remove = __devexit_p(omap_pcm_remove),
+	.remove = omap_pcm_remove,
 };
 
 module_platform_driver(omap_pcm_driver);
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 3b97b879..c356c6f 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -177,7 +177,7 @@ static struct platform_driver omap_twl4030_driver = {
 		.of_match_table = omap_twl4030_of_match,
 	},
 	.probe = omap_twl4030_probe,
-	.remove = __devexit_p(omap_twl4030_remove),
+	.remove = omap_twl4030_remove,
 };
 
 module_platform_driver(omap_twl4030_driver);
diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 5e666e0..162532b 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -164,7 +164,7 @@ static struct platform_driver mmp_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= brownstone_probe,
-	.remove		= __devexit_p(brownstone_remove),
+	.remove		= brownstone_remove,
 };
 
 module_platform_driver(mmp_driver);
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 863367a..d74cc33 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -331,7 +331,7 @@ static struct platform_driver corgi_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= corgi_probe,
-	.remove		= __devexit_p(corgi_remove),
+	.remove		= corgi_remove,
 };
 
 module_platform_driver(corgi_driver);
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 7b1bc2390..f2c828e 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -180,7 +180,7 @@ static struct platform_driver e740_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= e740_probe,
-	.remove		= __devexit_p(e740_remove),
+	.remove		= e740_remove,
 };
 
 module_platform_driver(e740_driver);
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 47b89d7..fb38914 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -162,7 +162,7 @@ static struct platform_driver e750_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= e750_probe,
-	.remove		= __devexit_p(e750_remove),
+	.remove		= e750_remove,
 };
 
 module_platform_driver(e750_driver);
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index ea9707e..9a93cae 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -152,7 +152,7 @@ static struct platform_driver e800_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= e800_probe,
-	.remove		= __devexit_p(e800_remove),
+	.remove		= e800_remove,
 };
 
 module_platform_driver(e800_driver);
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 2a342c9..368cd51 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -223,7 +223,7 @@ static struct platform_driver hx4700_audio_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe	= hx4700_audio_probe,
-	.remove	= __devexit_p(hx4700_audio_remove),
+	.remove	= hx4700_audio_remove,
 };
 
 module_platform_driver(hx4700_audio_driver);
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index b93dafd..d8b123b 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -93,7 +93,7 @@ static struct platform_driver imote2_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= imote2_probe,
-	.remove		= __devexit_p(imote2_remove),
+	.remove		= imote2_remove,
 };
 
 module_platform_driver(imote2_driver);
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 8687c1c..c02d1da 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -212,7 +212,7 @@ static int __devexit mioa701_wm9713_remove(struct platform_device *pdev)
 
 static struct platform_driver mioa701_wm9713_driver = {
 	.probe		= mioa701_wm9713_probe,
-	.remove		= __devexit_p(mioa701_wm9713_remove),
+	.remove		= mioa701_wm9713_remove,
 	.driver		= {
 		.name		= "mioa701-wm9713",
 		.owner		= THIS_MODULE,
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index e834faf..3e8cb21 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -287,7 +287,7 @@ static struct platform_driver mmp_pcm_driver = {
 	},
 
 	.probe = mmp_pcm_probe,
-	.remove = __devexit_p(mmp_pcm_remove),
+	.remove = mmp_pcm_remove,
 };
 
 module_platform_driver(mmp_pcm_driver);
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index 4d6cb8a..acdbdcf 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -470,7 +470,7 @@ static struct platform_driver asoc_mmp_sspa_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = asoc_mmp_sspa_probe,
-	.remove = __devexit_p(asoc_mmp_sspa_remove),
+	.remove = asoc_mmp_sspa_remove,
 };
 
 module_platform_driver(asoc_mmp_sspa_driver);
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index aa3da91..b374f09 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -195,7 +195,7 @@ static int __devexit palm27x_asoc_remove(struct platform_device *pdev)
 
 static struct platform_driver palm27x_wm9712_driver = {
 	.probe		= palm27x_asoc_probe,
-	.remove		= __devexit_p(palm27x_asoc_remove),
+	.remove		= palm27x_asoc_remove,
 	.driver		= {
 		.name		= "palm27x-asoc",
 		.owner		= THIS_MODULE,
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index d2cc8173..48ba129 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -305,7 +305,7 @@ static struct platform_driver poodle_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= poodle_probe,
-	.remove		= __devexit_p(poodle_remove),
+	.remove		= poodle_remove,
 };
 
 module_platform_driver(poodle_driver);
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 4da5fc5..9d13de0 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -812,7 +812,7 @@ static struct platform_driver asoc_ssp_driver = {
 	},
 
 	.probe = asoc_ssp_probe,
-	.remove = __devexit_p(asoc_ssp_remove),
+	.remove = asoc_ssp_remove,
 };
 
 module_platform_driver(asoc_ssp_driver);
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 06ea2744..19224cb 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -257,7 +257,7 @@ static int __devexit pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver pxa2xx_ac97_driver = {
 	.probe		= pxa2xx_ac97_dev_probe,
-	.remove		= __devexit_p(pxa2xx_ac97_dev_remove),
+	.remove		= pxa2xx_ac97_dev_remove,
 	.driver		= {
 		.name	= "pxa2xx-ac97",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 3075a42..591ba1d 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -373,7 +373,7 @@ static int __devexit pxa2xx_i2s_drv_remove(struct platform_device *pdev)
 
 static struct platform_driver pxa2xx_i2s_driver = {
 	.probe = pxa2xx_i2s_drv_probe,
-	.remove = __devexit_p(pxa2xx_i2s_drv_remove),
+	.remove = pxa2xx_i2s_drv_remove,
 
 	.driver = {
 		.name = "pxa2xx-i2s",
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index fdd6bed..96cd23d 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -138,7 +138,7 @@ static struct platform_driver pxa_pcm_driver = {
 	},
 
 	.probe = pxa2xx_soc_platform_probe,
-	.remove = __devexit_p(pxa2xx_soc_platform_remove),
+	.remove = pxa2xx_soc_platform_remove,
 };
 
 module_platform_driver(pxa_pcm_driver);
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 2aec63f..fca9e41 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -277,7 +277,7 @@ static struct platform_driver tosa_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= tosa_probe,
-	.remove		= __devexit_p(tosa_remove),
+	.remove		= tosa_remove,
 };
 
 module_platform_driver(tosa_driver);
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 935491a..0e22e68 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -161,7 +161,7 @@ static struct platform_driver ttc_dkb_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ttc_dkb_probe,
-	.remove		= __devexit_p(ttc_dkb_remove),
+	.remove		= ttc_dkb_remove,
 };
 
 module_platform_driver(ttc_dkb_driver);
diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index aaabdba..aa44a4f 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -597,7 +597,7 @@ static void __devexit s6000_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver s6000_i2s_driver = {
 	.probe  = s6000_i2s_probe,
-	.remove = __devexit_p(s6000_i2s_remove),
+	.remove = s6000_i2s_remove,
 	.driver = {
 		.name   = "s6000-i2s",
 		.owner  = THIS_MODULE,
diff --git a/sound/soc/s6000/s6000-pcm.c b/sound/soc/s6000/s6000-pcm.c
index 716da86..af245bc 100644
--- a/sound/soc/s6000/s6000-pcm.c
+++ b/sound/soc/s6000/s6000-pcm.c
@@ -518,7 +518,7 @@ static struct platform_driver s6000_pcm_driver = {
 	},
 
 	.probe = s6000_soc_platform_probe,
-	.remove = __devexit_p(s6000_soc_platform_remove),
+	.remove = s6000_soc_platform_remove,
 };
 
 module_platform_driver(s6000_pcm_driver);
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 386bab1..a9f9632d 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -502,7 +502,7 @@ static __devexit int s3c_ac97_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c_ac97_driver = {
 	.probe  = s3c_ac97_probe,
-	.remove = __devexit_p(s3c_ac97_remove),
+	.remove = s3c_ac97_remove,
 	.driver = {
 		.name = "samsung-ac97",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 3d7ace7..0e02d14 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -443,7 +443,7 @@ static struct platform_driver bells_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bells_probe,
-	.remove = __devexit_p(bells_remove),
+	.remove = bells_remove,
 };
 
 module_platform_driver(bells_driver);
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index b70964e..f02896e 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -450,7 +450,7 @@ static struct platform_driver asoc_dma_driver = {
 	},
 
 	.probe = samsung_asoc_platform_probe,
-	.remove = __devexit_p(samsung_asoc_platform_remove),
+	.remove = samsung_asoc_platform_remove,
 };
 
 module_platform_driver(asoc_dma_driver);
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 547b919..ec4567b 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1142,7 +1142,7 @@ static __devexit int samsung_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver samsung_i2s_driver = {
 	.probe  = samsung_i2s_probe,
-	.remove = __devexit_p(samsung_i2s_remove),
+	.remove = samsung_i2s_remove,
 	.driver = {
 		.name = "samsung-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index c227c31..9db1a5d 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -434,7 +434,7 @@ static struct platform_driver asoc_idma_driver = {
 	},
 
 	.probe = asoc_idma_platform_probe,
-	.remove = __devexit_p(asoc_idma_platform_remove),
+	.remove = asoc_idma_platform_remove,
 };
 
 module_platform_driver(asoc_idma_driver);
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index ee52c8a0..c84e1ac 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -330,7 +330,7 @@ static struct platform_driver littlemill_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = littlemill_probe,
-	.remove = __devexit_p(littlemill_remove),
+	.remove = littlemill_remove,
 };
 
 module_platform_driver(littlemill_driver);
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 6abf341..782ee23 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -213,7 +213,7 @@ static struct platform_driver lowland_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = lowland_probe,
-	.remove = __devexit_p(lowland_remove),
+	.remove = lowland_remove,
 };
 
 module_platform_driver(lowland_driver);
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 45f4a75..918f943 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -629,7 +629,7 @@ static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c_pcm_driver = {
 	.probe  = s3c_pcm_dev_probe,
-	.remove = __devexit_p(s3c_pcm_dev_remove),
+	.remove = s3c_pcm_dev_remove,
 	.driver = {
 		.name = "samsung-pcm",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index ac7701b..83fd46a 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -173,7 +173,7 @@ static __devexit int s3c2412_iis_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c2412_iis_driver = {
 	.probe  = s3c2412_iis_dev_probe,
-	.remove = __devexit_p(s3c2412_iis_dev_remove),
+	.remove = s3c2412_iis_dev_remove,
 	.driver = {
 		.name = "s3c2412-iis",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 0aae3a3..347676f 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -478,7 +478,7 @@ static __devexit int s3c24xx_iis_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c24xx_iis_driver = {
 	.probe  = s3c24xx_iis_dev_probe,
-	.remove = __devexit_p(s3c24xx_iis_dev_remove),
+	.remove = s3c24xx_iis_dev_remove,
 	.driver = {
 		.name = "s3c24xx-iis",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index 7ace6a8..df40b8a 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -112,7 +112,7 @@ static struct platform_driver simtec_audio_hermes_platdrv = {
 		.pm	= simtec_audio_pm,
 	},
 	.probe	= simtec_audio_hermes_probe,
-	.remove	= __devexit_p(simtec_audio_remove),
+	.remove	= simtec_audio_remove,
 };
 
 module_platform_driver(simtec_audio_hermes_platdrv);
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index c42d5f0..2e64534 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -100,7 +100,7 @@ static struct platform_driver simtec_audio_tlv320aic23_driver = {
 		.pm	= simtec_audio_pm,
 	},
 	.probe	= simtec_audio_tlv320aic23_probe,
-	.remove	= __devexit_p(simtec_audio_remove),
+	.remove	= simtec_audio_remove,
 };
 
 module_platform_driver(simtec_audio_tlv320aic23_driver);
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index fab5322..73bef15 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -186,7 +186,7 @@ static struct platform_driver snd_smdk_driver = {
 		.name = "samsung-smdk-pcm",
 	},
 	.probe = snd_smdk_probe,
-	.remove = __devexit_p(snd_smdk_remove),
+	.remove = snd_smdk_remove,
 };
 
 module_platform_driver(snd_smdk_driver);
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 48dd4dd..7707d6e 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -179,7 +179,7 @@ static struct platform_driver smdk_audio_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= smdk_audio_probe,
-	.remove		= __devexit_p(smdk_audio_remove),
+	.remove		= smdk_audio_remove,
 };
 
 module_platform_driver(smdk_audio_driver);
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 77ecba9..8bec27e 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -156,7 +156,7 @@ static struct platform_driver snd_smdk_driver = {
 		.name = "samsung-smdk-pcm",
 	},
 	.probe = snd_smdk_probe,
-	.remove = __devexit_p(snd_smdk_remove),
+	.remove = snd_smdk_remove,
 };
 
 module_platform_driver(snd_smdk_driver);
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 5f3b06d..9275a03 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -476,7 +476,7 @@ static __devexit int spdif_remove(struct platform_device *pdev)
 
 static struct platform_driver samsung_spdif_driver = {
 	.probe	= spdif_probe,
-	.remove	= __devexit_p(spdif_remove),
+	.remove	= spdif_remove,
 	.driver	= {
 		.name	= "samsung-spdif",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index c7e1c28..173f47c 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -353,7 +353,7 @@ static struct platform_driver speyside_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = speyside_probe,
-	.remove = __devexit_p(speyside_remove),
+	.remove = speyside_remove,
 };
 
 module_platform_driver(speyside_driver);
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 9199649..da7ce64 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -247,7 +247,7 @@ static struct platform_driver tobermory_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = tobermory_probe,
-	.remove = __devexit_p(tobermory_remove),
+	.remove = tobermory_remove,
 };
 
 module_platform_driver(tobermory_driver);
diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 7da2018..7a50c2a 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -366,7 +366,7 @@ static struct platform_driver sh7760_pcm_driver = {
 	},
 
 	.probe = sh7760_soc_platform_probe,
-	.remove = __devexit_p(sh7760_soc_platform_remove),
+	.remove = sh7760_soc_platform_remove,
 };
 
 module_platform_driver(sh7760_pcm_driver);
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index 3474d7b..dd00356 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -329,7 +329,7 @@ static struct platform_driver hac_pcm_driver = {
 	},
 
 	.probe = hac_soc_platform_probe,
-	.remove = __devexit_p(hac_soc_platform_remove),
+	.remove = hac_soc_platform_remove,
 };
 
 module_platform_driver(hac_pcm_driver);
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 52d4c17..7b1bc77 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -843,7 +843,7 @@ static struct platform_driver siu_driver = {
 		.name	= "siu-pcm-audio",
 	},
 	.probe		= siu_probe,
-	.remove		= __devexit_p(siu_remove),
+	.remove		= siu_remove,
 };
 
 module_platform_driver(siu_driver);
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index ff82b56..768de1c 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -398,7 +398,7 @@ static struct platform_driver sh4_ssi_driver = {
 	},
 
 	.probe = sh4_soc_dai_probe,
-	.remove = __devexit_p(sh4_soc_dai_remove),
+	.remove = sh4_soc_dai_remove,
 };
 
 module_platform_driver(sh4_ssi_driver);
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 6005370..d9a3ac9 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -125,7 +125,7 @@ static struct platform_driver soc_dummy_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = snd_soc_dummy_probe,
-	.remove = __devexit_p(snd_soc_dummy_remove),
+	.remove = snd_soc_dummy_remove,
 };
 
 static struct platform_device *soc_dummy_dev;
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 8c7f237..9f8f5cd 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -203,7 +203,7 @@ static struct platform_driver spear_pcm_driver = {
 	},
 
 	.probe = spear_soc_platform_probe,
-	.remove = __devexit_p(spear_soc_platform_remove),
+	.remove = spear_soc_platform_remove,
 };
 
 module_platform_driver(spear_pcm_driver);
diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index bf99296b..45c67e0 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -217,7 +217,7 @@ static const struct of_device_id tegra20_das_of_match[] __devinitconst = {
 
 static struct platform_driver tegra20_das_driver = {
 	.probe = tegra20_das_probe,
-	.remove = __devexit_p(tegra20_das_remove),
+	.remove = tegra20_das_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 0832e8a..1892a0c 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -481,7 +481,7 @@ static struct platform_driver tegra20_i2s_driver = {
 		.pm = &tegra20_i2s_pm_ops,
 	},
 	.probe = tegra20_i2s_platform_probe,
-	.remove = __devexit_p(tegra20_i2s_platform_remove),
+	.remove = tegra20_i2s_platform_remove,
 };
 module_platform_driver(tegra20_i2s_driver);
 
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 3ebc867..ee04bae 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -385,7 +385,7 @@ static struct platform_driver tegra20_spdif_driver = {
 		.pm = &tegra20_spdif_pm_ops,
 	},
 	.probe = tegra20_spdif_platform_probe,
-	.remove = __devexit_p(tegra20_spdif_platform_remove),
+	.remove = tegra20_spdif_platform_remove,
 };
 
 module_platform_driver(tegra20_spdif_driver);
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 64b67a3..b167b1f 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -614,7 +614,7 @@ static const struct dev_pm_ops tegra30_ahub_pm_ops __devinitconst = {
 
 static struct platform_driver tegra30_ahub_driver = {
 	.probe = tegra30_ahub_probe,
-	.remove = __devexit_p(tegra30_ahub_remove),
+	.remove = tegra30_ahub_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index 4418422..eb28f27 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -526,7 +526,7 @@ static struct platform_driver tegra30_i2s_driver = {
 		.pm = &tegra30_i2s_pm_ops,
 	},
 	.probe = tegra30_i2s_platform_probe,
-	.remove = __devexit_p(tegra30_i2s_platform_remove),
+	.remove = tegra30_i2s_platform_remove,
 };
 module_platform_driver(tegra30_i2s_driver);
 
diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 76cb1b3..2ccffdb 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -255,7 +255,7 @@ static struct platform_driver tegra_alc5632_driver = {
 		.of_match_table = tegra_alc5632_of_match,
 	},
 	.probe = tegra_alc5632_probe,
-	.remove = __devexit_p(tegra_alc5632_remove),
+	.remove = tegra_alc5632_remove,
 };
 module_platform_driver(tegra_alc5632_driver);
 
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index ea9166d..7512884 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -213,7 +213,7 @@ static struct platform_driver tegra_wm8753_driver = {
 		.of_match_table = tegra_wm8753_of_match,
 	},
 	.probe = tegra_wm8753_driver_probe,
-	.remove = __devexit_p(tegra_wm8753_driver_remove),
+	.remove = tegra_wm8753_driver_remove,
 };
 module_platform_driver(tegra_wm8753_driver);
 
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index cee13b7..a583a6b 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -430,7 +430,7 @@ static struct platform_driver tegra_wm8903_driver = {
 		.of_match_table = tegra_wm8903_of_match,
 	},
 	.probe = tegra_wm8903_driver_probe,
-	.remove = __devexit_p(tegra_wm8903_driver_remove),
+	.remove = tegra_wm8903_driver_remove,
 };
 module_platform_driver(tegra_wm8903_driver);
 
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index e69a4f7..8173551 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -208,7 +208,7 @@ static struct platform_driver tegra_snd_trimslice_driver = {
 		.of_match_table = trimslice_of_match,
 	},
 	.probe = tegra_snd_trimslice_probe,
-	.remove = __devexit_p(tegra_snd_trimslice_remove),
+	.remove = tegra_snd_trimslice_remove,
 };
 module_platform_driver(tegra_snd_trimslice_driver);
 
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 28db4ca..e3dd45e 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -216,7 +216,7 @@ static int __devexit txx9aclc_ac97_dev_remove(struct platform_device *pdev)
 
 static struct platform_driver txx9aclc_ac97_driver = {
 	.probe		= txx9aclc_ac97_dev_probe,
-	.remove		= __devexit_p(txx9aclc_ac97_dev_remove),
+	.remove		= txx9aclc_ac97_dev_remove,
 	.driver		= {
 		.name	= "txx9aclc-ac97",
 		.owner	= THIS_MODULE,
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index b609d2c..856a2cf 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -435,7 +435,7 @@ static struct platform_driver txx9aclc_pcm_driver = {
 	},
 
 	.probe = txx9aclc_soc_platform_probe,
-	.remove = __devexit_p(txx9aclc_soc_platform_remove),
+	.remove = txx9aclc_soc_platform_remove,
 };
 
 module_platform_driver(txx9aclc_pcm_driver);
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 54f7e25..c964d60 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -161,7 +161,7 @@ static struct platform_driver snd_soc_mop500_driver = {
 		.of_match_table = snd_soc_mop500_match,
 	},
 	.probe = mop500_probe,
-	.remove = __devexit_p(mop500_remove),
+	.remove = mop500_remove,
 };
 
 module_platform_driver(snd_soc_mop500_driver);
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index b55b79f..b703532 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -310,7 +310,7 @@ static struct platform_driver ux500_pcm_driver = {
 	},
 
 	.probe = ux500_pcm_drv_probe,
-	.remove = __devexit_p(ux500_pcm_drv_remove),
+	.remove = ux500_pcm_drv_remove,
 };
 module_platform_driver(ux500_pcm_driver);
 
-- 
1.8.0
