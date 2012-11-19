Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 7289E2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:47:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 491/493] sound: remove use of __devexit
Date: Mon, 19 Nov 2012 13:27:20 -0500
Message-Id: <1353349642-3677-491-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
 Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 M R Swami Reddy <mr.swami.reddy@ti.com>,
 device-drivers-devel@blackfin.uclinux.org, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>, patches@opensource.wolfsonmicro.com,
 Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
 Paul Parsons <lost.distance@yahoo.com>,
 Thibaut Varene <T-Bone@parisc-linux.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-samsung-soc@vger.kernel.org,
 Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jaya Kumar <jayakumar.alsa@gmail.com>,
 Eric Miao <eric.y.miao@gmail.com>, linux-parisc@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: Clemens Ladisch <clemens@ladisch.de> 
Cc: Thibaut Varene <T-Bone@parisc-linux.org> 
Cc: Jaya Kumar <jayakumar.alsa@gmail.com> 
Cc: M R Swami Reddy <mr.swami.reddy@ti.com> 
Cc: Vishwas A Deshpande <vishwas.a.deshpande@ti.com> 
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com> 
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com> 
Cc: Philipp Zabel <philipp.zabel@gmail.com> 
Cc: Paul Parsons <lost.distance@yahoo.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: alsa-devel@alsa-project.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-parisc@vger.kernel.org 
Cc: uclinux-dist-devel@blackfin.uclinux.org 
Cc: device-drivers-devel@blackfin.uclinux.org 
Cc: patches@opensource.wolfsonmicro.com 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-omap@vger.kernel.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 sound/arm/aaci.c                         | 2 +-
 sound/arm/pxa2xx-ac97.c                  | 2 +-
 sound/atmel/abdac.c                      | 2 +-
 sound/atmel/ac97c.c                      | 2 +-
 sound/drivers/aloop.c                    | 2 +-
 sound/drivers/dummy.c                    | 2 +-
 sound/drivers/mpu401/mpu401.c            | 4 ++--
 sound/drivers/mtpav.c                    | 2 +-
 sound/drivers/mts64.c                    | 2 +-
 sound/drivers/pcsp/pcsp.c                | 4 ++--
 sound/drivers/portman2x4.c               | 2 +-
 sound/drivers/serial-u16550.c            | 2 +-
 sound/drivers/virmidi.c                  | 2 +-
 sound/firewire/speakers.c                | 2 +-
 sound/isa/ad1816a/ad1816a.c              | 2 +-
 sound/isa/ad1848/ad1848.c                | 2 +-
 sound/isa/adlib.c                        | 2 +-
 sound/isa/als100.c                       | 2 +-
 sound/isa/azt2320.c                      | 2 +-
 sound/isa/cmi8328.c                      | 2 +-
 sound/isa/cmi8330.c                      | 4 ++--
 sound/isa/cs423x/cs4231.c                | 2 +-
 sound/isa/cs423x/cs4236.c                | 6 +++---
 sound/isa/es1688/es1688.c                | 4 ++--
 sound/isa/es18xx.c                       | 6 +++---
 sound/isa/galaxy/galaxy.c                | 2 +-
 sound/isa/gus/gusclassic.c               | 2 +-
 sound/isa/gus/gusextreme.c               | 2 +-
 sound/isa/gus/gusmax.c                   | 2 +-
 sound/isa/gus/interwave.c                | 4 ++--
 sound/isa/msnd/msnd_pinnacle.c           | 6 +++---
 sound/isa/opl3sa2.c                      | 6 +++---
 sound/isa/opti9xx/miro.c                 | 4 ++--
 sound/isa/opti9xx/opti92x-ad1848.c       | 4 ++--
 sound/isa/sb/jazz16.c                    | 2 +-
 sound/isa/sb/sb16.c                      | 4 ++--
 sound/isa/sb/sb8.c                       | 2 +-
 sound/isa/sc6000.c                       | 2 +-
 sound/isa/sscape.c                       | 4 ++--
 sound/isa/wavefront/wavefront.c          | 4 ++--
 sound/mips/hal2.c                        | 2 +-
 sound/mips/sgio2audio.c                  | 2 +-
 sound/oss/kahlua.c                       | 4 ++--
 sound/parisc/harmony.c                   | 2 +-
 sound/pci/ad1889.c                       | 2 +-
 sound/pci/ali5451/ali5451.c              | 2 +-
 sound/pci/als300.c                       | 2 +-
 sound/pci/als4000.c                      | 2 +-
 sound/pci/asihpi/asihpi.c                | 2 +-
 sound/pci/asihpi/hpioctl.c               | 2 +-
 sound/pci/asihpi/hpioctl.h               | 2 +-
 sound/pci/atiixp.c                       | 2 +-
 sound/pci/atiixp_modem.c                 | 2 +-
 sound/pci/au88x0/au88x0.c                | 2 +-
 sound/pci/aw2/aw2-alsa.c                 | 4 ++--
 sound/pci/azt3328.c                      | 2 +-
 sound/pci/bt87x.c                        | 2 +-
 sound/pci/ca0106/ca0106_main.c           | 2 +-
 sound/pci/cmipci.c                       | 2 +-
 sound/pci/cs4281.c                       | 2 +-
 sound/pci/cs46xx/cs46xx.c                | 2 +-
 sound/pci/cs5530.c                       | 2 +-
 sound/pci/cs5535audio/cs5535audio.c      | 2 +-
 sound/pci/cs5535audio/cs5535audio.h      | 2 +-
 sound/pci/cs5535audio/cs5535audio_olpc.c | 2 +-
 sound/pci/ctxfi/xfi.c                    | 2 +-
 sound/pci/echoaudio/echoaudio.c          | 2 +-
 sound/pci/emu10k1/emu10k1.c              | 2 +-
 sound/pci/emu10k1/emu10k1x.c             | 2 +-
 sound/pci/ens1370.c                      | 2 +-
 sound/pci/es1938.c                       | 2 +-
 sound/pci/es1968.c                       | 2 +-
 sound/pci/fm801.c                        | 2 +-
 sound/pci/hda/hda_intel.c                | 2 +-
 sound/pci/ice1712/ice1712.c              | 2 +-
 sound/pci/ice1712/ice1724.c              | 2 +-
 sound/pci/intel8x0.c                     | 2 +-
 sound/pci/intel8x0m.c                    | 2 +-
 sound/pci/korg1212/korg1212.c            | 2 +-
 sound/pci/lola/lola.c                    | 2 +-
 sound/pci/lx6464es/lx6464es.c            | 2 +-
 sound/pci/maestro3.c                     | 2 +-
 sound/pci/mixart/mixart.c                | 2 +-
 sound/pci/nm256/nm256.c                  | 2 +-
 sound/pci/pcxhr/pcxhr.c                  | 2 +-
 sound/pci/riptide/riptide.c              | 4 ++--
 sound/pci/rme32.c                        | 2 +-
 sound/pci/rme96.c                        | 2 +-
 sound/pci/rme9652/hdsp.c                 | 2 +-
 sound/pci/rme9652/hdspm.c                | 2 +-
 sound/pci/rme9652/rme9652.c              | 2 +-
 sound/pci/sis7019.c                      | 2 +-
 sound/pci/sonicvibes.c                   | 2 +-
 sound/pci/trident/trident.c              | 2 +-
 sound/pci/via82xx.c                      | 2 +-
 sound/pci/via82xx_modem.c                | 2 +-
 sound/pci/vx222/vx222.c                  | 2 +-
 sound/pci/ymfpci/ymfpci.c                | 2 +-
 sound/ppc/powermac.c                     | 2 +-
 sound/sh/aica.c                          | 2 +-
 sound/soc/atmel/atmel-pcm.c              | 2 +-
 sound/soc/atmel/atmel_ssc_dai.c          | 2 +-
 sound/soc/atmel/sam9g20_wm8731.c         | 2 +-
 sound/soc/au1x/ac97c.c                   | 2 +-
 sound/soc/au1x/db1000.c                  | 2 +-
 sound/soc/au1x/db1200.c                  | 2 +-
 sound/soc/au1x/dbdma2.c                  | 2 +-
 sound/soc/au1x/dma.c                     | 2 +-
 sound/soc/au1x/i2sc.c                    | 2 +-
 sound/soc/au1x/psc-ac97.c                | 2 +-
 sound/soc/au1x/psc-i2s.c                 | 2 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c      | 2 +-
 sound/soc/blackfin/bf5xx-ac97.c          | 2 +-
 sound/soc/blackfin/bf5xx-ad1836.c        | 2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c       | 2 +-
 sound/soc/blackfin/bf5xx-i2s.c           | 2 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c       | 2 +-
 sound/soc/blackfin/bf5xx-tdm.c           | 2 +-
 sound/soc/blackfin/bf6xx-i2s.c           | 2 +-
 sound/soc/blackfin/bfin-eval-adau1373.c  | 2 +-
 sound/soc/blackfin/bfin-eval-adau1701.c  | 2 +-
 sound/soc/blackfin/bfin-eval-adav80x.c   | 2 +-
 sound/soc/cirrus/edb93xx.c               | 2 +-
 sound/soc/cirrus/ep93xx-ac97.c           | 2 +-
 sound/soc/cirrus/ep93xx-i2s.c            | 2 +-
 sound/soc/cirrus/ep93xx-pcm.c            | 2 +-
 sound/soc/cirrus/simone.c                | 2 +-
 sound/soc/cirrus/snappercl15.c           | 2 +-
 sound/soc/codecs/88pm860x-codec.c        | 2 +-
 sound/soc/codecs/ab8500-codec.c          | 2 +-
 sound/soc/codecs/ac97.c                  | 2 +-
 sound/soc/codecs/ad1836.c                | 2 +-
 sound/soc/codecs/ad193x.c                | 4 ++--
 sound/soc/codecs/ad1980.c                | 2 +-
 sound/soc/codecs/ad73311.c               | 2 +-
 sound/soc/codecs/adau1373.c              | 2 +-
 sound/soc/codecs/adau1701.c              | 2 +-
 sound/soc/codecs/adav80x.c               | 6 +++---
 sound/soc/codecs/ads117x.c               | 2 +-
 sound/soc/codecs/ak4104.c                | 2 +-
 sound/soc/codecs/ak4535.c                | 2 +-
 sound/soc/codecs/ak4641.c                | 2 +-
 sound/soc/codecs/ak4642.c                | 2 +-
 sound/soc/codecs/ak4671.c                | 2 +-
 sound/soc/codecs/alc5623.c               | 2 +-
 sound/soc/codecs/alc5632.c               | 2 +-
 sound/soc/codecs/cs4271.c                | 4 ++--
 sound/soc/codecs/cs42l73.c               | 2 +-
 sound/soc/codecs/da7210.c                | 4 ++--
 sound/soc/codecs/da732x.c                | 2 +-
 sound/soc/codecs/da9055.c                | 2 +-
 sound/soc/codecs/dfbmcs320.c             | 2 +-
 sound/soc/codecs/dmic.c                  | 2 +-
 sound/soc/codecs/isabelle.c              | 2 +-
 sound/soc/codecs/jz4740.c                | 2 +-
 sound/soc/codecs/lm4857.c                | 2 +-
 sound/soc/codecs/lm49453.c               | 2 +-
 sound/soc/codecs/max9768.c               | 2 +-
 sound/soc/codecs/max98088.c              | 2 +-
 sound/soc/codecs/max98095.c              | 2 +-
 sound/soc/codecs/max9850.c               | 2 +-
 sound/soc/codecs/max9877.c               | 2 +-
 sound/soc/codecs/ml26124.c               | 2 +-
 sound/soc/codecs/omap-hdmi.c             | 2 +-
 sound/soc/codecs/pcm3008.c               | 2 +-
 sound/soc/codecs/rt5631.c                | 2 +-
 sound/soc/codecs/sgtl5000.c              | 2 +-
 sound/soc/codecs/si476x.c                | 2 +-
 sound/soc/codecs/sn95031.c               | 2 +-
 sound/soc/codecs/ssm2602.c               | 4 ++--
 sound/soc/codecs/sta32x.c                | 2 +-
 sound/soc/codecs/sta529.c                | 2 +-
 sound/soc/codecs/stac9766.c              | 2 +-
 sound/soc/codecs/tlv320aic32x4.c         | 2 +-
 sound/soc/codecs/tlv320dac33.c           | 2 +-
 sound/soc/codecs/tpa6130a2.c             | 2 +-
 sound/soc/codecs/twl4030.c               | 2 +-
 sound/soc/codecs/twl6040.c               | 2 +-
 sound/soc/codecs/uda134x.c               | 2 +-
 sound/soc/codecs/uda1380.c               | 2 +-
 sound/soc/codecs/wl1273.c                | 2 +-
 sound/soc/codecs/wm0010.c                | 2 +-
 sound/soc/codecs/wm1250-ev1.c            | 2 +-
 sound/soc/codecs/wm2000.c                | 2 +-
 sound/soc/codecs/wm2200.c                | 2 +-
 sound/soc/codecs/wm5100.c                | 2 +-
 sound/soc/codecs/wm5102.c                | 2 +-
 sound/soc/codecs/wm5110.c                | 2 +-
 sound/soc/codecs/wm8350.c                | 2 +-
 sound/soc/codecs/wm8400.c                | 2 +-
 sound/soc/codecs/wm8510.c                | 4 ++--
 sound/soc/codecs/wm8523.c                | 2 +-
 sound/soc/codecs/wm8711.c                | 4 ++--
 sound/soc/codecs/wm8727.c                | 2 +-
 sound/soc/codecs/wm8728.c                | 4 ++--
 sound/soc/codecs/wm8731.c                | 4 ++--
 sound/soc/codecs/wm8737.c                | 4 ++--
 sound/soc/codecs/wm8741.c                | 2 +-
 sound/soc/codecs/wm8750.c                | 4 ++--
 sound/soc/codecs/wm8753.c                | 4 ++--
 sound/soc/codecs/wm8770.c                | 2 +-
 sound/soc/codecs/wm8776.c                | 4 ++--
 sound/soc/codecs/wm8782.c                | 2 +-
 sound/soc/codecs/wm8804.c                | 4 ++--
 sound/soc/codecs/wm8900.c                | 4 ++--
 sound/soc/codecs/wm8903.c                | 2 +-
 sound/soc/codecs/wm8904.c                | 2 +-
 sound/soc/codecs/wm8940.c                | 2 +-
 sound/soc/codecs/wm8955.c                | 2 +-
 sound/soc/codecs/wm8960.c                | 2 +-
 sound/soc/codecs/wm8961.c                | 2 +-
 sound/soc/codecs/wm8962.c                | 2 +-
 sound/soc/codecs/wm8971.c                | 2 +-
 sound/soc/codecs/wm8974.c                | 2 +-
 sound/soc/codecs/wm8978.c                | 2 +-
 sound/soc/codecs/wm8983.c                | 4 ++--
 sound/soc/codecs/wm8985.c                | 4 ++--
 sound/soc/codecs/wm8988.c                | 4 ++--
 sound/soc/codecs/wm8990.c                | 2 +-
 sound/soc/codecs/wm8991.c                | 2 +-
 sound/soc/codecs/wm8993.c                | 2 +-
 sound/soc/codecs/wm8994.c                | 2 +-
 sound/soc/codecs/wm8995.c                | 4 ++--
 sound/soc/codecs/wm8996.c                | 2 +-
 sound/soc/codecs/wm9081.c                | 2 +-
 sound/soc/codecs/wm9090.c                | 2 +-
 sound/soc/codecs/wm9705.c                | 2 +-
 sound/soc/codecs/wm9712.c                | 2 +-
 sound/soc/codecs/wm9713.c                | 2 +-
 sound/soc/fsl/eukrea-tlv320.c            | 2 +-
 sound/soc/fsl/fsl_dma.c                  | 2 +-
 sound/soc/fsl/imx-audmux.c               | 4 ++--
 sound/soc/fsl/imx-mc13783.c              | 2 +-
 sound/soc/fsl/imx-pcm-dma.c              | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c              | 2 +-
 sound/soc/fsl/imx-sgtl5000.c             | 2 +-
 sound/soc/fsl/imx-ssi.c                  | 2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c         | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c          | 2 +-
 sound/soc/fsl/mpc8610_hpcd.c             | 2 +-
 sound/soc/fsl/mx27vis-aic32x4.c          | 2 +-
 sound/soc/fsl/p1022_ds.c                 | 2 +-
 sound/soc/fsl/p1022_rdk.c                | 2 +-
 sound/soc/fsl/pcm030-audio-fabric.c      | 2 +-
 sound/soc/jz4740/jz4740-i2s.c            | 2 +-
 sound/soc/jz4740/jz4740-pcm.c            | 2 +-
 sound/soc/jz4740/qi_lb60.c               | 2 +-
 sound/soc/kirkwood/kirkwood-dma.c        | 2 +-
 sound/soc/kirkwood/kirkwood-i2s.c        | 2 +-
 sound/soc/kirkwood/kirkwood-openrd.c     | 2 +-
 sound/soc/kirkwood/kirkwood-t5325.c      | 2 +-
 sound/soc/mid-x86/mfld_machine.c         | 2 +-
 sound/soc/mxs/mxs-pcm.c                  | 2 +-
 sound/soc/mxs/mxs-saif.c                 | 2 +-
 sound/soc/mxs/mxs-sgtl5000.c             | 2 +-
 sound/soc/nuc900/nuc900-ac97.c           | 2 +-
 sound/soc/nuc900/nuc900-pcm.c            | 2 +-
 sound/soc/omap/ams-delta.c               | 2 +-
 sound/soc/omap/mcbsp.c                   | 2 +-
 sound/soc/omap/mcbsp.h                   | 2 +-
 sound/soc/omap/omap-abe-twl6040.c        | 2 +-
 sound/soc/omap/omap-dmic.c               | 2 +-
 sound/soc/omap/omap-hdmi-card.c          | 2 +-
 sound/soc/omap/omap-hdmi.c               | 2 +-
 sound/soc/omap/omap-mcbsp.c              | 2 +-
 sound/soc/omap/omap-mcpdm.c              | 2 +-
 sound/soc/omap/omap-pcm.c                | 2 +-
 sound/soc/omap/omap-twl4030.c            | 2 +-
 sound/soc/pxa/brownstone.c               | 2 +-
 sound/soc/pxa/corgi.c                    | 2 +-
 sound/soc/pxa/e740_wm9705.c              | 2 +-
 sound/soc/pxa/e750_wm9705.c              | 2 +-
 sound/soc/pxa/e800_wm9712.c              | 2 +-
 sound/soc/pxa/hx4700.c                   | 2 +-
 sound/soc/pxa/imote2.c                   | 2 +-
 sound/soc/pxa/mioa701_wm9713.c           | 2 +-
 sound/soc/pxa/mmp-pcm.c                  | 2 +-
 sound/soc/pxa/mmp-sspa.c                 | 2 +-
 sound/soc/pxa/palm27x.c                  | 2 +-
 sound/soc/pxa/poodle.c                   | 2 +-
 sound/soc/pxa/pxa-ssp.c                  | 2 +-
 sound/soc/pxa/pxa2xx-ac97.c              | 2 +-
 sound/soc/pxa/pxa2xx-i2s.c               | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c               | 2 +-
 sound/soc/pxa/tosa.c                     | 2 +-
 sound/soc/pxa/ttc-dkb.c                  | 2 +-
 sound/soc/s6000/s6000-i2s.c              | 2 +-
 sound/soc/s6000/s6000-pcm.c              | 2 +-
 sound/soc/samsung/ac97.c                 | 2 +-
 sound/soc/samsung/bells.c                | 2 +-
 sound/soc/samsung/dma.c                  | 2 +-
 sound/soc/samsung/i2s.c                  | 2 +-
 sound/soc/samsung/idma.c                 | 2 +-
 sound/soc/samsung/littlemill.c           | 2 +-
 sound/soc/samsung/lowland.c              | 2 +-
 sound/soc/samsung/pcm.c                  | 2 +-
 sound/soc/samsung/s3c2412-i2s.c          | 2 +-
 sound/soc/samsung/s3c24xx-i2s.c          | 2 +-
 sound/soc/samsung/s3c24xx_simtec.c       | 2 +-
 sound/soc/samsung/smdk_wm8580pcm.c       | 2 +-
 sound/soc/samsung/smdk_wm8994.c          | 2 +-
 sound/soc/samsung/smdk_wm8994pcm.c       | 2 +-
 sound/soc/samsung/spdif.c                | 2 +-
 sound/soc/samsung/speyside.c             | 2 +-
 sound/soc/samsung/tobermory.c            | 2 +-
 sound/soc/sh/dma-sh7760.c                | 2 +-
 sound/soc/sh/hac.c                       | 2 +-
 sound/soc/sh/siu_dai.c                   | 2 +-
 sound/soc/sh/ssi.c                       | 2 +-
 sound/soc/soc-utils.c                    | 2 +-
 sound/soc/spear/spear_pcm.c              | 2 +-
 sound/soc/tegra/tegra20_das.c            | 2 +-
 sound/soc/tegra/tegra20_i2s.c            | 2 +-
 sound/soc/tegra/tegra20_spdif.c          | 2 +-
 sound/soc/tegra/tegra30_ahub.c           | 2 +-
 sound/soc/tegra/tegra30_i2s.c            | 2 +-
 sound/soc/tegra/tegra_alc5632.c          | 2 +-
 sound/soc/tegra/tegra_pcm.c              | 2 +-
 sound/soc/tegra/tegra_wm8753.c           | 2 +-
 sound/soc/tegra/tegra_wm8903.c           | 2 +-
 sound/soc/tegra/trimslice.c              | 2 +-
 sound/soc/txx9/txx9aclc-ac97.c           | 2 +-
 sound/soc/txx9/txx9aclc.c                | 2 +-
 sound/soc/ux500/mop500.c                 | 2 +-
 sound/soc/ux500/ux500_msp_dai.c          | 2 +-
 sound/soc/ux500/ux500_pcm.c              | 2 +-
 sound/sparc/cs4231.c                     | 2 +-
 sound/sparc/dbri.c                       | 2 +-
 sound/spi/at73c213.c                     | 2 +-
 329 files changed, 371 insertions(+), 371 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index e54a83e..63b1e14 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1072,7 +1072,7 @@ static int aaci_probe(struct amba_device *dev,
 	return ret;
 }
 
-static int __devexit aaci_remove(struct amba_device *dev)
+static int aaci_remove(struct amba_device *dev)
 {
 	struct snd_card *card = amba_get_drvdata(dev);
 
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 59ffc3e..ec54be4 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -224,7 +224,7 @@ err_dev:
 	return ret;
 }
 
-static int __devexit pxa2xx_ac97_remove(struct platform_device *dev)
+static int pxa2xx_ac97_remove(struct platform_device *dev)
 {
 	struct snd_card *card = platform_get_drvdata(dev);
 
diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index d3b9cf5..071ce1b 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -567,7 +567,7 @@ static SIMPLE_DEV_PM_OPS(atmel_abdac_pm, atmel_abdac_suspend, atmel_abdac_resume
 #define ATMEL_ABDAC_PM_OPS	NULL
 #endif
 
-static int __devexit atmel_abdac_remove(struct platform_device *pdev)
+static int atmel_abdac_remove(struct platform_device *pdev)
 {
 	struct snd_card *card = platform_get_drvdata(pdev);
 	struct atmel_abdac *dac = get_dac(card);
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 7b5664f..79d6bda 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -1168,7 +1168,7 @@ static SIMPLE_DEV_PM_OPS(atmel_ac97c_pm, atmel_ac97c_suspend, atmel_ac97c_resume
 #define ATMEL_AC97C_PM_OPS	NULL
 #endif
 
-static int __devexit atmel_ac97c_remove(struct platform_device *pdev)
+static int atmel_ac97c_remove(struct platform_device *pdev)
 {
 	struct snd_card *card = platform_get_drvdata(pdev);
 	struct atmel_ac97c *chip = get_chip(card);
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 542a5b7..7a7a5cb 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1177,7 +1177,7 @@ static int loopback_probe(struct platform_device *devptr)
 	return err;
 }
 
-static int __devexit loopback_remove(struct platform_device *devptr)
+static int loopback_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
 	platform_set_drvdata(devptr, NULL);
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 7cfb2f2..7a1d41a 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1126,7 +1126,7 @@ static int snd_dummy_probe(struct platform_device *devptr)
 	return err;
 }
 
-static int __devexit snd_dummy_remove(struct platform_device *devptr)
+static int snd_dummy_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
 	platform_set_drvdata(devptr, NULL);
diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index 5c10699..b99415f 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -126,7 +126,7 @@ static int snd_mpu401_probe(struct platform_device *devptr)
 	return 0;
 }
 
-static int __devexit snd_mpu401_remove(struct platform_device *devptr)
+static int snd_mpu401_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
 	platform_set_drvdata(devptr, NULL);
@@ -211,7 +211,7 @@ static int snd_mpu401_pnp_probe(struct pnp_dev *pnp_dev,
 	return -ENODEV;
 }
 
-static void __devexit snd_mpu401_pnp_remove(struct pnp_dev *dev)
+static void snd_mpu401_pnp_remove(struct pnp_dev *dev)
 {
 	struct snd_card *card = (struct snd_card *) pnp_get_drvdata(dev);
 
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index 8fd51d5..88cc634 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -746,7 +746,7 @@ static int snd_mtpav_probe(struct platform_device *dev)
 	return err;
 }
 
-static int __devexit snd_mtpav_remove(struct platform_device *devptr)
+static int snd_mtpav_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
 	platform_set_drvdata(devptr, NULL);
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index f1d463e..5eec128 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -1025,7 +1025,7 @@ __err:
 	return err;
 }
 
-static int __devexit snd_mts64_remove(struct platform_device *pdev)
+static int snd_mts64_remove(struct platform_device *pdev)
 {
 	struct snd_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 0ad0105..7a5fdb9 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -161,7 +161,7 @@ static int alsa_card_pcsp_init(struct device *dev)
 	return 0;
 }
 
-static void __devexit alsa_card_pcsp_exit(struct snd_pcsp *chip)
+static void alsa_card_pcsp_exit(struct snd_pcsp *chip)
 {
 	snd_card_free(chip->card);
 }
@@ -184,7 +184,7 @@ static int pcsp_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit pcsp_remove(struct platform_device *dev)
+static int pcsp_remove(struct platform_device *dev)
 {
 	struct snd_pcsp *chip = platform_get_drvdata(dev);
 	alsa_card_pcsp_exit(chip);
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index bc4be6f..66996f3 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -814,7 +814,7 @@ __err:
 	return err;
 }
 
-static int __devexit snd_portman_remove(struct platform_device *pdev)
+static int snd_portman_remove(struct platform_device *pdev)
 {
 	struct snd_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 310b075..9b0a139 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -982,7 +982,7 @@ static int snd_serial_probe(struct platform_device *devptr)
 	return err;
 }
 
-static int __devexit snd_serial_remove(struct platform_device *devptr)
+static int snd_serial_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
 	platform_set_drvdata(devptr, NULL);
diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index ab3ec53..cc4be88 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -129,7 +129,7 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 	return err;
 }
 
-static int __devexit snd_virmidi_remove(struct platform_device *devptr)
+static int snd_virmidi_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
 	platform_set_drvdata(devptr, NULL);
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 3ac0b9ed..d684655 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -770,7 +770,7 @@ error:
 	return err;
 }
 
-static int __devexit fwspk_remove(struct device *dev)
+static int fwspk_remove(struct device *dev)
 {
 	struct fwspk *fwspk = dev_get_drvdata(dev);
 
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index f63bf61..5640370 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -238,7 +238,7 @@ static int snd_ad1816a_pnp_detect(struct pnp_card_link *card,
         return -ENODEV;
 }
 
-static void __devexit snd_ad1816a_pnp_remove(struct pnp_card_link * pcard)
+static void snd_ad1816a_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index 3cef9ec..c214ecf 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -132,7 +132,7 @@ out:	snd_card_free(card);
 	return error;
 }
 
-static int __devexit snd_ad1848_remove(struct device *dev, unsigned int n)
+static int snd_ad1848_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index 6a1c666..d265455 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -98,7 +98,7 @@ out:	snd_card_free(card);
 	return error;
 }
 
-static int __devexit snd_adlib_remove(struct device *dev, unsigned int n)
+static int snd_adlib_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index b282f007..c395ac3 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -307,7 +307,7 @@ static int snd_als100_pnp_detect(struct pnp_card_link *card,
 	return -ENODEV;
 }
 
-static void __devexit snd_als100_pnp_remove(struct pnp_card_link * pcard)
+static void snd_als100_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index 19b1fee..c83418d 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -285,7 +285,7 @@ static int snd_azt2320_pnp_detect(struct pnp_card_link *card,
         return -ENODEV;
 }
 
-static void __devexit snd_azt2320_pnp_remove(struct pnp_card_link * pcard)
+static void snd_azt2320_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index 6dfead9..a7369fe 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -401,7 +401,7 @@ error:
 	return err;
 }
 
-static int __devexit snd_cmi8328_remove(struct device *pdev, unsigned int dev)
+static int snd_cmi8328_remove(struct device *pdev, unsigned int dev)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
 	struct snd_cmi8328 *cmi = card->private_data;
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index e294e22..d96641c 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -647,7 +647,7 @@ static int snd_cmi8330_isa_probe(struct device *pdev,
 	return 0;
 }
 
-static int __devexit snd_cmi8330_isa_remove(struct device *devptr,
+static int snd_cmi8330_isa_remove(struct device *devptr,
 					    unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
@@ -717,7 +717,7 @@ static int snd_cmi8330_pnp_detect(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_cmi8330_pnp_remove(struct pnp_card_link * pcard)
+static void snd_cmi8330_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index ece5d8f..aa7a5d8 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -148,7 +148,7 @@ out:	snd_card_free(card);
 	return error;
 }
 
-static int __devexit snd_cs4231_remove(struct device *dev, unsigned int n)
+static int snd_cs4231_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 752ccba..10602b8 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -500,7 +500,7 @@ static int snd_cs423x_isa_probe(struct device *pdev,
 	return 0;
 }
 
-static int __devexit snd_cs423x_isa_remove(struct device *pdev,
+static int snd_cs423x_isa_remove(struct device *pdev,
 					   unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(pdev));
@@ -597,7 +597,7 @@ static int snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
 	return 0;
 }
 
-static void __devexit snd_cs423x_pnp_remove(struct pnp_dev *pdev)
+static void snd_cs423x_pnp_remove(struct pnp_dev *pdev)
 {
 	snd_card_free(pnp_get_drvdata(pdev));
 	pnp_set_drvdata(pdev, NULL);
@@ -659,7 +659,7 @@ static int snd_cs423x_pnpc_detect(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_cs423x_pnpc_remove(struct pnp_card_link * pcard)
+static void snd_cs423x_pnpc_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index f62803b..a964e56 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -210,7 +210,7 @@ out:
 	return error;
 }
 
-static int __devexit snd_es1688_isa_remove(struct device *dev, unsigned int n)
+static int snd_es1688_isa_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
@@ -295,7 +295,7 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_es968_pnp_remove(struct pnp_card_link * pcard)
+static void snd_es968_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 8fe5dc1..45e259f 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -2231,7 +2231,7 @@ static int snd_es18xx_isa_probe(struct device *pdev, unsigned int dev)
 	}
 }
 
-static int __devexit snd_es18xx_isa_remove(struct device *devptr,
+static int snd_es18xx_isa_remove(struct device *devptr,
 					   unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
@@ -2302,7 +2302,7 @@ static int snd_audiodrive_pnp_detect(struct pnp_dev *pdev,
 	return 0;
 }
 
-static void __devexit snd_audiodrive_pnp_remove(struct pnp_dev * pdev)
+static void snd_audiodrive_pnp_remove(struct pnp_dev * pdev)
 {
 	snd_card_free(pnp_get_drvdata(pdev));
 	pnp_set_drvdata(pdev, NULL);
@@ -2363,7 +2363,7 @@ static int snd_audiodrive_pnpc_detect(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_audiodrive_pnpc_remove(struct pnp_card_link * pcard)
+static void snd_audiodrive_pnpc_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index 6955e78..672184e 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -620,7 +620,7 @@ error:
 	return err;
 }
 
-static int __devexit snd_galaxy_remove(struct device *dev, unsigned int n)
+static int snd_galaxy_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index 4a4c856..3a85beb 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -211,7 +211,7 @@ out:	snd_card_free(card);
 	return error;
 }
 
-static int __devexit snd_gusclassic_remove(struct device *dev, unsigned int n)
+static int snd_gusclassic_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index e8ee416..99ab85c 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -339,7 +339,7 @@ out:	snd_card_free(card);
 	return error;
 }
 
-static int __devexit snd_gusextreme_remove(struct device *dev, unsigned int n)
+static int snd_gusextreme_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 6e297c8..69477d3 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -354,7 +354,7 @@ static int snd_gusmax_probe(struct device *pdev, unsigned int dev)
 	return err;
 }
 
-static int __devexit snd_gusmax_remove(struct device *devptr, unsigned int dev)
+static int snd_gusmax_remove(struct device *devptr, unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
 	dev_set_drvdata(devptr, NULL);
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index b5f436a..02d1dd0 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -846,7 +846,7 @@ static int snd_interwave_isa_probe(struct device *pdev,
 	}
 }
 
-static int __devexit snd_interwave_isa_remove(struct device *devptr, unsigned int dev)
+static int snd_interwave_isa_remove(struct device *devptr, unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
 	dev_set_drvdata(devptr, NULL);
@@ -896,7 +896,7 @@ static int snd_interwave_pnp_detect(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_interwave_pnp_remove(struct pnp_card_link * pcard)
+static void snd_interwave_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 75f297e..c57216d 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -634,7 +634,7 @@ err_release_region:
 }
 
 
-static void __devexit snd_msnd_unload(struct snd_card *card)
+static void snd_msnd_unload(struct snd_card *card)
 {
 	struct snd_msnd *chip = card->private_data;
 
@@ -1061,7 +1061,7 @@ cfg_error:
 #endif
 }
 
-static int __devexit snd_msnd_isa_remove(struct device *pdev, unsigned int dev)
+static int snd_msnd_isa_remove(struct device *pdev, unsigned int dev)
 {
 	snd_msnd_unload(dev_get_drvdata(pdev));
 	dev_set_drvdata(pdev, NULL);
@@ -1185,7 +1185,7 @@ _release_card:
 	return ret;
 }
 
-static void __devexit snd_msnd_pnp_remove(struct pnp_card_link *pcard)
+static void snd_msnd_pnp_remove(struct pnp_card_link *pcard)
 {
 	snd_msnd_unload(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 9f71f956..cdbfb17 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -754,7 +754,7 @@ static int snd_opl3sa2_pnp_detect(struct pnp_dev *pdev,
 	return 0;
 }
 
-static void __devexit snd_opl3sa2_pnp_remove(struct pnp_dev * pdev)
+static void snd_opl3sa2_pnp_remove(struct pnp_dev * pdev)
 {
 	snd_card_free(pnp_get_drvdata(pdev));
 	pnp_set_drvdata(pdev, NULL);
@@ -820,7 +820,7 @@ static int snd_opl3sa2_pnp_cdetect(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_opl3sa2_pnp_cremove(struct pnp_card_link * pcard)
+static void snd_opl3sa2_pnp_cremove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
@@ -896,7 +896,7 @@ static int snd_opl3sa2_isa_probe(struct device *pdev,
 	return 0;
 }
 
-static int __devexit snd_opl3sa2_isa_remove(struct device *devptr,
+static int snd_opl3sa2_isa_remove(struct device *devptr,
 					    unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index f8747ab..f4f0e7d 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1491,7 +1491,7 @@ static int snd_miro_isa_probe(struct device *devptr, unsigned int n)
 	return 0;
 }
 
-static int __devexit snd_miro_isa_remove(struct device *devptr,
+static int snd_miro_isa_remove(struct device *devptr,
 					 unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
@@ -1624,7 +1624,7 @@ static int snd_miro_pnp_probe(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_miro_pnp_remove(struct pnp_card_link * pcard)
+static void snd_miro_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 4a0d193..4a69f7e 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1031,7 +1031,7 @@ static int snd_opti9xx_isa_probe(struct device *devptr,
 	return 0;
 }
 
-static int __devexit snd_opti9xx_isa_remove(struct device *devptr,
+static int snd_opti9xx_isa_remove(struct device *devptr,
 					    unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
@@ -1146,7 +1146,7 @@ static int snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_opti9xx_pnp_remove(struct pnp_card_link * pcard)
+static void snd_opti9xx_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 5bc42fe..0560d07 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -341,7 +341,7 @@ err_free:
 	return err;
 }
 
-static int __devexit snd_jazz16_remove(struct device *devptr, unsigned int dev)
+static int snd_jazz16_remove(struct device *devptr, unsigned int dev)
 {
 	struct snd_card *card = dev_get_drvdata(devptr);
 
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index fcb14b8..e44a645 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -563,7 +563,7 @@ static int snd_sb16_isa_probe(struct device *pdev, unsigned int dev)
 	}
 }
 
-static int __devexit snd_sb16_isa_remove(struct device *pdev, unsigned int dev)
+static int snd_sb16_isa_remove(struct device *pdev, unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(pdev));
 	dev_set_drvdata(pdev, NULL);
@@ -631,7 +631,7 @@ static int snd_sb16_pnp_detect(struct pnp_card_link *pcard,
 	return -ENODEV;
 }
 
-static void __devexit snd_sb16_pnp_remove(struct pnp_card_link * pcard)
+static void snd_sb16_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index 69aa275..237d964 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -205,7 +205,7 @@ static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 	return err;
 }
 
-static int __devexit snd_sb8_remove(struct device *pdev, unsigned int dev)
+static int snd_sb8_remove(struct device *pdev, unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(pdev));
 	dev_set_drvdata(pdev, NULL);
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 486da56..fc648f2 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -687,7 +687,7 @@ err_exit:
 	return err;
 }
 
-static int __devexit snd_sc6000_remove(struct device *devptr, unsigned int dev)
+static int snd_sc6000_remove(struct device *devptr, unsigned int dev)
 {
 	struct snd_card *card = dev_get_drvdata(devptr);
 	char __iomem **vport = card->private_data;
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 0b67a79..fc4ff0f 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -1197,7 +1197,7 @@ _release_card:
 	return ret;
 }
 
-static int __devexit snd_sscape_remove(struct device *devptr, unsigned int dev)
+static int snd_sscape_remove(struct device *devptr, unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
 	dev_set_drvdata(devptr, NULL);
@@ -1310,7 +1310,7 @@ _release_card:
 	return ret;
 }
 
-static void __devexit sscape_pnp_remove(struct pnp_card_link * pcard)
+static void sscape_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index abe3c34..145a805 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -575,7 +575,7 @@ static int snd_wavefront_isa_probe(struct device *pdev,
 	return 0;
 }
 
-static int __devexit snd_wavefront_isa_remove(struct device *devptr,
+static int snd_wavefront_isa_remove(struct device *devptr,
 					      unsigned int dev)
 {
 	snd_card_free(dev_get_drvdata(devptr));
@@ -632,7 +632,7 @@ static int snd_wavefront_pnp_detect(struct pnp_card_link *pcard,
 	return 0;
 }
 
-static void __devexit snd_wavefront_pnp_remove(struct pnp_card_link * pcard)
+static void snd_wavefront_pnp_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 690e019..7420c59 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -917,7 +917,7 @@ static int hal2_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit hal2_remove(struct platform_device *pdev)
+static int hal2_remove(struct platform_device *pdev)
 {
 	struct snd_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 8b5ef60..6a1de57 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -958,7 +958,7 @@ static int snd_sgio2audio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit snd_sgio2audio_remove(struct platform_device *pdev)
+static int snd_sgio2audio_remove(struct platform_device *pdev)
 {
 	struct snd_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/oss/kahlua.c b/sound/oss/kahlua.c
index 5d092d2..2a44cc1 100644
--- a/sound/oss/kahlua.c
+++ b/sound/oss/kahlua.c
@@ -183,7 +183,7 @@ err_out_free:
 	return 1;
 }
 
-static void __devexit remove_one(struct pci_dev *pdev)
+static void remove_one(struct pci_dev *pdev)
 {
 	struct address_info *hw_config = pci_get_drvdata(pdev);
 	sb_dsp_unload(hw_config, 0);
@@ -220,7 +220,7 @@ static int __init kahlua_init_module(void)
 	return pci_register_driver(&kahlua_driver);
 }
 
-static void __devexit kahlua_cleanup_module(void)
+static void kahlua_cleanup_module(void)
 {
 	pci_unregister_driver(&kahlua_driver);
 }
diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index cef6a11..7a624cc 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -1008,7 +1008,7 @@ free_and_ret:
 	return err;
 }
 
-static int __devexit
+static int
 snd_harmony_remove(struct parisc_device *padev)
 {
 	snd_card_free(parisc_get_drvdata(padev));
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 099d9fd..874c79b 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -1035,7 +1035,7 @@ free_and_ret:
 	return err;
 }
 
-static void __devexit
+static void
 snd_ad1889_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index b611059..4b61bd1 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2295,7 +2295,7 @@ static int snd_ali_probe(struct pci_dev *pci,
 	return err;
 }
 
-static void __devexit snd_ali_remove(struct pci_dev *pci)
+static void snd_ali_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 8fac3ce..6da6ea4 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -278,7 +278,7 @@ static irqreturn_t snd_als300plus_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void __devexit snd_als300_remove(struct pci_dev *pci)
+static void snd_als300_remove(struct pci_dev *pci)
 {
 	snd_als300_dbgcallenter();
 	snd_card_free(pci_get_drvdata(pci));
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 2588c47..e8f4f03 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -981,7 +981,7 @@ out:
 	return err;
 }
 
-static void __devexit snd_card_als4000_remove(struct pci_dev *pci)
+static void snd_card_als4000_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index a01739c..72ee21d 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2944,7 +2944,7 @@ __nodev:
 
 }
 
-static void __devexit snd_asihpi_remove(struct pci_dev *pci_dev)
+static void snd_asihpi_remove(struct pci_dev *pci_dev)
 {
 	struct hpi_adapter *hpi = pci_get_drvdata(pci_dev);
 	snd_card_free(hpi->snd_card);
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 842b94d..39228f0 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -420,7 +420,7 @@ err:
 	return -ENODEV;
 }
 
-void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev)
+void asihpi_adapter_remove(struct pci_dev *pci_dev)
 {
 	int idx;
 	struct hpi_message hm;
diff --git a/sound/pci/asihpi/hpioctl.h b/sound/pci/asihpi/hpioctl.h
index f99baea..b6f3f94 100644
--- a/sound/pci/asihpi/hpioctl.h
+++ b/sound/pci/asihpi/hpioctl.h
@@ -21,7 +21,7 @@ Linux HPI ioctl, and shared module init functions
 
 int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	const struct pci_device_id *pci_id);
-void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev);
+void asihpi_adapter_remove(struct pci_dev *pci_dev);
 void __init asihpi_init(void);
 void __exit asihpi_exit(void);
 
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index a4ea06f..adeacbb 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1710,7 +1710,7 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 	return err;
 }
 
-static void __devexit snd_atiixp_remove(struct pci_dev *pci)
+static void snd_atiixp_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 5cb8928..a942b77 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1331,7 +1331,7 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 	return err;
 }
 
-static void __devexit snd_atiixp_remove(struct pci_dev *pci)
+static void snd_atiixp_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 9cf669a..179588f 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -366,7 +366,7 @@ static int snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci
 }
 
 // destructor -- see "Destructor" sub-section
-static void __devexit snd_vortex_remove(struct pci_dev *pci)
+static void snd_vortex_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index c1f35e4..361984d 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -117,7 +117,7 @@ static int snd_aw2_create(struct snd_card *card,
 				    struct pci_dev *pci, struct aw2 **rchip);
 static int snd_aw2_probe(struct pci_dev *pci,
 				   const struct pci_device_id *pci_id);
-static void __devexit snd_aw2_remove(struct pci_dev *pci);
+static void snd_aw2_remove(struct pci_dev *pci);
 static int snd_aw2_pcm_playback_open(struct snd_pcm_substream *substream);
 static int snd_aw2_pcm_playback_close(struct snd_pcm_substream *substream);
 static int snd_aw2_pcm_capture_open(struct snd_pcm_substream *substream);
@@ -389,7 +389,7 @@ static int snd_aw2_probe(struct pci_dev *pci,
 }
 
 /* destructor */
-static void __devexit snd_aw2_remove(struct pci_dev *pci)
+static void snd_aw2_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 8c3502d..39363c2 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2713,7 +2713,7 @@ out:
 	return err;
 }
 
-static void __devexit
+static void
 snd_azf3328_remove(struct pci_dev *pci)
 {
 	snd_azf3328_dbgcallenter();
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 354ec5a..41c9044 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -948,7 +948,7 @@ _error:
 	return err;
 }
 
-static void __devexit snd_bt87x_remove(struct pci_dev *pci)
+static void snd_bt87x_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index f827687..1610a57 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1893,7 +1893,7 @@ static int snd_ca0106_probe(struct pci_dev *pci,
 	return err;
 }
 
-static void __devexit snd_ca0106_remove(struct pci_dev *pci)
+static void snd_ca0106_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index d67209a..7177993 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3314,7 +3314,7 @@ static int snd_cmipci_probe(struct pci_dev *pci,
 
 }
 
-static void __devexit snd_cmipci_remove(struct pci_dev *pci)
+static void snd_cmipci_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 5431c6d..9e65315 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1968,7 +1968,7 @@ static int snd_cs4281_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_cs4281_remove(struct pci_dev *pci)
+static void snd_cs4281_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 74a43b0..6c48bcb 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -155,7 +155,7 @@ static int snd_card_cs46xx_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_card_cs46xx_remove(struct pci_dev *pci)
+static void snd_card_cs46xx_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index 94aee6e..241f546 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -88,7 +88,7 @@ static int snd_cs5530_dev_free(struct snd_device *device)
 	return snd_cs5530_free(chip);
 }
 
-static void __devexit snd_cs5530_remove(struct pci_dev *pci)
+static void snd_cs5530_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index cf188b2..54136e1 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -387,7 +387,7 @@ probefail_out:
 	return err;
 }
 
-static void __devexit snd_cs5535audio_remove(struct pci_dev *pci)
+static void snd_cs5535audio_remove(struct pci_dev *pci)
 {
 	olpc_quirks_cleanup();
 	snd_card_free(pci_get_drvdata(pci));
diff --git a/sound/pci/cs5535audio/cs5535audio.h b/sound/pci/cs5535audio/cs5535audio.h
index 536a6bb..d6422ad 100644
--- a/sound/pci/cs5535audio/cs5535audio.h
+++ b/sound/pci/cs5535audio/cs5535audio.h
@@ -100,7 +100,7 @@ extern const struct dev_pm_ops snd_cs5535audio_pm;
 void olpc_prequirks(struct snd_card *card,
 		struct snd_ac97_template *ac97);
 int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97);
-void __devexit olpc_quirks_cleanup(void);
+void olpc_quirks_cleanup(void);
 void olpc_analog_input(struct snd_ac97 *ac97, int on);
 void olpc_mic_bias(struct snd_ac97 *ac97, int on);
 
diff --git a/sound/pci/cs5535audio/cs5535audio_olpc.c b/sound/pci/cs5535audio/cs5535audio_olpc.c
index 6a98019..67fba40 100644
--- a/sound/pci/cs5535audio/cs5535audio_olpc.c
+++ b/sound/pci/cs5535audio/cs5535audio_olpc.c
@@ -185,7 +185,7 @@ int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
 	return 0;
 }
 
-void __devexit olpc_quirks_cleanup(void)
+void olpc_quirks_cleanup(void)
 {
 	gpio_free(OLPC_GPIO_MIC_AC);
 }
diff --git a/sound/pci/ctxfi/xfi.c b/sound/pci/ctxfi/xfi.c
index 8275ac3..97db201 100644
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -118,7 +118,7 @@ error:
 	return err;
 }
 
-static void __devexit ct_card_remove(struct pci_dev *pci)
+static void ct_card_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index f4400ba..31ba99e 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2316,7 +2316,7 @@ static SIMPLE_DEV_PM_OPS(snd_echo_pm, snd_echo_suspend, snd_echo_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 
-static void __devexit snd_echo_remove(struct pci_dev *pci)
+static void snd_echo_remove(struct pci_dev *pci)
 {
 	struct echoaudio *chip;
 
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 77b316d..fe7e7b6 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -199,7 +199,7 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci,
 	return err;
 }
 
-static void __devexit snd_card_emu10k1_remove(struct pci_dev *pci)
+static void snd_card_emu10k1_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 9c618c2..cc897e9 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1619,7 +1619,7 @@ static int snd_emu10k1x_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_emu10k1x_remove(struct pci_dev *pci)
+static void snd_emu10k1x_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 2e42aab..20c14a7 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2494,7 +2494,7 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_audiopci_remove(struct pci_dev *pci)
+static void snd_audiopci_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 5441377..4062722 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1878,7 +1878,7 @@ static int snd_es1938_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_es1938_remove(struct pci_dev *pci)
+static void snd_es1938_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 71629cd..8c6e693 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2903,7 +2903,7 @@ static int snd_es1968_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_es1968_remove(struct pci_dev *pci)
+static void snd_es1968_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 446fc99..324013d 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1367,7 +1367,7 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_card_fm801_remove(struct pci_dev *pci)
+static void snd_card_fm801_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0aedbe1..25723c0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3525,7 +3525,7 @@ out_free:
 	return err;
 }
 
-static void __devexit azx_remove(struct pci_dev *pci)
+static void azx_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index b6e9dda..b528515 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2797,7 +2797,7 @@ static int snd_ice1712_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_ice1712_remove(struct pci_dev *pci)
+static void snd_ice1712_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_ice1712 *ice = card->private_data;
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 7551c34..e07076f 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2792,7 +2792,7 @@ __found:
 	return 0;
 }
 
-static void __devexit snd_vt1724_remove(struct pci_dev *pci)
+static void snd_vt1724_remove(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_ice1712 *ice = card->private_data;
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 4074d4f..24aecf7 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -3359,7 +3359,7 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_intel8x0_remove(struct pci_dev *pci)
+static void snd_intel8x0_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 921521d..7569bf5 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1325,7 +1325,7 @@ static int snd_intel8x0m_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_intel8x0m_remove(struct pci_dev *pci)
+static void snd_intel8x0m_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 3398453..0f920de 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2469,7 +2469,7 @@ static int snd_korg1212_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_korg1212_remove(struct pci_dev *pci)
+static void snd_korg1212_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 7be3dad..a32dda7 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -756,7 +756,7 @@ out_free:
 	return err;
 }
 
-static void __devexit lola_remove(struct pci_dev *pci)
+static void lola_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index c9119ce..b2540fb 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1136,7 +1136,7 @@ out_free:
 
 }
 
-static void __devexit snd_lx6464es_remove(struct pci_dev *pci)
+static void snd_lx6464es_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 986cd07..ed26007 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2767,7 +2767,7 @@ static int snd_m3_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	return 0;
 }
 
-static void __devexit snd_m3_remove(struct pci_dev *pci)
+static void snd_m3_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index f744df5..65bc05b 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1374,7 +1374,7 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_mixart_remove(struct pci_dev *pci)
+static void snd_mixart_remove(struct pci_dev *pci)
 {
 	snd_mixart_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 6c3fd38..dad075e 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1738,7 +1738,7 @@ static int snd_nm256_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_nm256_remove(struct pci_dev *pci)
+static void snd_nm256_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index cc2008a..7276d42 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1688,7 +1688,7 @@ static int pcxhr_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit pcxhr_remove(struct pci_dev *pci)
+static void pcxhr_remove(struct pci_dev *pci)
 {
 	pcxhr_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 42da7d5..baf28ca 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -2057,7 +2057,7 @@ static int snd_riptide_joystick_probe(struct pci_dev *pci, const struct pci_devi
 	return 0;
 }
 
-static void __devexit snd_riptide_joystick_remove(struct pci_dev *pci)
+static void snd_riptide_joystick_remove(struct pci_dev *pci)
 {
 	struct gameport *gameport = pci_get_drvdata(pci);
 	if (gameport) {
@@ -2172,7 +2172,7 @@ static int snd_card_riptide_probe(struct pci_dev *pci, const struct pci_device_i
 	return err;
 }
 
-static void __devexit snd_card_riptide_remove(struct pci_dev *pci)
+static void snd_card_riptide_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 1378c3c..04f51da 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1977,7 +1977,7 @@ static int snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_
 	return 0;
 }
 
-static void __devexit snd_rme32_remove(struct pci_dev *pci)
+static void snd_rme32_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index c145d80..2fbec92 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -2387,7 +2387,7 @@ static int snd_rme96_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_rme96_remove(struct pci_dev *pci)
+static void snd_rme96_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index bff2f60..6b19f32 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5630,7 +5630,7 @@ static int snd_hdsp_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_hdsp_remove(struct pci_dev *pci)
+static void snd_hdsp_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 4724808..1bf1d8d 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6964,7 +6964,7 @@ static int snd_hdspm_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_hdspm_remove(struct pci_dev *pci)
+static void snd_hdspm_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 077cfb7..ca8420e 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2625,7 +2625,7 @@ static int snd_rme9652_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_rme9652_remove(struct pci_dev *pci)
+static void snd_rme9652_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 8548deb..a9d7a1c 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1478,7 +1478,7 @@ error_out:
 	return rc;
 }
 
-static void __devexit snd_sis7019_remove(struct pci_dev *pci)
+static void snd_sis7019_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index f192476..da10d1d 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1524,7 +1524,7 @@ static int snd_sonic_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_sonic_remove(struct pci_dev *pci)
+static void snd_sonic_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index 7594bc2..ea71f89 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -166,7 +166,7 @@ static int snd_trident_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_trident_remove(struct pci_dev *pci)
+static void snd_trident_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 5481695..6716479 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2643,7 +2643,7 @@ static int snd_via82xx_probe(struct pci_dev *pci,
 	return err;
 }
 
-static void __devexit snd_via82xx_remove(struct pci_dev *pci)
+static void snd_via82xx_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index a7f5c64..11d5320 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -1224,7 +1224,7 @@ static int snd_via82xx_probe(struct pci_dev *pci,
 	return err;
 }
 
-static void __devexit snd_via82xx_remove(struct pci_dev *pci)
+static void snd_via82xx_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 6d4fbcf..2400277 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -251,7 +251,7 @@ static int snd_vx222_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_vx222_remove(struct pci_dev *pci)
+static void snd_vx222_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index 2dbb55f..b0e1a0c 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -344,7 +344,7 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 	return 0;
 }
 
-static void __devexit snd_card_ymfpci_remove(struct pci_dev *pci)
+static void snd_card_ymfpci_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
 	pci_set_drvdata(pci, NULL);
diff --git a/sound/ppc/powermac.c b/sound/ppc/powermac.c
index 625d12e..09fc848 100644
--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -136,7 +136,7 @@ __error:
 }
 
 
-static int __devexit snd_pmac_remove(struct platform_device *devptr)
+static int snd_pmac_remove(struct platform_device *devptr)
 {
 	snd_card_free(platform_get_drvdata(devptr));
 	platform_set_drvdata(devptr, NULL);
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 1cbbf42..0ab1f91 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -591,7 +591,7 @@ static int add_aicamixer_controls(struct snd_card_aica
 	return 0;
 }
 
-static int __devexit snd_aica_remove(struct platform_device *devptr)
+static int snd_aica_remove(struct platform_device *devptr)
 {
 	struct snd_card_aica *dreamcastcard;
 	dreamcastcard = platform_get_drvdata(devptr);
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 92cc26d..41849c6 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -478,7 +478,7 @@ static int atmel_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &atmel_soc_platform);
 }
 
-static int __devexit atmel_soc_platform_remove(struct platform_device *pdev)
+static int atmel_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index f2e6efd..d3528cd 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -794,7 +794,7 @@ static int asoc_ssc_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &atmel_ssc_dai[pdev->id]);
 }
 
-static int __devexit asoc_ssc_remove(struct platform_device *pdev)
+static int asoc_ssc_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 1197515..8e533c9 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -244,7 +244,7 @@ err:
 	return ret;
 }
 
-static int __devexit at91sam9g20ek_audio_remove(struct platform_device *pdev)
+static int at91sam9g20ek_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index a444bfb..ea7d9d1 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -276,7 +276,7 @@ static int au1xac97c_drvprobe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit au1xac97c_drvremove(struct platform_device *pdev)
+static int au1xac97c_drvremove(struct platform_device *pdev)
 {
 	struct au1xpsc_audio_data *ctx = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
index 2a8bf01..376d976 100644
--- a/sound/soc/au1x/db1000.c
+++ b/sound/soc/au1x/db1000.c
@@ -41,7 +41,7 @@ static int db1000_audio_probe(struct platform_device *pdev)
 	return snd_soc_register_card(card);
 }
 
-static int __devexit db1000_audio_remove(struct platform_device *pdev)
+static int db1000_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	snd_soc_unregister_card(card);
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index fdda99c..a497a0c 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -186,7 +186,7 @@ static int db1200_audio_probe(struct platform_device *pdev)
 	return snd_soc_register_card(card);
 }
 
-static int __devexit db1200_audio_remove(struct platform_device *pdev)
+static int db1200_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	snd_soc_unregister_card(card);
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index ec85c58..3b4eafa 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -362,7 +362,7 @@ static int au1xpsc_pcm_drvprobe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &au1xpsc_soc_platform);
 }
 
-static int __devexit au1xpsc_pcm_drvremove(struct platform_device *pdev)
+static int au1xpsc_pcm_drvremove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index ccfbe5b..befd107 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -335,7 +335,7 @@ static int alchemy_pcm_drvprobe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &alchemy_pcm_soc_platform);
 }
 
-static int __devexit alchemy_pcm_drvremove(struct platform_device *pdev)
+static int alchemy_pcm_drvremove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index 4737c85..072448a 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -263,7 +263,7 @@ static int au1xi2s_drvprobe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &au1xi2s_dai_driver);
 }
 
-static int __devexit au1xi2s_drvremove(struct platform_device *pdev)
+static int au1xi2s_drvremove(struct platform_device *pdev)
 {
 	struct au1xpsc_audio_data *ctx = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index c541c92..6ba07e3 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -427,7 +427,7 @@ static int au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit au1xpsc_ac97_drvremove(struct platform_device *pdev)
+static int au1xpsc_ac97_drvremove(struct platform_device *pdev)
 {
 	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index bed90cc..360b4e5 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -353,7 +353,7 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &wd->dai_drv);
 }
 
-static int __devexit au1xpsc_i2s_drvremove(struct platform_device *pdev)
+static int au1xpsc_i2s_drvremove(struct platform_device *pdev)
 {
 	struct au1xpsc_audio_data *wd = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index dce0f25..7e2f360 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -458,7 +458,7 @@ static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_ac97_soc_platform);
 }
 
-static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
+static int bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 6845373..8e41bcb 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -352,7 +352,7 @@ gpio_err:
 	return ret;
 }
 
-static int __devexit asoc_bfin_ac97_remove(struct platform_device *pdev)
+static int asoc_bfin_ac97_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index b87f5aa..d23f4b0 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -98,7 +98,7 @@ static int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit bf5xx_ad1836_driver_remove(struct platform_device *pdev)
+static int bf5xx_ad1836_driver_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index b3a5cbe..262c1de 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -297,7 +297,7 @@ static int bfin_i2s_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_i2s_soc_platform);
 }
 
-static int __devexit bfin_i2s_soc_platform_remove(struct platform_device *pdev)
+static int bfin_i2s_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index f07e3ae..168d88b 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -267,7 +267,7 @@ static int bf5xx_i2s_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bf5xx_i2s_remove(struct platform_device *pdev)
+static int bf5xx_i2s_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 23a4dec..0e6b888 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -322,7 +322,7 @@ static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_tdm_soc_platform);
 }
 
-static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
+static int bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 806f8f0..c1e516e 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -295,7 +295,7 @@ sport_config_err:
 	return ret;
 }
 
-static int __devexit bfin_tdm_remove(struct platform_device *pdev)
+static int bfin_tdm_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
index a87b7b2..8f33797 100644
--- a/sound/soc/blackfin/bf6xx-i2s.c
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -208,7 +208,7 @@ static int bfin_i2s_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bfin_i2s_remove(struct platform_device *pdev)
+static int bfin_i2s_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index c494e85..4ef9683 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -157,7 +157,7 @@ static int bfin_eval_adau1373_probe(struct platform_device *pdev)
 	return snd_soc_register_card(&bfin_eval_adau1373);
 }
 
-static int __devexit bfin_eval_adau1373_remove(struct platform_device *pdev)
+static int bfin_eval_adau1373_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bfin-eval-adau1701.c b/sound/soc/blackfin/bfin-eval-adau1701.c
index eb2dab8..3b55081 100644
--- a/sound/soc/blackfin/bfin-eval-adau1701.c
+++ b/sound/soc/blackfin/bfin-eval-adau1701.c
@@ -97,7 +97,7 @@ static int bfin_eval_adau1701_probe(struct platform_device *pdev)
 	return snd_soc_register_card(&bfin_eval_adau1701);
 }
 
-static int __devexit bfin_eval_adau1701_remove(struct platform_device *pdev)
+static int bfin_eval_adau1701_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 5d71f76..3b1b61a 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -122,7 +122,7 @@ static int bfin_eval_adav80x_probe(struct platform_device *pdev)
 	return snd_soc_register_card(&bfin_eval_adav80x);
 }
 
-static int __devexit bfin_eval_adav80x_remove(struct platform_device *pdev)
+static int bfin_eval_adav80x_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index 0e766a5..5db68cf 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -101,7 +101,7 @@ static int edb93xx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit edb93xx_remove(struct platform_device *pdev)
+static int edb93xx_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index e70f53f..f3f50e6 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -402,7 +402,7 @@ fail:
 	return ret;
 }
 
-static int __devexit ep93xx_ac97_remove(struct platform_device *pdev)
+static int ep93xx_ac97_remove(struct platform_device *pdev)
 {
 	struct ep93xx_ac97_info	*info = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index fe62a61..3365d4e 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -422,7 +422,7 @@ fail:
 	return err;
 }
 
-static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
+static int ep93xx_i2s_remove(struct platform_device *pdev)
 {
 	struct ep93xx_i2s_info *info = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index b294fb1..72eb7a4 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -218,7 +218,7 @@ static int ep93xx_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &ep93xx_soc_platform);
 }
 
-static int __devexit ep93xx_soc_platform_remove(struct platform_device *pdev)
+static int ep93xx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
index 1c8d9aa..a397bb0 100644
--- a/sound/soc/cirrus/simone.c
+++ b/sound/soc/cirrus/simone.c
@@ -63,7 +63,7 @@ static int simone_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit simone_remove(struct platform_device *pdev)
+static int simone_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 7f8dcd2..9d77fe2 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -119,7 +119,7 @@ static int snappercl15_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit snappercl15_remove(struct platform_device *pdev)
+static int snappercl15_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 0631036..60159c0 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1463,7 +1463,7 @@ out:
 	return -EINVAL;
 }
 
-static int __devexit pm860x_codec_remove(struct platform_device *pdev)
+static int pm860x_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 300ea60..6c12ac2 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2580,7 +2580,7 @@ static int ab8500_codec_driver_probe(struct platform_device *pdev)
 	return status;
 }
 
-static int __devexit ab8500_codec_driver_remove(struct platform_device *pdev)
+static int ab8500_codec_driver_remove(struct platform_device *pdev)
 {
 	dev_info(&pdev->dev, "%s Enter.\n", __func__);
 
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 5c0837b..ef2ae32 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -124,7 +124,7 @@ static int ac97_probe(struct platform_device *pdev)
 			&soc_codec_dev_ac97, &ac97_dai, 1);
 }
 
-static int __devexit ac97_remove(struct platform_device *pdev)
+static int ac97_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 384ae12..9a92b79 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -383,7 +383,7 @@ static int ad1836_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit ad1836_spi_remove(struct spi_device *spi)
+static int ad1836_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 209b7b5..784554b 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -397,7 +397,7 @@ static int ad193x_spi_probe(struct spi_device *spi)
 			&ad193x_dai, 1);
 }
 
-static int __devexit ad193x_spi_remove(struct spi_device *spi)
+static int ad193x_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -450,7 +450,7 @@ static int ad193x_i2c_probe(struct i2c_client *client,
 			&ad193x_dai, 1);
 }
 
-static int __devexit ad193x_i2c_remove(struct i2c_client *client)
+static int ad193x_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index db6657f..f385342 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -261,7 +261,7 @@ static int ad1980_probe(struct platform_device *pdev)
 			&soc_codec_dev_ad1980, &ad1980_dai, 1);
 }
 
-static int __devexit ad1980_remove(struct platform_device *pdev)
+static int ad1980_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 82c2a7e..b1f2baf 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -47,7 +47,7 @@ static int ad73311_probe(struct platform_device *pdev)
 			&soc_codec_dev_ad73311, &ad73311_dai, 1);
 }
 
-static int __devexit ad73311_remove(struct platform_device *pdev)
+static int ad73311_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index e20e267..8d180fe 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1370,7 +1370,7 @@ static int adau1373_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int __devexit adau1373_i2c_remove(struct i2c_client *client)
+static int adau1373_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index bd7d58f..e6e2c75 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -505,7 +505,7 @@ static int adau1701_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static __devexit int adau1701_i2c_remove(struct i2c_client *client)
+static int adau1701_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index cb960fd..3289616 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -860,7 +860,7 @@ static int adav80x_bus_probe(struct device *dev,
 	return ret;
 }
 
-static int __devexit adav80x_bus_remove(struct device *dev)
+static int adav80x_bus_remove(struct device *dev)
 {
 	snd_soc_unregister_codec(dev);
 	kfree(dev_get_drvdata(dev));
@@ -873,7 +873,7 @@ static int adav80x_spi_probe(struct spi_device *spi)
 	return adav80x_bus_probe(&spi->dev, SND_SOC_SPI);
 }
 
-static int __devexit adav80x_spi_remove(struct spi_device *spi)
+static int adav80x_spi_remove(struct spi_device *spi)
 {
 	return adav80x_bus_remove(&spi->dev);
 }
@@ -901,7 +901,7 @@ static int adav80x_i2c_probe(struct i2c_client *client,
 	return adav80x_bus_probe(&client->dev, SND_SOC_I2C);
 }
 
-static int __devexit adav80x_i2c_remove(struct i2c_client *client)
+static int adav80x_i2c_remove(struct i2c_client *client)
 {
 	return adav80x_bus_remove(&client->dev);
 }
diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index a152f5a..506d474 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -42,7 +42,7 @@ static int ads117x_probe(struct platform_device *pdev)
 			&soc_codec_dev_ads117x, &ads117x_dai, 1);
 }
 
-static int __devexit ads117x_remove(struct platform_device *pdev)
+static int ads117x_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index b391f26..abca654 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -267,7 +267,7 @@ err:
 	return ret;
 }
 
-static int __devexit ak4104_spi_remove(struct spi_device *spi)
+static int ak4104_spi_remove(struct spi_device *spi)
 {
 	struct ak4104_private *ak4101 = spi_get_drvdata(spi);
 	regmap_exit(ak4101->regmap);
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 77e285c..204005b 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -464,7 +464,7 @@ static int ak4535_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int ak4535_i2c_remove(struct i2c_client *client)
+static int ak4535_i2c_remove(struct i2c_client *client)
 {
 	struct ak4535_priv *ak4535 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 09da215..69c2d21 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -610,7 +610,7 @@ err_out:
 	return ret;
 }
 
-static int __devexit ak4641_i2c_remove(struct i2c_client *i2c)
+static int ak4641_i2c_remove(struct i2c_client *i2c)
 {
 	struct ak4641_platform_data *pdata = i2c->dev.platform_data;
 
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index aba3813..b838fc2 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -540,7 +540,7 @@ static int ak4642_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int ak4642_i2c_remove(struct i2c_client *client)
+static int ak4642_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 93a76cb..9425ebd 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -674,7 +674,7 @@ static int ak4671_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static __devexit int ak4671_i2c_remove(struct i2c_client *client)
+static int ak4671_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 5a7ad19..f479b5e 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -1058,7 +1058,7 @@ static int alc5623_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static __devexit int alc5623_i2c_remove(struct i2c_client *client)
+static int alc5623_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 7026e3d..856c8ef 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1179,7 +1179,7 @@ static int alc5632_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static __devexit int alc5632_i2c_remove(struct i2c_client *client)
+static int alc5632_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 3d637b2..8238998 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -585,7 +585,7 @@ static int cs4271_spi_probe(struct spi_device *spi)
 		&cs4271_dai, 1);
 }
 
-static int __devexit cs4271_spi_remove(struct spi_device *spi)
+static int cs4271_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -625,7 +625,7 @@ static int cs4271_i2c_probe(struct i2c_client *client,
 		&cs4271_dai, 1);
 }
 
-static int __devexit cs4271_i2c_remove(struct i2c_client *client)
+static int cs4271_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 362c20b..c82a0f8 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1406,7 +1406,7 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	return 0;
 }
 
-static __devexit int cs42l73_i2c_remove(struct i2c_client *client)
+static int cs42l73_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 0c3b09c..e456463 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1257,7 +1257,7 @@ err_regmap:
 	return ret;
 }
 
-static int __devexit da7210_i2c_remove(struct i2c_client *client)
+static int da7210_i2c_remove(struct i2c_client *client)
 {
 	struct da7210_priv *da7210 = i2c_get_clientdata(client);
 
@@ -1359,7 +1359,7 @@ err_regmap:
 	return ret;
 }
 
-static int __devexit da7210_spi_remove(struct spi_device *spi)
+static int da7210_spi_remove(struct spi_device *spi)
 {
 	struct da7210_priv *da7210 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 850bfed..cea2827 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1596,7 +1596,7 @@ err:
 	return ret;
 }
 
-static __devexit int da732x_i2c_remove(struct i2c_client *client)
+static int da732x_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index cf8dfeb..3549a34 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1517,7 +1517,7 @@ static int da9055_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit da9055_remove(struct i2c_client *client)
+static int da9055_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/dfbmcs320.c b/sound/soc/codecs/dfbmcs320.c
index 61ccf30..4f4f7f4 100644
--- a/sound/soc/codecs/dfbmcs320.c
+++ b/sound/soc/codecs/dfbmcs320.c
@@ -39,7 +39,7 @@ static int dfbmcs320_probe(struct platform_device *pdev)
 			&dfbmcs320_dai, 1);
 }
 
-static int __devexit dfbmcs320_remove(struct platform_device *pdev)
+static int dfbmcs320_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 0dc7fab..66967ba 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -72,7 +72,7 @@ static int dmic_dev_probe(struct platform_device *pdev)
 			&soc_dmic, &dmic_dai, 1);
 }
 
-static int __devexit dmic_dev_remove(struct platform_device *pdev)
+static int dmic_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 8853a83..054a18f 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1145,7 +1145,7 @@ static int isabelle_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit isabelle_i2c_remove(struct i2c_client *client)
+static int isabelle_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 3606f26..d991529 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -380,7 +380,7 @@ static int jz4740_codec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit jz4740_codec_remove(struct platform_device *pdev)
+static int jz4740_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 
diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 27e7991..1d004a4 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -228,7 +228,7 @@ static int lm4857_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit lm4857_i2c_remove(struct i2c_client *i2c)
+static int lm4857_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
 	return 0;
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 568e499..a008933 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1517,7 +1517,7 @@ static int lm49453_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit lm49453_i2c_remove(struct i2c_client *client)
+static int lm49453_i2c_remove(struct i2c_client *client)
 {
 	struct lm49453_priv *lm49453 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 4ece6ab..63ccd6f 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -210,7 +210,7 @@ static int max9768_i2c_probe(struct i2c_client *client,
 	return err;
 }
 
-static int __devexit max9768_i2c_remove(struct i2c_client *client)
+static int max9768_i2c_remove(struct i2c_client *client)
 {
 	struct max9768 *max9768 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index b858264..a4c16fd 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -2084,7 +2084,7 @@ static int max98088_i2c_probe(struct i2c_client *i2c,
        return ret;
 }
 
-static int __devexit max98088_i2c_remove(struct i2c_client *client)
+static int max98088_i2c_remove(struct i2c_client *client)
 {
        snd_soc_unregister_codec(&client->dev);
        return 0;
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 1e17aef..41cdd16 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2511,7 +2511,7 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit max98095_i2c_remove(struct i2c_client *client)
+static int max98095_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index 261b62f..8720ebc 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -347,7 +347,7 @@ static int max9850_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int max9850_i2c_remove(struct i2c_client *client)
+static int max9850_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 5243340..0c01469 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -268,7 +268,7 @@ static int max9877_i2c_probe(struct i2c_client *client,
 	return 0;
 }
 
-static __devexit int max9877_i2c_remove(struct i2c_client *client)
+static int max9877_i2c_remove(struct i2c_client *client)
 {
 	i2c = NULL;
 
diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index d3d6b26..d38a05b 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -649,7 +649,7 @@ static int ml26124_i2c_probe(struct i2c_client *i2c,
 			&soc_codec_dev_ml26124, &ml26124_dai, 1);
 }
 
-static __devexit int ml26124_i2c_remove(struct i2c_client *client)
+static int ml26124_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/omap-hdmi.c b/sound/soc/codecs/omap-hdmi.c
index 8ddc3d56..529d064 100644
--- a/sound/soc/codecs/omap-hdmi.c
+++ b/sound/soc/codecs/omap-hdmi.c
@@ -45,7 +45,7 @@ static int omap_hdmi_codec_probe(struct platform_device *pdev)
 			&omap_hdmi_codec_dai, 1);
 }
 
-static __devexit int omap_hdmi_codec_remove(struct platform_device *pdev)
+static int omap_hdmi_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 74561f3..f2a6282 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -155,7 +155,7 @@ static int pcm3008_codec_probe(struct platform_device *pdev)
 			&soc_codec_dev_pcm3008, &pcm3008_dai, 1);
 }
 
-static int __devexit pcm3008_codec_remove(struct platform_device *pdev)
+static int pcm3008_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 32d5ff4..e8a096c 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1748,7 +1748,7 @@ static int rt5631_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int rt5631_i2c_remove(struct i2c_client *client)
+static int rt5631_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 40d4fc1..dca33c6 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1422,7 +1422,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static __devexit int sgtl5000_i2c_remove(struct i2c_client *client)
+static int sgtl5000_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 8c46732..f2d61a1 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -232,7 +232,7 @@ static int si476x_platform_probe(struct platform_device *pdev)
 				      &si476x_dai, 1);
 }
 
-static int __devexit si476x_platform_remove(struct platform_device *pdev)
+static int si476x_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 98529c5..d1ae869d 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -903,7 +903,7 @@ static int sn95031_device_probe(struct platform_device *pdev)
 			sn95031_dais, ARRAY_SIZE(sn95031_dais));
 }
 
-static int __devexit sn95031_device_remove(struct platform_device *pdev)
+static int sn95031_device_remove(struct platform_device *pdev)
 {
 	pr_debug("codec device remove called\n");
 	snd_soc_unregister_codec(&pdev->dev);
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 6fa63cc..f8d30e5 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -713,7 +713,7 @@ static int ssm2602_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit ssm2602_spi_remove(struct spi_device *spi)
+static int ssm2602_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -759,7 +759,7 @@ static int ssm2602_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit ssm2602_i2c_remove(struct i2c_client *client)
+static int ssm2602_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 2309f5a..6aa2753 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1033,7 +1033,7 @@ static int sta32x_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int sta32x_i2c_remove(struct i2c_client *client)
+static int sta32x_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 570a09e..09ed245 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -412,7 +412,7 @@ static int sta529_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit sta529_i2c_remove(struct i2c_client *client)
+static int sta529_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 20ad890..2eda85ba 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -391,7 +391,7 @@ static int stac9766_probe(struct platform_device *pdev)
 			&soc_codec_dev_stac9766, stac9766_dai, ARRAY_SIZE(stac9766_dai));
 }
 
-static int __devexit stac9766_remove(struct platform_device *pdev)
+static int stac9766_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 1d45339..5d71c86 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -748,7 +748,7 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int aic32x4_i2c_remove(struct i2c_client *client)
+static int aic32x4_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 8af052b..922f9b3a 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1586,7 +1586,7 @@ err_gpio:
 	return ret;
 }
 
-static int __devexit dac33_i2c_remove(struct i2c_client *client)
+static int dac33_i2c_remove(struct i2c_client *client)
 {
 	struct tlv320dac33_priv *dac33 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index f1c0399..eb3de04 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -455,7 +455,7 @@ err_gpio:
 	return ret;
 }
 
-static int __devexit tpa6130a2_remove(struct i2c_client *client)
+static int tpa6130a2_remove(struct i2c_client *client)
 {
 	struct tpa6130a2_data *data = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c53c7fa..63b280b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2340,7 +2340,7 @@ static int twl4030_codec_probe(struct platform_device *pdev)
 			twl4030_dai, ARRAY_SIZE(twl4030_dai));
 }
 
-static int __devexit twl4030_codec_remove(struct platform_device *pdev)
+static int twl4030_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index e3256ba..3fc3fc6 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1235,7 +1235,7 @@ static int twl6040_codec_probe(struct platform_device *pdev)
 				      twl6040_dai, ARRAY_SIZE(twl6040_dai));
 }
 
-static int __devexit twl6040_codec_remove(struct platform_device *pdev)
+static int twl6040_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 6c5a395..6d0aa44 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -607,7 +607,7 @@ static int uda134x_codec_probe(struct platform_device *pdev)
 			&soc_codec_dev_uda134x, &uda134x_dai, 1);
 }
 
-static int __devexit uda134x_codec_remove(struct platform_device *pdev)
+static int uda134x_codec_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 289dfe1..474b812 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -814,7 +814,7 @@ static int uda1380_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __devexit uda1380_i2c_remove(struct i2c_client *i2c)
+static int uda1380_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
 	return 0;
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 2ae0302..54cd3da 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -491,7 +491,7 @@ static int wl1273_platform_probe(struct platform_device *pdev)
 				      &wl1273_dai, 1);
 }
 
-static int __devexit wl1273_platform_remove(struct platform_device *pdev)
+static int wl1273_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index c449178..132fee5 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -963,7 +963,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit wm0010_spi_remove(struct spi_device *spi)
+static int wm0010_spi_remove(struct spi_device *spi)
 {
 	struct wm0010_priv *wm0010 = spi_get_drvdata(spi);
 
diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 18e58bd..13de5ac 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -237,7 +237,7 @@ static int wm1250_ev1_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static int __devexit wm1250_ev1_remove(struct i2c_client *i2c)
+static int wm1250_ev1_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
 	wm1250_ev1_free(i2c);
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 9956b74..637f8d1 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -871,7 +871,7 @@ out:
 	return ret;
 }
 
-static __devexit int wm2000_i2c_remove(struct i2c_client *i2c)
+static int wm2000_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
 
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index b6428c6..761304b 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2388,7 +2388,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm2200_i2c_remove(struct i2c_client *i2c)
+static int wm2200_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm2200_priv *wm2200 = i2c_get_clientdata(i2c);
 
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index d5d8b52..812c326 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2639,7 +2639,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm5100_i2c_remove(struct i2c_client *i2c)
+static int wm5100_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 0210a08..4fc8fa7 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1495,7 +1495,7 @@ static int wm5102_probe(struct platform_device *pdev)
 				      wm5102_dai, ARRAY_SIZE(wm5102_dai));
 }
 
-static int __devexit wm5102_remove(struct platform_device *pdev)
+static int wm5102_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 59f5d16..5bb182f 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -988,7 +988,7 @@ static int wm5110_probe(struct platform_device *pdev)
 				      wm5110_dai, ARRAY_SIZE(wm5110_dai));
 }
 
-static int __devexit wm5110_remove(struct platform_device *pdev)
+static int wm5110_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 24eaf4d..154655f 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1633,7 +1633,7 @@ static int wm8350_probe(struct platform_device *pdev)
 			&wm8350_dai, 1);
 }
 
-static int __devexit wm8350_remove(struct platform_device *pdev)
+static int wm8350_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index fde7b17..ae2b6bc 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1445,7 +1445,7 @@ static int wm8400_probe(struct platform_device *pdev)
 			&wm8400_dai, 1);
 }
 
-static int __devexit wm8400_remove(struct platform_device *pdev)
+static int wm8400_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 28dbbdc..a18ed57 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -670,7 +670,7 @@ static int wm8510_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8510_spi_remove(struct spi_device *spi)
+static int wm8510_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -711,7 +711,7 @@ static int wm8510_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8510_i2c_remove(struct i2c_client *client)
+static int wm8510_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index c05c55d..f3a13bd 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -528,7 +528,7 @@ err_enable:
 	return ret;
 }
 
-static __devexit int wm8523_i2c_remove(struct i2c_client *client)
+static int wm8523_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index a366fdc..f68b52f 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -451,7 +451,7 @@ static int wm8711_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8711_spi_remove(struct spi_device *spi)
+static int wm8711_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 
@@ -493,7 +493,7 @@ static int wm8711_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static __devexit int wm8711_i2c_remove(struct i2c_client *client)
+static int wm8711_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index 3bc03f8..462f5e4 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -51,7 +51,7 @@ static int wm8727_probe(struct platform_device *pdev)
 			&soc_codec_dev_wm8727, &wm8727_dai, 1);
 }
 
-static int __devexit wm8727_remove(struct platform_device *pdev)
+static int wm8727_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 245c2b4..ce7105a 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -302,7 +302,7 @@ static int wm8728_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8728_spi_remove(struct spi_device *spi)
+static int wm8728_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 
@@ -344,7 +344,7 @@ static int wm8728_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8728_i2c_remove(struct i2c_client *client)
+static int wm8728_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 71617ad..dfb93d8 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -661,7 +661,7 @@ static int wm8731_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit wm8731_spi_remove(struct spi_device *spi)
+static int wm8731_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -710,7 +710,7 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-static __devexit int wm8731_i2c_remove(struct i2c_client *client)
+static int wm8731_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 9e1a100..825b14d 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -679,7 +679,7 @@ static int wm8737_i2c_probe(struct i2c_client *i2c,
 
 }
 
-static __devexit int wm8737_i2c_remove(struct i2c_client *client)
+static int wm8737_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
@@ -737,7 +737,7 @@ static int wm8737_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8737_spi_remove(struct spi_device *spi)
+static int wm8737_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 019558c..2709399 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -596,7 +596,7 @@ static int wm8741_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8741_spi_remove(struct spi_device *spi)
+static int wm8741_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 28256c4..6549c6f 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -791,7 +791,7 @@ static int wm8750_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8750_spi_remove(struct spi_device *spi)
+static int wm8750_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -840,7 +840,7 @@ static int wm8750_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8750_i2c_remove(struct i2c_client *client)
+static int wm8750_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index c22f580..1c51110 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1585,7 +1585,7 @@ err:
 	return ret;
 }
 
-static int __devexit wm8753_spi_remove(struct spi_device *spi)
+static int wm8753_spi_remove(struct spi_device *spi)
 {
 	struct wm8753_priv *wm8753 = spi_get_drvdata(spi);
 
@@ -1643,7 +1643,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8753_i2c_remove(struct i2c_client *client)
+static int wm8753_i2c_remove(struct i2c_client *client)
 {
 	struct wm8753_priv *wm8753 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 053a2f5..89a18d8 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -697,7 +697,7 @@ static int wm8770_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8770_spi_remove(struct spi_device *spi)
+static int wm8770_spi_remove(struct spi_device *spi)
 {
 	struct wm8770_priv *wm8770 = spi_get_drvdata(spi);
 	int i;
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 93bca00..146c41d 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -514,7 +514,7 @@ static int wm8776_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8776_spi_remove(struct spi_device *spi)
+static int wm8776_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -555,7 +555,7 @@ static int wm8776_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8776_i2c_remove(struct i2c_client *client)
+static int wm8776_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 4b752b7..f1fdbf6 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -48,7 +48,7 @@ static int wm8782_probe(struct platform_device *pdev)
 			&soc_codec_dev_wm8782, &wm8782_dai, 1);
 }
 
-static int __devexit wm8782_remove(struct platform_device *pdev)
+static int wm8782_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index cad8ea0..47e7065 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -725,7 +725,7 @@ static int wm8804_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8804_spi_remove(struct spi_device *spi)
+static int wm8804_spi_remove(struct spi_device *spi)
 {
 	struct wm8804_priv *wm8804 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
@@ -775,7 +775,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8804_i2c_remove(struct i2c_client *i2c)
+static int wm8804_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm8804_priv *wm8804 = i2c_get_clientdata(i2c);
 
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 375720e..6a453a2 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1269,7 +1269,7 @@ static int wm8900_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8900_spi_remove(struct spi_device *spi)
+static int wm8900_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -1309,7 +1309,7 @@ static int wm8900_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8900_i2c_remove(struct i2c_client *client)
+static int wm8900_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 930b1a2..eca4ff1 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2206,7 +2206,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8903_i2c_remove(struct i2c_client *client)
+static int wm8903_i2c_remove(struct i2c_client *client)
 {
 	struct wm8903_priv *wm8903 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 6a150d0..331b7bc 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2247,7 +2247,7 @@ err_enable:
 	return ret;
 }
 
-static __devexit int wm8904_i2c_remove(struct i2c_client *client)
+static int wm8904_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index d80fbcf..aba34cf 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -762,7 +762,7 @@ static int wm8940_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8940_i2c_remove(struct i2c_client *client)
+static int wm8940_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index b1fd4d7..0ebcf2e 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -1045,7 +1045,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8955_i2c_remove(struct i2c_client *client)
+static int wm8955_i2c_remove(struct i2c_client *client)
 {
 	struct wm8955_priv *wm8955 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e22a440..a29b5df 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1062,7 +1062,7 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8960_i2c_remove(struct i2c_client *client)
+static int wm8960_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index f862f7b..9c0163c 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -993,7 +993,7 @@ static int wm8961_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8961_i2c_remove(struct i2c_client *client)
+static int wm8961_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index dccc56f..7e82420 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3703,7 +3703,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8962_i2c_remove(struct i2c_client *client)
+static int wm8962_i2c_remove(struct i2c_client *client)
 {
 	struct wm8962_priv *wm8962 = dev_get_drvdata(&client->dev);
 
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 6028e99..d8a07b7 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -741,7 +741,7 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8971_i2c_remove(struct i2c_client *client)
+static int wm8971_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index a1c8c52..f7c428b 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -636,7 +636,7 @@ static int wm8974_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8974_i2c_remove(struct i2c_client *client)
+static int wm8974_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 7028f1a..32e0085 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1079,7 +1079,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8978_i2c_remove(struct i2c_client *client)
+static int wm8978_i2c_remove(struct i2c_client *client)
 {
 	struct wm8978_priv *wm8978 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 9b2b612..910bdef 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -1110,7 +1110,7 @@ static int wm8983_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8983_spi_remove(struct spi_device *spi)
+static int wm8983_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
 	return 0;
@@ -1152,7 +1152,7 @@ static int wm8983_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8983_i2c_remove(struct i2c_client *client)
+static int wm8983_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 76c0503..e49b1a6 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1142,7 +1142,7 @@ err:
 	return ret;
 }
 
-static int __devexit wm8985_spi_remove(struct spi_device *spi)
+static int wm8985_spi_remove(struct spi_device *spi)
 {
 	struct wm8985_priv *wm8985 = spi_get_drvdata(spi);
 
@@ -1195,7 +1195,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8985_i2c_remove(struct i2c_client *i2c)
+static int wm8985_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm8985_priv *wm8985 = i2c_get_clientdata(i2c);
 
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 20b0425..a6f7523 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -899,7 +899,7 @@ static int wm8988_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int __devexit wm8988_spi_remove(struct spi_device *spi)
+static int wm8988_spi_remove(struct spi_device *spi)
 {
 	struct wm8988_priv *wm8988 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
@@ -946,7 +946,7 @@ static int wm8988_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8988_i2c_remove(struct i2c_client *client)
+static int wm8988_i2c_remove(struct i2c_client *client)
 {
 	struct wm8988_priv *wm8988 = i2c_get_clientdata(client);
 	snd_soc_unregister_codec(&client->dev);
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index a666c16..1809af7 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1401,7 +1401,7 @@ static int wm8990_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8990_i2c_remove(struct i2c_client *client)
+static int wm8990_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 556e43f..ebd9d2f 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1376,7 +1376,7 @@ static int wm8991_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static __devexit int wm8991_i2c_remove(struct i2c_client *client)
+static int wm8991_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
 
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 0a7c29a..738f42d 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1749,7 +1749,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8993_i2c_remove(struct i2c_client *i2c)
+static int wm8993_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm8993_priv *wm8993 = i2c_get_clientdata(i2c);
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2c1e0b5..c349433 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4264,7 +4264,7 @@ static int wm8994_probe(struct platform_device *pdev)
 			wm8994_dai, ARRAY_SIZE(wm8994_dai));
 }
 
-static int __devexit wm8994_remove(struct platform_device *pdev)
+static int wm8994_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index bbfb5b9..5e3df11 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2290,7 +2290,7 @@ err_alloc:
 	return ret;
 }
 
-static int __devexit wm8995_spi_remove(struct spi_device *spi)
+static int wm8995_spi_remove(struct spi_device *spi)
 {
 	struct wm8995_priv *wm8995 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
@@ -2347,7 +2347,7 @@ err_alloc:
 	return ret;
 }
 
-static __devexit int wm8995_i2c_remove(struct i2c_client *client)
+static int wm8995_i2c_remove(struct i2c_client *client)
 {
 	struct wm8995_priv *wm8995 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 49a4147..e0544e2 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -3077,7 +3077,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm8996_i2c_remove(struct i2c_client *client)
+static int wm8996_i2c_remove(struct i2c_client *client)
 {
 	struct wm8996_priv *wm8996 = i2c_get_clientdata(client);
 	int i;
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index f6b522a..e85754b 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1393,7 +1393,7 @@ err:
 	return ret;
 }
 
-static __devexit int wm9081_i2c_remove(struct i2c_client *client)
+static int wm9081_i2c_remove(struct i2c_client *client)
 {
 	struct wm9081_priv *wm9081 = i2c_get_clientdata(client);
 
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index bfb22dc..3d70611 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -668,7 +668,7 @@ err:
 	return ret;
 }
 
-static int __devexit wm9090_i2c_remove(struct i2c_client *i2c)
+static int wm9090_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm9090_priv *wm9090 = i2c_get_clientdata(i2c);
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index b330d7a..05b1f34 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -388,7 +388,7 @@ static int wm9705_probe(struct platform_device *pdev)
 			&soc_codec_dev_wm9705, wm9705_dai, ARRAY_SIZE(wm9705_dai));
 }
 
-static int __devexit wm9705_remove(struct platform_device *pdev)
+static int wm9705_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index c44ea10..8e9a6a3 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -691,7 +691,7 @@ static int wm9712_probe(struct platform_device *pdev)
 			&soc_codec_dev_wm9712, wm9712_dai, ARRAY_SIZE(wm9712_dai));
 }
 
-static int __devexit wm9712_remove(struct platform_device *pdev)
+static int wm9712_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 0285223..f7afa68 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1260,7 +1260,7 @@ static int wm9713_probe(struct platform_device *pdev)
 			&soc_codec_dev_wm9713, wm9713_dai, ARRAY_SIZE(wm9713_dai));
 }
 
-static int __devexit wm9713_remove(struct platform_device *pdev)
+static int wm9713_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 8a87f0e..75ffdf0 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -142,7 +142,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit eukrea_tlv320_remove(struct platform_device *pdev)
+static int eukrea_tlv320_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&eukrea_tlv320);
 
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 8a07360..9cc5c1f 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -958,7 +958,7 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit fsl_soc_dma_remove(struct platform_device *pdev)
+static int fsl_soc_dma_remove(struct platform_device *pdev)
 {
 	struct dma_object *dma = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 71454ae..251f4d9 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -162,7 +162,7 @@ static void __init audmux_debugfs_init(void)
 	}
 }
 
-static void __devexit audmux_debugfs_remove(void)
+static void audmux_debugfs_remove(void)
 {
 	debugfs_remove_recursive(audmux_debugfs_root);
 }
@@ -278,7 +278,7 @@ static int imx_audmux_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit imx_audmux_remove(struct platform_device *pdev)
+static int imx_audmux_remove(struct platform_device *pdev)
 {
 	if (audmux_type == IMX31_AUDMUX)
 		audmux_debugfs_remove();
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index 6803e0a..4ae30f2 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -148,7 +148,7 @@ static int imx_mc13783_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit imx_mc13783_remove(struct platform_device *pdev)
+static int imx_mc13783_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&imx_mc13783);
 
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index d0ebbfa..bf363d8 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -159,7 +159,7 @@ static int imx_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_mx2);
 }
 
-static int __devexit imx_soc_platform_remove(struct platform_device *pdev)
+static int imx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 5a452a4..5ec362a 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -315,7 +315,7 @@ failed_register:
 	return ret;
 }
 
-static int __devexit imx_soc_platform_remove(struct platform_device *pdev)
+static int imx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 013322c..9dfec02 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -184,7 +184,7 @@ fail:
 	return ret;
 }
 
-static int __devexit imx_sgtl5000_remove(struct platform_device *pdev)
+static int imx_sgtl5000_remove(struct platform_device *pdev)
 {
 	struct imx_sgtl5000_data *data = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 0392e7b..3b48042 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -638,7 +638,7 @@ failed_clk:
 	return ret;
 }
 
-static int __devexit imx_ssi_remove(struct platform_device *pdev)
+static int imx_ssi_remove(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 7ba4764..a4aec04 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -310,7 +310,7 @@ static int psc_ac97_of_probe(struct platform_device *op)
 	return 0;
 }
 
-static int __devexit psc_ac97_of_remove(struct platform_device *op)
+static int psc_ac97_of_remove(struct platform_device *op)
 {
 	mpc5200_audio_dma_destroy(op);
 	snd_soc_unregister_dais(&op->dev, ARRAY_SIZE(psc_ac97_dai));
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 39ef9ad..b95b966 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -205,7 +205,7 @@ static int psc_i2s_of_probe(struct platform_device *op)
 
 }
 
-static int __devexit psc_i2s_of_remove(struct platform_device *op)
+static int psc_i2s_of_remove(struct platform_device *op)
 {
 	mpc5200_audio_dma_destroy(op);
 	snd_soc_unregister_dais(&op->dev, ARRAY_SIZE(psc_i2s_dai));
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 2b6dc68..228c52e 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -368,7 +368,7 @@ error_alloc:
  *
  * This function is called when the platform device is removed.
  */
-static int __devexit mpc8610_hpcd_remove(struct platform_device *pdev)
+static int mpc8610_hpcd_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct mpc8610_hpcd_data *machine_data =
diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index e88a5ea..3d10741 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -219,7 +219,7 @@ static int mx27vis_aic32x4_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit mx27vis_aic32x4_remove(struct platform_device *pdev)
+static int mx27vis_aic32x4_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&mx27vis_aic32x4);
 
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index a54ad5b..ba59c23 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -376,7 +376,7 @@ error_put:
  *
  * This function is called when the platform device is removed.
  */
-static int __devexit p1022_ds_remove(struct platform_device *pdev)
+static int p1022_ds_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct machine_data *mdata =
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index fa5fd14..f215519 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -326,7 +326,7 @@ error_put:
  *
  * This function is called when the platform device is removed.
  */
-static int __devexit p1022_rdk_remove(struct platform_device *pdev)
+static int p1022_rdk_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct machine_data *mdata =
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index b4b449c..8e52c148 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -101,7 +101,7 @@ static int __init pcm030_fabric_probe(struct platform_device *op)
 	return ret;
 }
 
-static int __devexit pcm030_fabric_remove(struct platform_device *op)
+static int pcm030_fabric_remove(struct platform_device *op)
 {
 	struct pcm030_audio_data *pdata = platform_get_drvdata(op);
 	int ret;
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 21051b3..6cef491 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -492,7 +492,7 @@ err_free:
 	return ret;
 }
 
-static int __devexit jz4740_i2s_dev_remove(struct platform_device *pdev)
+static int jz4740_i2s_dev_remove(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
index 770e4e2..7100592 100644
--- a/sound/soc/jz4740/jz4740-pcm.c
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -340,7 +340,7 @@ static int jz4740_pcm_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &jz4740_soc_platform);
 }
 
-static int __devexit jz4740_pcm_remove(struct platform_device *pdev)
+static int jz4740_pcm_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 5937ddf..55fd6b5 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -116,7 +116,7 @@ static int qi_lb60_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit qi_lb60_remove(struct platform_device *pdev)
+static int qi_lb60_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 23ead2b..4407844 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -374,7 +374,7 @@ static int kirkwood_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
 }
 
-static int __devexit kirkwood_soc_platform_remove(struct platform_device *pdev)
+static int kirkwood_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 2c6e99f..4fa01cb 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -476,7 +476,7 @@ error:
 	return err;
 }
 
-static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
+static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 {
 	struct kirkwood_dma_data *priv = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 1c682ef..b979c71 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -85,7 +85,7 @@ static int openrd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit openrd_remove(struct platform_device *pdev)
+static int openrd_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index bc142a7..1d0ed6f 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -106,7 +106,7 @@ static int t5325_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit t5325_remove(struct platform_device *pdev)
+static int t5325_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 671eb18..4139116 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -417,7 +417,7 @@ unalloc:
 	return ret_val;
 }
 
-static int __devexit snd_mfld_mc_remove(struct platform_device *pdev)
+static int snd_mfld_mc_remove(struct platform_device *pdev)
 {
 	struct mfld_mc_private *mc_drv_ctx = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index d41c770..564b5b6 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -226,7 +226,7 @@ int mxs_pcm_platform_register(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(mxs_pcm_platform_register);
 
-void __devexit mxs_pcm_platform_unregister(struct device *dev)
+void mxs_pcm_platform_unregister(struct device *dev)
 {
 	snd_soc_unregister_platform(dev);
 }
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c8c882a..0a78e60 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -790,7 +790,7 @@ failed_pdev_alloc:
 	return ret;
 }
 
-static int __devexit mxs_saif_remove(struct platform_device *pdev)
+static int mxs_saif_remove(struct platform_device *pdev)
 {
 	mxs_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_dai(&pdev->dev);
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 638c42d..b1d9b5e 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -176,7 +176,7 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit mxs_sgtl5000_remove(struct platform_device *pdev)
+static int mxs_sgtl5000_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 0121557..0418467 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -382,7 +382,7 @@ out0:
 	return ret;
 }
 
-static int __devexit nuc900_ac97_drvremove(struct platform_device *pdev)
+static int nuc900_ac97_drvremove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 37d8cc3..c894ff0 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -342,7 +342,7 @@ static int nuc900_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &nuc900_soc_platform);
 }
 
-static int __devexit nuc900_soc_platform_remove(struct platform_device *pdev)
+static int nuc900_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 1acab65..2600447 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -591,7 +591,7 @@ static int ams_delta_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ams_delta_remove(struct platform_device *pdev)
+static int ams_delta_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index e166312..b741958 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -1087,7 +1087,7 @@ err_thres:
 	return ret;
 }
 
-void __devexit omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp)
+void omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp)
 {
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 27bf6c3..3adacfb 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -342,6 +342,6 @@ int omap_st_disable(struct omap_mcbsp *mcbsp);
 int omap_st_is_enabled(struct omap_mcbsp *mcbsp);
 
 int omap_mcbsp_init(struct platform_device *pdev);
-void __devexit omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp);
+void omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp);
 
 #endif /* __ASOC_MCBSP_H */
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index a594ebf..5ea8b60 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -390,7 +390,7 @@ err_unregister:
 	return ret;
 }
 
-static int __devexit omap_abe_remove(struct platform_device *pdev)
+static int omap_abe_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index bd46176..ba49ccd 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -518,7 +518,7 @@ err_put_clk:
 	return ret;
 }
 
-static int __devexit asoc_dmic_remove(struct platform_device *pdev)
+static int asoc_dmic_remove(struct platform_device *pdev)
 {
 	struct omap_dmic *dmic = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index 092d45c..d4eaa92 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -61,7 +61,7 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit omap_hdmi_remove(struct platform_device *pdev)
+static int omap_hdmi_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 3845781..7ea2481 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -324,7 +324,7 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit omap_hdmi_remove(struct platform_device *pdev)
+static int omap_hdmi_remove(struct platform_device *pdev)
 {
 	struct hdmi_priv *hdmi_data = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 316ea7d..0ad16ab 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -799,7 +799,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit asoc_mcbsp_remove(struct platform_device *pdev)
+static int asoc_mcbsp_remove(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 803ff6a..2fe8be2 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -487,7 +487,7 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &omap_mcpdm_dai);
 }
 
-static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
+static int asoc_mcpdm_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 21f927b..47bdbd4 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -308,7 +308,7 @@ static int omap_pcm_probe(struct platform_device *pdev)
 			&omap_soc_platform);
 }
 
-static int __devexit omap_pcm_remove(struct platform_device *pdev)
+static int omap_pcm_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index c505ec2..4541d28 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -154,7 +154,7 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit omap_twl4030_remove(struct platform_device *pdev)
+static int omap_twl4030_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 8c5b325..4ad7609 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -152,7 +152,7 @@ static int brownstone_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit brownstone_remove(struct platform_device *pdev)
+static int brownstone_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&brownstone);
 	return 0;
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 3e08dcf..f4cce1e 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -317,7 +317,7 @@ static int corgi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit corgi_remove(struct platform_device *pdev)
+static int corgi_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 189d77c..70d799b 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -165,7 +165,7 @@ static int e740_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit e740_remove(struct platform_device *pdev)
+static int e740_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 319d55b..f94d2ab 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -147,7 +147,7 @@ static int e750_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit e750_remove(struct platform_device *pdev)
+static int e750_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 9fa2cd1..8768a64 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -137,7 +137,7 @@ static int e800_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit e800_remove(struct platform_device *pdev)
+static int e800_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 40c07b3..dcc9b04 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -204,7 +204,7 @@ static int hx4700_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit hx4700_audio_remove(struct platform_device *pdev)
+static int hx4700_audio_remove(struct platform_device *pdev)
 {
 	snd_soc_jack_free_gpios(&hs_jack, 1, &hs_jack_gpio);
 	snd_soc_unregister_card(&snd_soc_card_hx4700);
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index e89441d..eef1f7b 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -79,7 +79,7 @@ static int imote2_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit imote2_remove(struct platform_device *pdev)
+static int imote2_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 135a839..97b711e 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -202,7 +202,7 @@ static int mioa701_wm9713_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int __devexit mioa701_wm9713_remove(struct platform_device *pdev)
+static int mioa701_wm9713_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 1324673..190eb0b 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -274,7 +274,7 @@ static int mmp_pcm_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
 }
 
-static int __devexit mmp_pcm_remove(struct platform_device *pdev)
+static int mmp_pcm_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index c97ce5b0..41c3a09 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -453,7 +453,7 @@ static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &mmp_sspa_dai);
 }
 
-static int __devexit asoc_mmp_sspa_remove(struct platform_device *pdev)
+static int asoc_mmp_sspa_remove(struct platform_device *pdev)
 {
 	struct sspa_priv *priv = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index b374f09..2074e2d 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -187,7 +187,7 @@ put_device:
 	return ret;
 }
 
-static int __devexit palm27x_asoc_remove(struct platform_device *pdev)
+static int palm27x_asoc_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(palm27x_snd_device);
 	return 0;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index bc00684..fafe463 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -291,7 +291,7 @@ static int poodle_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit poodle_remove(struct platform_device *pdev)
+static int poodle_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 6a61748..d3eb0c2 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -799,7 +799,7 @@ static int asoc_ssp_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &pxa_ssp_dai);
 }
 
-static int __devexit asoc_ssp_remove(struct platform_device *pdev)
+static int asoc_ssp_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 0a6194d..4b0a009 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -249,7 +249,7 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 			ARRAY_SIZE(pxa_ac97_dai_driver));
 }
 
-static int __devexit pxa2xx_ac97_dev_remove(struct platform_device *pdev)
+static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(pxa_ac97_dai_driver));
 	return 0;
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 591ba1d..6b1a06f 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -365,7 +365,7 @@ static int pxa2xx_i2s_drv_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &pxa_i2s_dai);
 }
 
-static int __devexit pxa2xx_i2s_drv_remove(struct platform_device *pdev)
+static int pxa2xx_i2s_drv_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 9d6f78a..ecff116 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -125,7 +125,7 @@ static int pxa2xx_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &pxa2xx_soc_platform);
 }
 
-static int __devexit pxa2xx_soc_platform_remove(struct platform_device *pdev)
+static int pxa2xx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 4f6d8b1..a3fe191 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -262,7 +262,7 @@ static int tosa_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit tosa_remove(struct platform_device *pdev)
+static int tosa_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 490c76c..f4ea4f6 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -146,7 +146,7 @@ static int ttc_dkb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit ttc_dkb_remove(struct platform_device *pdev)
+static int ttc_dkb_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index 79abcd0..fee4d47 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -566,7 +566,7 @@ err_release_none:
 	return ret;
 }
 
-static void __devexit s6000_i2s_remove(struct platform_device *pdev)
+static void s6000_i2s_remove(struct platform_device *pdev)
 {
 	struct s6000_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 	struct resource *region;
diff --git a/sound/soc/s6000/s6000-pcm.c b/sound/soc/s6000/s6000-pcm.c
index d4672ba..1358c7d 100644
--- a/sound/soc/s6000/s6000-pcm.c
+++ b/sound/soc/s6000/s6000-pcm.c
@@ -505,7 +505,7 @@ static int s6000_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &s6000_soc_platform);
 }
 
-static int __devexit s6000_soc_platform_remove(struct platform_device *pdev)
+static int s6000_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 1d097f7..c9a3fff 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -478,7 +478,7 @@ err1:
 	return ret;
 }
 
-static __devexit int s3c_ac97_remove(struct platform_device *pdev)
+static int s3c_ac97_remove(struct platform_device *pdev)
 {
 	struct resource *mem_res, *irq_res;
 
diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index f7545ac..3733b01 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -429,7 +429,7 @@ static int bells_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bells_remove(struct platform_device *pdev)
+static int bells_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&bells_cards[pdev->id]);
 
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 3705a8a..897dedc 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -437,7 +437,7 @@ static int samsung_asoc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &samsung_asoc_platform);
 }
 
-static int __devexit samsung_asoc_platform_remove(struct platform_device *pdev)
+static int samsung_asoc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6a60e71..533f454 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1113,7 +1113,7 @@ err:
 	return ret;
 }
 
-static __devexit int samsung_i2s_remove(struct platform_device *pdev)
+static int samsung_i2s_remove(struct platform_device *pdev)
 {
 	struct i2s_dai *i2s, *other;
 	struct resource *res;
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 136285b..a07950b 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -421,7 +421,7 @@ static int asoc_idma_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &asoc_idma_platform);
 }
 
-static int __devexit asoc_idma_platform_remove(struct platform_device *pdev)
+static int asoc_idma_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 0d06249..86f49b2 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -314,7 +314,7 @@ static int littlemill_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit littlemill_remove(struct platform_device *pdev)
+static int littlemill_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index e4f08fc..4ab621d 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -197,7 +197,7 @@ static int lowland_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit lowland_remove(struct platform_device *pdev)
+static int lowland_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 3708658..2731457a 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -605,7 +605,7 @@ err1:
 	return ret;
 }
 
-static __devexit int s3c_pcm_dev_remove(struct platform_device *pdev)
+static int s3c_pcm_dev_remove(struct platform_device *pdev)
 {
 	struct s3c_pcm_info *pcm = &s3c_pcm[pdev->id];
 	struct resource *mem_res;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index e2db71e..7243cc3 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -165,7 +165,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 	return s3c_i2sv2_register_dai(&pdev->dev, -1, &s3c2412_i2s_dai);
 }
 
-static __devexit int s3c2412_iis_dev_remove(struct platform_device *pdev)
+static int s3c2412_iis_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 05491d9..142e130 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -470,7 +470,7 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &s3c24xx_i2s_dai);
 }
 
-static __devexit int s3c24xx_iis_dev_remove(struct platform_device *pdev)
+static int s3c24xx_iis_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 98b7c98..3564444 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -371,7 +371,7 @@ err_clk:
 }
 EXPORT_SYMBOL_GPL(simtec_audio_core_probe);
 
-int __devexit simtec_audio_remove(struct platform_device *pdev)
+int simtec_audio_remove(struct platform_device *pdev)
 {
 	struct platform_device *snd_dev = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index 649997e..b0bf4c8 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -173,7 +173,7 @@ static int snd_smdk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit snd_smdk_remove(struct platform_device *pdev)
+static int snd_smdk_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&smdk_pcm);
 	platform_set_drvdata(pdev, NULL);
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 1a01571..ede44d3 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -164,7 +164,7 @@ static int smdk_audio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit smdk_audio_remove(struct platform_device *pdev)
+static int smdk_audio_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 84d8f94..0154fb3 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -143,7 +143,7 @@ static int snd_smdk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit snd_smdk_remove(struct platform_device *pdev)
+static int snd_smdk_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_card(&smdk_pcm);
 	platform_set_drvdata(pdev, NULL);
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 5612ea8..73f6646 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -453,7 +453,7 @@ err0:
 	return ret;
 }
 
-static __devexit int spdif_remove(struct platform_device *pdev)
+static int spdif_remove(struct platform_device *pdev)
 {
 	struct samsung_spdif_info *spdif = &spdif_info;
 	struct resource *mem_res;
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 01bad86..f9ed2d6 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -337,7 +337,7 @@ static int speyside_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit speyside_remove(struct platform_device *pdev)
+static int speyside_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 01d474c..6565184 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -231,7 +231,7 @@ static int tobermory_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit tobermory_remove(struct platform_device *pdev)
+static int tobermory_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 9b06724..19eff8f 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -353,7 +353,7 @@ static int sh7760_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
 }
 
-static int __devexit sh7760_soc_platform_remove(struct platform_device *pdev)
+static int sh7760_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index 2efdd48..4cc2d64 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -316,7 +316,7 @@ static int hac_soc_platform_probe(struct platform_device *pdev)
 			ARRAY_SIZE(sh4_hac_dai));
 }
 
-static int __devexit hac_soc_platform_remove(struct platform_device *pdev)
+static int hac_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(sh4_hac_dai));
 	return 0;
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 694cb96..34facdc 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -815,7 +815,7 @@ ereqfw:
 	return ret;
 }
 
-static int __devexit siu_remove(struct platform_device *pdev)
+static int siu_remove(struct platform_device *pdev)
 {
 	struct siu_info *info = dev_get_drvdata(&pdev->dev);
 	struct resource *res;
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 1b26656..c8e73a7 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -385,7 +385,7 @@ static int sh4_soc_dai_probe(struct platform_device *pdev)
 			ARRAY_SIZE(sh4_ssi_dai));
 }
 
-static int __devexit sh4_soc_dai_remove(struct platform_device *pdev)
+static int sh4_soc_dai_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(sh4_ssi_dai));
 	return 0;
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 813689d..fe4541d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -111,7 +111,7 @@ static int snd_soc_dummy_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static __devexit int snd_soc_dummy_remove(struct platform_device *pdev)
+static int snd_soc_dummy_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 29c23d3..9b76cc5 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -189,7 +189,7 @@ static int spear_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &spear_soc_platform);
 }
 
-static int __devexit spear_soc_platform_remove(struct platform_device *pdev)
+static int spear_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 
diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index 7b0a1f5..6543184 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -200,7 +200,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra20_das_remove(struct platform_device *pdev)
+static int tegra20_das_remove(struct platform_device *pdev)
 {
 	if (!das)
 		return -ENODEV;
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 34557d3..caa772d 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -447,7 +447,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra20_i2s_platform_remove(struct platform_device *pdev)
+static int tegra20_i2s_platform_remove(struct platform_device *pdev)
 {
 	struct tegra20_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index a2f9fe8..04771d1 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -357,7 +357,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra20_spdif_platform_remove(struct platform_device *pdev)
+static int tegra20_spdif_platform_remove(struct platform_device *pdev)
 {
 	struct tegra20_spdif *spdif = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index e1cc576..f354dc3 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -585,7 +585,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra30_ahub_remove(struct platform_device *pdev)
+static int tegra30_ahub_remove(struct platform_device *pdev)
 {
 	if (!ahub)
 		return -ENODEV;
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index 18d6847..27e91dd 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -492,7 +492,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra30_i2s_platform_remove(struct platform_device *pdev)
+static int tegra30_i2s_platform_remove(struct platform_device *pdev)
 {
 	struct tegra30_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index b2e3c00..c80adb9 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -227,7 +227,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra_alc5632_remove(struct platform_device *pdev)
+static int tegra_alc5632_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(card);
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 4061984..c925ab0 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -259,7 +259,7 @@ int tegra_pcm_platform_register(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tegra_pcm_platform_register);
 
-void __devexit tegra_pcm_platform_unregister(struct device *dev)
+void tegra_pcm_platform_unregister(struct device *dev)
 {
 	snd_soc_unregister_platform(dev);
 }
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index 53008b0..c8ef88a6 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -188,7 +188,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra_wm8753_driver_remove(struct platform_device *pdev)
+static int tegra_wm8753_driver_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(card);
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 2599252..bbd79bf 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -402,7 +402,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra_wm8903_driver_remove(struct platform_device *pdev)
+static int tegra_wm8903_driver_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 055fd0e..7fcf6c2 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -183,7 +183,7 @@ err:
 	return ret;
 }
 
-static int __devexit tegra_snd_trimslice_remove(struct platform_device *pdev)
+static int tegra_snd_trimslice_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct tegra_trimslice *trimslice = snd_soc_card_get_drvdata(card);
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index 4855398..16ab696 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -208,7 +208,7 @@ static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 	return snd_soc_register_dai(&pdev->dev, &txx9aclc_ac97_dai);
 }
 
-static int __devexit txx9aclc_ac97_dev_remove(struct platform_device *pdev)
+static int txx9aclc_ac97_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index bdb8165..45a6428 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -422,7 +422,7 @@ static int txx9aclc_soc_platform_probe(struct platform_device *pdev)
 	return snd_soc_register_platform(&pdev->dev, &txx9aclc_soc_platform);
 }
 
-static int __devexit txx9aclc_soc_platform_remove(struct platform_device *pdev)
+static int txx9aclc_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index c04c927..fb694e9 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -136,7 +136,7 @@ static int mop500_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit mop500_remove(struct platform_device *pdev)
+static int mop500_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *mop500_card = platform_get_drvdata(pdev);
 
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 5e9fc81..6a284fb 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -844,7 +844,7 @@ err_pclk:
 	return ret;
 }
 
-static int __devexit ux500_msp_drv_remove(struct platform_device *pdev)
+static int ux500_msp_drv_remove(struct platform_device *pdev)
 {
 	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
 
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 9703b2d..a5cb09d 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -281,7 +281,7 @@ static struct snd_soc_platform_driver ux500_pcm_soc_drv = {
 	.pcm_new        = ux500_pcm_new,
 };
 
-static int __devexit ux500_pcm_drv_probe(struct platform_device *pdev)
+static int ux500_pcm_drv_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 0953402..b4e9254 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2086,7 +2086,7 @@ static int cs4231_probe(struct platform_device *op)
 	return -ENODEV;
 }
 
-static int __devexit cs4231_remove(struct platform_device *op)
+static int cs4231_remove(struct platform_device *op)
 {
 	struct snd_cs4231 *chip = dev_get_drvdata(&op->dev);
 
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index aca99ec..71faacb 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2663,7 +2663,7 @@ _err:
 	return err;
 }
 
-static int __devexit dbri_remove(struct platform_device *op)
+static int dbri_remove(struct platform_device *op)
 {
 	struct snd_card *card = dev_get_drvdata(&op->dev);
 
diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 9d92ecb..f78eae8 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -1007,7 +1007,7 @@ out:
 	return retval;
 }
 
-static int __devexit snd_at73c213_remove(struct spi_device *spi)
+static int snd_at73c213_remove(struct spi_device *spi)
 {
 	struct snd_card *card = dev_get_drvdata(&spi->dev);
 	struct snd_at73c213 *chip = card->private_data;
-- 
1.8.0
