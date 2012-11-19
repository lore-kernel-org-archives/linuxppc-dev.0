Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 261/493] sound: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:30 -0500
Message-Id: <1353349642-3677-261-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org,
 Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
 Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 M R Swami Reddy <mr.swami.reddy@ti.com>,
 Philipp Zabel <philipp.zabel@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>, patches@opensource.wolfsonmicro.com,
 Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
 Paul Parsons <lost.distance@yahoo.com>, cbe-oss-dev@lists.ozlabs.org,
 Thibaut Varene <T-Bone@parisc-linux.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-samsung-soc@vger.kernel.org,
 Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jaya Kumar <jayakumar.alsa@gmail.com>,
 Eric Miao <eric.y.miao@gmail.com>, linux-parisc@vger.kernel.org,
 Geoff Levand <geoff@infradead.org>, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: Clemens Ladisch <clemens@ladisch.de> 
Cc: Thibaut Varene <T-Bone@parisc-linux.org> 
Cc: Jaya Kumar <jayakumar.alsa@gmail.com> 
Cc: Geoff Levand <geoff@infradead.org> 
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
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
Cc: uclinux-dist-devel@blackfin.uclinux.org 
Cc: device-drivers-devel@blackfin.uclinux.org 
Cc: patches@opensource.wolfsonmicro.com 
Cc: linux-omap@vger.kernel.org 
Cc: linux-samsung-soc@vger.kernel.org 
---
 sound/arm/aaci.c                               | 10 +++----
 sound/arm/pxa2xx-ac97-lib.c                    |  2 +-
 sound/arm/pxa2xx-ac97.c                        |  2 +-
 sound/atmel/abdac.c                            |  4 +--
 sound/atmel/ac97c.c                            |  4 +--
 sound/drivers/aloop.c                          |  8 +++---
 sound/drivers/dummy.c                          |  8 +++---
 sound/drivers/ml403-ac97cr.c                   | 14 ++++------
 sound/drivers/mpu401/mpu401.c                  |  6 ++---
 sound/drivers/mtpav.c                          |  8 +++---
 sound/drivers/mts64.c                          | 16 ++++++------
 sound/drivers/pcsp/pcsp.c                      |  8 +++---
 sound/drivers/pcsp/pcsp_input.c                |  2 +-
 sound/drivers/pcsp/pcsp_input.h                |  2 +-
 sound/drivers/pcsp/pcsp_lib.c                  |  2 +-
 sound/drivers/pcsp/pcsp_mixer.c                |  4 +--
 sound/drivers/portman2x4.c                     | 10 +++----
 sound/drivers/serial-u16550.c                  | 10 +++----
 sound/drivers/virmidi.c                        |  2 +-
 sound/firewire/speakers.c                      |  4 +--
 sound/isa/ad1816a/ad1816a.c                    |  6 ++---
 sound/isa/ad1816a/ad1816a_lib.c                | 12 ++++-----
 sound/isa/ad1848/ad1848.c                      |  4 +--
 sound/isa/adlib.c                              |  4 +--
 sound/isa/als100.c                             |  6 ++---
 sound/isa/azt2320.c                            | 10 +++----
 sound/isa/cmi8328.c                            |  4 +--
 sound/isa/cmi8330.c                            | 16 ++++++------
 sound/isa/cs423x/cs4231.c                      |  4 +--
 sound/isa/cs423x/cs4236.c                      | 20 +++++++-------
 sound/isa/es1688/es1688.c                      | 12 ++++-----
 sound/isa/es18xx.c                             | 36 +++++++++++++-------------
 sound/isa/galaxy/galaxy.c                      | 22 ++++++++--------
 sound/isa/gus/gusclassic.c                     |  8 +++---
 sound/isa/gus/gusextreme.c                     | 12 ++++-----
 sound/isa/gus/gusmax.c                         | 10 +++----
 sound/isa/gus/interwave.c                      | 26 +++++++++----------
 sound/isa/msnd/msnd.h                          |  2 +-
 sound/isa/msnd/msnd_pinnacle.c                 | 30 ++++++++++-----------
 sound/isa/msnd/msnd_pinnacle_mixer.c           |  2 +-
 sound/isa/opl3sa2.c                            | 16 ++++++------
 sound/isa/opti9xx/miro.c                       | 26 +++++++++----------
 sound/isa/opti9xx/opti92x-ad1848.c             | 18 ++++++-------
 sound/isa/sb/emu8000.c                         | 33 ++++++++---------------
 sound/isa/sb/jazz16.c                          | 10 +++----
 sound/isa/sb/sb16.c                            | 12 ++++-----
 sound/isa/sb/sb8.c                             |  4 +--
 sound/isa/sc6000.c                             | 24 ++++++++---------
 sound/isa/sscape.c                             | 18 ++++++-------
 sound/isa/wavefront/wavefront.c                | 21 ++++++---------
 sound/isa/wavefront/wavefront_fx.c             |  3 +--
 sound/isa/wavefront/wavefront_midi.c           |  3 +--
 sound/isa/wavefront/wavefront_synth.c          | 21 +++++----------
 sound/mips/au1x00.c                            |  6 ++---
 sound/mips/hal2.c                              |  6 ++---
 sound/mips/sgio2audio.c                        |  8 +++---
 sound/oss/kahlua.c                             |  4 +--
 sound/oss/swarm_cs4297a.c                      |  2 +-
 sound/parisc/harmony.c                         | 12 +++------
 sound/pci/ad1889.c                             | 21 +++++----------
 sound/pci/ak4531_codec.c                       |  5 ++--
 sound/pci/ali5451/ali5451.c                    | 14 +++++-----
 sound/pci/als300.c                             |  6 ++---
 sound/pci/als4000.c                            |  6 ++---
 sound/pci/asihpi/asihpi.c                      | 28 ++++++++++----------
 sound/pci/asihpi/hpioctl.c                     |  2 +-
 sound/pci/asihpi/hpioctl.h                     |  2 +-
 sound/pci/atiixp.c                             | 14 +++++-----
 sound/pci/atiixp_modem.c                       | 10 +++----
 sound/pci/au88x0/au88x0.c                      |  8 +++---
 sound/pci/au88x0/au88x0_a3d.c                  |  4 +--
 sound/pci/au88x0/au88x0_core.c                 |  2 +-
 sound/pci/au88x0/au88x0_eq.c                   |  2 +-
 sound/pci/au88x0/au88x0_game.c                 |  2 +-
 sound/pci/au88x0/au88x0_mixer.c                |  2 +-
 sound/pci/au88x0/au88x0_mpu401.c               |  2 +-
 sound/pci/au88x0/au88x0_pcm.c                  |  2 +-
 sound/pci/aw2/aw2-alsa.c                       | 12 ++++-----
 sound/pci/azt3328.c                            | 21 +++++----------
 sound/pci/bt87x.c                              |  8 +++---
 sound/pci/ca0106/ca0106_main.c                 |  8 +++---
 sound/pci/ca0106/ca0106_mixer.c                | 13 +++++-----
 sound/pci/ca0106/ca0106_proc.c                 |  2 +-
 sound/pci/ca0106/ca_midi.c                     |  2 +-
 sound/pci/cmipci.c                             | 20 +++++++-------
 sound/pci/cs4281.c                             | 14 +++++-----
 sound/pci/cs46xx/cs46xx.c                      |  2 +-
 sound/pci/cs46xx/cs46xx_lib.c                  | 24 ++++++++---------
 sound/pci/cs5530.c                             |  6 ++---
 sound/pci/cs5535audio/cs5535audio.c            |  6 ++---
 sound/pci/cs5535audio/cs5535audio.h            |  6 ++---
 sound/pci/cs5535audio/cs5535audio_olpc.c       |  4 +--
 sound/pci/cs5535audio/cs5535audio_pcm.c        |  2 +-
 sound/pci/ctxfi/ctatc.c                        |  8 +++---
 sound/pci/ctxfi/ctatc.h                        |  4 +--
 sound/pci/ctxfi/cthardware.c                   |  2 +-
 sound/pci/ctxfi/cthw20k1.c                     |  2 +-
 sound/pci/ctxfi/cthw20k2.c                     |  2 +-
 sound/pci/ctxfi/xfi.c                          |  3 +--
 sound/pci/echoaudio/echoaudio.c                |  6 ++---
 sound/pci/echoaudio/echoaudio.h                |  2 +-
 sound/pci/echoaudio/midi.c                     |  2 +-
 sound/pci/emu10k1/emu10k1.c                    |  2 +-
 sound/pci/emu10k1/emu10k1_main.c               |  4 +--
 sound/pci/emu10k1/emu10k1x.c                   | 14 +++++-----
 sound/pci/emu10k1/emufx.c                      | 28 +++++++++-----------
 sound/pci/emu10k1/emumixer.c                   |  2 +-
 sound/pci/emu10k1/emumpu401.c                  |  6 ++---
 sound/pci/emu10k1/emupcm.c                     |  8 +++---
 sound/pci/emu10k1/emuproc.c                    |  2 +-
 sound/pci/emu10k1/p16v.c                       |  6 ++---
 sound/pci/emu10k1/timer.c                      |  2 +-
 sound/pci/ens1370.c                            | 20 +++++++-------
 sound/pci/es1938.c                             | 10 +++----
 sound/pci/es1968.c                             | 19 ++++++--------
 sound/pci/fm801.c                              |  8 +++---
 sound/pci/hda/hda_intel.c                      | 30 ++++++++++-----------
 sound/pci/ice1712/amp.c                        |  4 +--
 sound/pci/ice1712/aureon.c                     |  4 +--
 sound/pci/ice1712/delta.c                      |  4 +--
 sound/pci/ice1712/ews.c                        |  4 +--
 sound/pci/ice1712/hoontech.c                   | 20 +++++++-------
 sound/pci/ice1712/ice1712.c                    | 28 ++++++++++----------
 sound/pci/ice1712/ice1724.c                    | 20 +++++++-------
 sound/pci/ice1712/juli.c                       |  8 +++---
 sound/pci/ice1712/maya44.c                     |  6 ++---
 sound/pci/ice1712/phase.c                      |  8 +++---
 sound/pci/ice1712/pontis.c                     |  4 +--
 sound/pci/ice1712/prodigy192.c                 |  4 +--
 sound/pci/ice1712/prodigy_hifi.c               |  8 +++---
 sound/pci/ice1712/psc724.c                     |  4 +--
 sound/pci/ice1712/quartet.c                    |  8 +++---
 sound/pci/ice1712/revo.c                       |  6 ++---
 sound/pci/ice1712/se.c                         | 12 ++++-----
 sound/pci/ice1712/vt1720_mobo.c                |  4 +--
 sound/pci/ice1712/wtm.c                        |  4 +--
 sound/pci/intel8x0.c                           | 22 ++++++++--------
 sound/pci/intel8x0m.c                          | 12 ++++-----
 sound/pci/korg1212/korg1212.c                  |  7 +++--
 sound/pci/lola/lola.c                          |  6 ++---
 sound/pci/lola/lola_clock.c                    |  2 +-
 sound/pci/lola/lola_mixer.c                    | 16 ++++++------
 sound/pci/lola/lola_pcm.c                      |  4 +--
 sound/pci/lola/lola_proc.c                     |  2 +-
 sound/pci/lx6464es/lx6464es.c                  | 18 ++++++-------
 sound/pci/lx6464es/lx_core.c                   |  2 +-
 sound/pci/lx6464es/lx_core.h                   |  2 +-
 sound/pci/maestro3.c                           | 15 +++++------
 sound/pci/mixart/mixart.c                      |  6 ++---
 sound/pci/nm256/nm256.c                        | 14 ++++------
 sound/pci/oxygen/oxygen.c                      |  4 +--
 sound/pci/oxygen/virtuoso.c                    |  4 +--
 sound/pci/oxygen/xonar_cs43xx.c                |  2 +-
 sound/pci/oxygen/xonar_pcm179x.c               |  2 +-
 sound/pci/oxygen/xonar_wm87x6.c                |  2 +-
 sound/pci/pcxhr/pcxhr.c                        |  6 ++---
 sound/pci/riptide/riptide.c                    | 16 +++++-------
 sound/pci/rme32.c                              |  7 +++--
 sound/pci/rme96.c                              | 10 +++----
 sound/pci/rme9652/hdsp.c                       |  6 ++---
 sound/pci/rme9652/hdspm.c                      | 20 +++++++-------
 sound/pci/rme9652/rme9652.c                    | 10 +++----
 sound/pci/sis7019.c                            |  8 +++---
 sound/pci/sonicvibes.c                         | 14 +++++-----
 sound/pci/trident/trident.c                    |  2 +-
 sound/pci/trident/trident_main.c               | 18 ++++++-------
 sound/pci/via82xx.c                            | 22 ++++++++--------
 sound/pci/via82xx_modem.c                      | 10 +++----
 sound/pci/vx222/vx222.c                        |  4 +--
 sound/pci/ymfpci/ymfpci.c                      |  4 +--
 sound/pci/ymfpci/ymfpci_main.c                 | 20 +++++++-------
 sound/ppc/awacs.c                              |  3 +--
 sound/ppc/beep.c                               |  2 +-
 sound/ppc/burgundy.c                           |  2 +-
 sound/ppc/daca.c                               |  2 +-
 sound/ppc/keywest.c                            |  4 +--
 sound/ppc/pmac.c                               | 10 +++----
 sound/ppc/powermac.c                           |  2 +-
 sound/ppc/snd_ps3.c                            | 12 ++++-----
 sound/ppc/tumbler.c                            |  4 +--
 sound/sh/aica.c                                |  4 +--
 sound/sh/sh_dac_audio.c                        |  6 ++---
 sound/soc/atmel/atmel-pcm.c                    |  2 +-
 sound/soc/atmel/atmel_ssc_dai.c                |  2 +-
 sound/soc/atmel/sam9g20_wm8731.c               |  2 +-
 sound/soc/au1x/ac97c.c                         |  2 +-
 sound/soc/au1x/db1000.c                        |  2 +-
 sound/soc/au1x/db1200.c                        |  2 +-
 sound/soc/au1x/dbdma2.c                        |  2 +-
 sound/soc/au1x/dma.c                           |  2 +-
 sound/soc/au1x/i2sc.c                          |  2 +-
 sound/soc/au1x/psc-ac97.c                      |  2 +-
 sound/soc/au1x/psc-i2s.c                       |  2 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c            |  2 +-
 sound/soc/blackfin/bf5xx-ac97.c                |  2 +-
 sound/soc/blackfin/bf5xx-ad1836.c              |  2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c             |  2 +-
 sound/soc/blackfin/bf5xx-i2s.c                 |  2 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c             |  2 +-
 sound/soc/blackfin/bf5xx-tdm.c                 |  2 +-
 sound/soc/blackfin/bf6xx-i2s.c                 |  2 +-
 sound/soc/cirrus/edb93xx.c                     |  2 +-
 sound/soc/cirrus/ep93xx-ac97.c                 |  2 +-
 sound/soc/cirrus/ep93xx-pcm.c                  |  2 +-
 sound/soc/cirrus/simone.c                      |  2 +-
 sound/soc/cirrus/snappercl15.c                 |  2 +-
 sound/soc/codecs/88pm860x-codec.c              |  2 +-
 sound/soc/codecs/ab8500-codec.c                |  2 +-
 sound/soc/codecs/ac97.c                        |  2 +-
 sound/soc/codecs/ad1836.c                      |  2 +-
 sound/soc/codecs/ad193x.c                      |  4 +--
 sound/soc/codecs/ad1980.c                      |  2 +-
 sound/soc/codecs/adau1373.c                    |  2 +-
 sound/soc/codecs/adau1701.c                    |  2 +-
 sound/soc/codecs/adav80x.c                     |  6 ++---
 sound/soc/codecs/ads117x.c                     |  2 +-
 sound/soc/codecs/ak4535.c                      |  2 +-
 sound/soc/codecs/ak4641.c                      |  2 +-
 sound/soc/codecs/ak4642.c                      |  2 +-
 sound/soc/codecs/ak4671.c                      |  2 +-
 sound/soc/codecs/alc5623.c                     |  2 +-
 sound/soc/codecs/alc5632.c                     |  2 +-
 sound/soc/codecs/cs4271.c                      |  4 +--
 sound/soc/codecs/cs42l73.c                     |  2 +-
 sound/soc/codecs/da7210.c                      |  4 +--
 sound/soc/codecs/da732x.c                      |  2 +-
 sound/soc/codecs/da9055.c                      |  2 +-
 sound/soc/codecs/dfbmcs320.c                   |  2 +-
 sound/soc/codecs/dmic.c                        |  2 +-
 sound/soc/codecs/isabelle.c                    |  2 +-
 sound/soc/codecs/jz4740.c                      |  2 +-
 sound/soc/codecs/lm4857.c                      |  2 +-
 sound/soc/codecs/lm49453.c                     |  2 +-
 sound/soc/codecs/max9768.c                     |  2 +-
 sound/soc/codecs/max9850.c                     |  2 +-
 sound/soc/codecs/max9877.c                     |  2 +-
 sound/soc/codecs/ml26124.c                     |  2 +-
 sound/soc/codecs/omap-hdmi.c                   |  2 +-
 sound/soc/codecs/pcm3008.c                     |  2 +-
 sound/soc/codecs/sgtl5000.c                    |  2 +-
 sound/soc/codecs/si476x.c                      |  2 +-
 sound/soc/codecs/sn95031.c                     |  2 +-
 sound/soc/codecs/ssm2602.c                     |  4 +--
 sound/soc/codecs/sta32x.c                      |  2 +-
 sound/soc/codecs/sta529.c                      |  2 +-
 sound/soc/codecs/stac9766.c                    |  2 +-
 sound/soc/codecs/tlv320aic32x4.c               |  2 +-
 sound/soc/codecs/tlv320dac33.c                 |  2 +-
 sound/soc/codecs/tpa6130a2.c                   |  2 +-
 sound/soc/codecs/twl4030.c                     |  2 +-
 sound/soc/codecs/twl6040.c                     |  2 +-
 sound/soc/codecs/uda134x.c                     |  2 +-
 sound/soc/codecs/uda1380.c                     |  2 +-
 sound/soc/codecs/wl1273.c                      |  2 +-
 sound/soc/codecs/wm0010.c                      |  2 +-
 sound/soc/codecs/wm1250-ev1.c                  |  4 +--
 sound/soc/codecs/wm2000.c                      |  2 +-
 sound/soc/codecs/wm2200.c                      |  2 +-
 sound/soc/codecs/wm5100.c                      |  2 +-
 sound/soc/codecs/wm5102.c                      |  2 +-
 sound/soc/codecs/wm5110.c                      |  2 +-
 sound/soc/codecs/wm8350.c                      |  2 +-
 sound/soc/codecs/wm8400.c                      |  2 +-
 sound/soc/codecs/wm8510.c                      |  4 +--
 sound/soc/codecs/wm8523.c                      |  2 +-
 sound/soc/codecs/wm8711.c                      |  4 +--
 sound/soc/codecs/wm8727.c                      |  2 +-
 sound/soc/codecs/wm8728.c                      |  4 +--
 sound/soc/codecs/wm8731.c                      |  4 +--
 sound/soc/codecs/wm8737.c                      |  4 +--
 sound/soc/codecs/wm8741.c                      |  2 +-
 sound/soc/codecs/wm8750.c                      |  4 +--
 sound/soc/codecs/wm8753.c                      |  4 +--
 sound/soc/codecs/wm8770.c                      |  2 +-
 sound/soc/codecs/wm8776.c                      |  4 +--
 sound/soc/codecs/wm8782.c                      |  2 +-
 sound/soc/codecs/wm8804.c                      |  4 +--
 sound/soc/codecs/wm8900.c                      |  4 +--
 sound/soc/codecs/wm8903.c                      |  2 +-
 sound/soc/codecs/wm8904.c                      |  2 +-
 sound/soc/codecs/wm8940.c                      |  2 +-
 sound/soc/codecs/wm8955.c                      |  2 +-
 sound/soc/codecs/wm8960.c                      |  2 +-
 sound/soc/codecs/wm8961.c                      |  2 +-
 sound/soc/codecs/wm8962.c                      |  2 +-
 sound/soc/codecs/wm8971.c                      |  2 +-
 sound/soc/codecs/wm8974.c                      |  2 +-
 sound/soc/codecs/wm8978.c                      |  2 +-
 sound/soc/codecs/wm8983.c                      |  4 +--
 sound/soc/codecs/wm8985.c                      |  4 +--
 sound/soc/codecs/wm8988.c                      |  4 +--
 sound/soc/codecs/wm8990.c                      |  2 +-
 sound/soc/codecs/wm8991.c                      |  2 +-
 sound/soc/codecs/wm8993.c                      |  2 +-
 sound/soc/codecs/wm8994.c                      |  2 +-
 sound/soc/codecs/wm8995.c                      |  4 +--
 sound/soc/codecs/wm8996.c                      |  2 +-
 sound/soc/codecs/wm9081.c                      |  2 +-
 sound/soc/codecs/wm9705.c                      |  2 +-
 sound/soc/codecs/wm9712.c                      |  2 +-
 sound/soc/codecs/wm9713.c                      |  2 +-
 sound/soc/fsl/eukrea-tlv320.c                  |  2 +-
 sound/soc/fsl/fsl_dma.c                        |  2 +-
 sound/soc/fsl/fsl_ssi.c                        |  2 +-
 sound/soc/fsl/imx-audmux.c                     |  2 +-
 sound/soc/fsl/imx-mc13783.c                    |  2 +-
 sound/soc/fsl/imx-pcm-dma.c                    |  2 +-
 sound/soc/fsl/imx-pcm-fiq.c                    |  2 +-
 sound/soc/fsl/imx-sgtl5000.c                   |  2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c               |  2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                |  2 +-
 sound/soc/fsl/mx27vis-aic32x4.c                |  2 +-
 sound/soc/jz4740/jz4740-i2s.c                  |  2 +-
 sound/soc/jz4740/jz4740-pcm.c                  |  2 +-
 sound/soc/jz4740/qi_lb60.c                     |  2 +-
 sound/soc/kirkwood/kirkwood-dma.c              |  2 +-
 sound/soc/kirkwood/kirkwood-i2s.c              |  2 +-
 sound/soc/kirkwood/kirkwood-openrd.c           |  2 +-
 sound/soc/kirkwood/kirkwood-t5325.c            |  2 +-
 sound/soc/mid-x86/mfld_machine.c               |  2 +-
 sound/soc/mxs/mxs-pcm.c                        |  2 +-
 sound/soc/mxs/mxs-saif.c                       |  2 +-
 sound/soc/mxs/mxs-sgtl5000.c                   |  4 +--
 sound/soc/nuc900/nuc900-ac97.c                 |  2 +-
 sound/soc/nuc900/nuc900-pcm.c                  |  2 +-
 sound/soc/omap/ams-delta.c                     |  2 +-
 sound/soc/omap/mcbsp.c                         |  4 +--
 sound/soc/omap/mcbsp.h                         |  2 +-
 sound/soc/omap/omap-abe-twl6040.c              |  2 +-
 sound/soc/omap/omap-dmic.c                     |  2 +-
 sound/soc/omap/omap-hdmi-card.c                |  2 +-
 sound/soc/omap/omap-hdmi.c                     |  2 +-
 sound/soc/omap/omap-mcbsp.c                    |  2 +-
 sound/soc/omap/omap-mcpdm.c                    |  2 +-
 sound/soc/omap/omap-pcm.c                      |  2 +-
 sound/soc/omap/omap-twl4030.c                  |  2 +-
 sound/soc/pxa/brownstone.c                     |  2 +-
 sound/soc/pxa/corgi.c                          |  2 +-
 sound/soc/pxa/e740_wm9705.c                    |  2 +-
 sound/soc/pxa/e750_wm9705.c                    |  2 +-
 sound/soc/pxa/e800_wm9712.c                    |  2 +-
 sound/soc/pxa/hx4700.c                         |  2 +-
 sound/soc/pxa/imote2.c                         |  2 +-
 sound/soc/pxa/mioa701_wm9713.c                 |  2 +-
 sound/soc/pxa/mmp-pcm.c                        |  2 +-
 sound/soc/pxa/mmp-sspa.c                       |  2 +-
 sound/soc/pxa/poodle.c                         |  2 +-
 sound/soc/pxa/pxa-ssp.c                        |  2 +-
 sound/soc/pxa/pxa2xx-ac97.c                    |  4 +--
 sound/soc/pxa/pxa2xx-pcm.c                     |  2 +-
 sound/soc/pxa/tosa.c                           |  2 +-
 sound/soc/pxa/ttc-dkb.c                        |  2 +-
 sound/soc/s6000/s6000-i2s.c                    |  2 +-
 sound/soc/s6000/s6000-pcm.c                    |  2 +-
 sound/soc/samsung/ac97.c                       |  2 +-
 sound/soc/samsung/bells.c                      |  2 +-
 sound/soc/samsung/dma.c                        |  2 +-
 sound/soc/samsung/i2s.c                        |  5 ++--
 sound/soc/samsung/idma.c                       |  2 +-
 sound/soc/samsung/littlemill.c                 |  2 +-
 sound/soc/samsung/lowland.c                    |  2 +-
 sound/soc/samsung/pcm.c                        |  2 +-
 sound/soc/samsung/s3c2412-i2s.c                |  2 +-
 sound/soc/samsung/s3c24xx-i2s.c                |  2 +-
 sound/soc/samsung/s3c24xx_simtec.c             |  2 +-
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |  2 +-
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |  2 +-
 sound/soc/samsung/smdk_wm8580pcm.c             |  2 +-
 sound/soc/samsung/smdk_wm8994.c                |  2 +-
 sound/soc/samsung/smdk_wm8994pcm.c             |  2 +-
 sound/soc/samsung/spdif.c                      |  2 +-
 sound/soc/samsung/speyside.c                   |  2 +-
 sound/soc/samsung/tobermory.c                  |  2 +-
 sound/soc/sh/dma-sh7760.c                      |  2 +-
 sound/soc/sh/hac.c                             |  2 +-
 sound/soc/sh/siu_dai.c                         |  2 +-
 sound/soc/sh/ssi.c                             |  2 +-
 sound/soc/soc-utils.c                          |  2 +-
 sound/soc/spear/spear_pcm.c                    |  2 +-
 sound/soc/tegra/tegra20_das.c                  |  2 +-
 sound/soc/tegra/tegra20_i2s.c                  |  2 +-
 sound/soc/tegra/tegra20_spdif.c                |  2 +-
 sound/soc/tegra/tegra30_ahub.c                 |  2 +-
 sound/soc/tegra/tegra30_i2s.c                  |  2 +-
 sound/soc/tegra/tegra_alc5632.c                |  2 +-
 sound/soc/tegra/tegra_pcm.c                    |  2 +-
 sound/soc/tegra/tegra_wm8753.c                 |  2 +-
 sound/soc/tegra/tegra_wm8903.c                 |  2 +-
 sound/soc/tegra/trimslice.c                    |  2 +-
 sound/soc/txx9/txx9aclc-ac97.c                 |  2 +-
 sound/soc/txx9/txx9aclc.c                      |  2 +-
 sound/soc/ux500/mop500.c                       |  4 +--
 sound/soc/ux500/ux500_msp_dai.c                |  2 +-
 sound/soc/ux500/ux500_pcm.c                    |  2 +-
 sound/sparc/amd7930.c                          |  8 +++---
 sound/sparc/cs4231.c                           | 24 ++++++++---------
 sound/sparc/dbri.c                             | 18 ++++++-------
 sound/spi/at73c213.c                           | 12 ++++-----
 398 files changed, 1042 insertions(+), 1120 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index eb9cad3..5ea9724 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -832,7 +832,7 @@ static struct snd_ac97_bus_ops aaci_bus_ops = {
 	.read	= aaci_ac97_read,
 };
 
-static int __devinit aaci_probe_ac97(struct aaci *aaci)
+static int aaci_probe_ac97(struct aaci *aaci)
 {
 	struct snd_ac97_template ac97_template;
 	struct snd_ac97_bus *ac97_bus;
@@ -893,7 +893,7 @@ static void aaci_free_card(struct snd_card *card)
 		iounmap(aaci->base);
 }
 
-static struct aaci * __devinit aaci_init_card(struct amba_device *dev)
+static struct aaci *aaci_init_card(struct amba_device *dev)
 {
 	struct aaci *aaci;
 	struct snd_card *card;
@@ -926,7 +926,7 @@ static struct aaci * __devinit aaci_init_card(struct amba_device *dev)
 	return aaci;
 }
 
-static int __devinit aaci_init_pcm(struct aaci *aaci)
+static int aaci_init_pcm(struct aaci *aaci)
 {
 	struct snd_pcm *pcm;
 	int ret;
@@ -948,7 +948,7 @@ static int __devinit aaci_init_pcm(struct aaci *aaci)
 	return ret;
 }
 
-static unsigned int __devinit aaci_size_fifo(struct aaci *aaci)
+static unsigned int aaci_size_fifo(struct aaci *aaci)
 {
 	struct aaci_runtime *aacirun = &aaci->playback;
 	int i;
@@ -984,7 +984,7 @@ static unsigned int __devinit aaci_size_fifo(struct aaci *aaci)
 	return i;
 }
 
-static int __devinit aaci_probe(struct amba_device *dev,
+static int aaci_probe(struct amba_device *dev,
 	const struct amba_id *id)
 {
 	struct aaci *aaci;
diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 48d7c0a..6fc0ae9 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -314,7 +314,7 @@ int pxa2xx_ac97_hw_resume(void)
 EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_resume);
 #endif
 
-int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
+int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 {
 	int ret;
 	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 6a5d7b3..59ffc3e 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -163,7 +163,7 @@ static int pxa2xx_ac97_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pxa2xx_ac97_pm_ops, pxa2xx_ac97_suspend, pxa2xx_ac97_resume);
 #endif
 
-static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
+static int pxa2xx_ac97_probe(struct platform_device *dev)
 {
 	struct snd_card *card;
 	struct snd_ac97_bus *ac97_bus;
diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index ba14434..d3b9cf5 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -309,7 +309,7 @@ static struct snd_pcm_ops atmel_abdac_ops = {
 	.pointer	= atmel_abdac_pointer,
 };
 
-static int __devinit atmel_abdac_pcm_new(struct atmel_abdac *dac)
+static int atmel_abdac_pcm_new(struct atmel_abdac *dac)
 {
 	struct snd_pcm_hardware hw = atmel_abdac_hw;
 	struct snd_pcm *pcm;
@@ -386,7 +386,7 @@ static int set_sample_rates(struct atmel_abdac *dac)
 	return retval;
 }
 
-static int __devinit atmel_abdac_probe(struct platform_device *pdev)
+static int atmel_abdac_probe(struct platform_device *pdev)
 {
 	struct snd_card		*card;
 	struct atmel_abdac	*dac;
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index a4bcd8d..ebe992b 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -756,7 +756,7 @@ static struct ac97_pcm at91_ac97_pcm_defs[] __devinitdata = {
 	},
 };
 
-static int __devinit atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
+static int atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
 {
 	struct snd_pcm		*pcm;
 	struct snd_pcm_hardware	hw = atmel_ac97c_hw;
@@ -902,7 +902,7 @@ static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 	}
 }
 
-static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
+static int atmel_ac97c_probe(struct platform_device *pdev)
 {
 	struct snd_card			*card;
 	struct atmel_ac97c		*chip;
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index c4ed8ef..93c19e0 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -774,7 +774,7 @@ static struct snd_pcm_ops loopback_capture_ops = {
 	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
-static int __devinit loopback_pcm_new(struct loopback *loopback,
+static int loopback_pcm_new(struct loopback *loopback,
 				      int device, int substreams)
 {
 	struct snd_pcm *pcm;
@@ -998,7 +998,7 @@ static struct snd_kcontrol_new loopback_controls[]  __devinitdata = {
 }
 };
 
-static int __devinit loopback_mixer_new(struct loopback *loopback, int notify)
+static int loopback_mixer_new(struct loopback *loopback, int notify)
 {
 	struct snd_card *card = loopback->card;
 	struct snd_pcm *pcm;
@@ -1111,7 +1111,7 @@ static void print_cable_info(struct snd_info_entry *entry,
 	mutex_unlock(&loopback->cable_lock);
 }
 
-static int __devinit loopback_proc_new(struct loopback *loopback, int cidx)
+static int loopback_proc_new(struct loopback *loopback, int cidx)
 {
 	char name[32];
 	struct snd_info_entry *entry;
@@ -1132,7 +1132,7 @@ static int __devinit loopback_proc_new(struct loopback *loopback, int cidx)
 
 #endif
 
-static int __devinit loopback_probe(struct platform_device *devptr)
+static int loopback_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
 	struct loopback *loopback;
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 339a924..7cfb2f2 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -688,7 +688,7 @@ static struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.page =		dummy_pcm_page,
 };
 
-static int __devinit snd_card_dummy_pcm(struct snd_dummy *dummy, int device,
+static int snd_card_dummy_pcm(struct snd_dummy *dummy, int device,
 					int substreams)
 {
 	struct snd_pcm *pcm;
@@ -891,7 +891,7 @@ DUMMY_CAPSRC("CD Capture Switch", 0, MIXER_ADDR_CD),
 },
 };
 
-static int __devinit snd_card_dummy_new_mixer(struct snd_dummy *dummy)
+static int snd_card_dummy_new_mixer(struct snd_dummy *dummy)
 {
 	struct snd_card *card = dummy->card;
 	struct snd_kcontrol *kcontrol;
@@ -1031,7 +1031,7 @@ static void dummy_proc_write(struct snd_info_entry *entry,
 	}
 }
 
-static void __devinit dummy_proc_init(struct snd_dummy *chip)
+static void dummy_proc_init(struct snd_dummy *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1046,7 +1046,7 @@ static void __devinit dummy_proc_init(struct snd_dummy *chip)
 #define dummy_proc_init(x)
 #endif /* CONFIG_SND_DEBUG && CONFIG_PROC_FS */
 
-static int __devinit snd_dummy_probe(struct platform_device *devptr)
+static int snd_dummy_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
 	struct snd_dummy *dummy;
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 6c83b1a..9a1f56f 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1063,8 +1063,7 @@ snd_ml403_ac97cr_codec_write(struct snd_ac97 *ac97, unsigned short reg,
 	return;
 }
 
-static int __devinit
-snd_ml403_ac97cr_chip_init(struct snd_ml403_ac97cr *ml403_ac97cr)
+static int snd_ml403_ac97cr_chip_init(struct snd_ml403_ac97cr *ml403_ac97cr)
 {
 	unsigned long end_time;
 	PDEBUG(INIT_INFO, "chip_init():\n");
@@ -1108,8 +1107,7 @@ static int snd_ml403_ac97cr_dev_free(struct snd_device *snddev)
 	return snd_ml403_ac97cr_free(ml403_ac97cr);
 }
 
-static int __devinit
-snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
+static int snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 			struct snd_ml403_ac97cr **rml403_ac97cr)
 {
 	struct snd_ml403_ac97cr *ml403_ac97cr;
@@ -1204,8 +1202,7 @@ static void snd_ml403_ac97cr_mixer_free(struct snd_ac97 *ac97)
 	PDEBUG(INIT_INFO, "mixer_free(): (done)\n");
 }
 
-static int __devinit
-snd_ml403_ac97cr_mixer(struct snd_ml403_ac97cr *ml403_ac97cr)
+static int snd_ml403_ac97cr_mixer(struct snd_ml403_ac97cr *ml403_ac97cr)
 {
 	struct snd_ac97_bus *bus;
 	struct snd_ac97_template ac97;
@@ -1237,8 +1234,7 @@ snd_ml403_ac97cr_mixer(struct snd_ml403_ac97cr *ml403_ac97cr)
 	return err;
 }
 
-static int __devinit
-snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device,
+static int snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device,
 		     struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
@@ -1268,7 +1264,7 @@ snd_ml403_ac97cr_pcm(struct snd_ml403_ac97cr *ml403_ac97cr, int device,
 	return 0;
 }
 
-static int __devinit snd_ml403_ac97cr_probe(struct platform_device *pfdev)
+static int snd_ml403_ac97cr_probe(struct platform_device *pfdev)
 {
 	struct snd_card *card;
 	struct snd_ml403_ac97cr *ml403_ac97cr = NULL;
diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index 5a7136e..5c10699 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -100,7 +100,7 @@ static int snd_mpu401_create(int dev, struct snd_card **rcard)
 	return err;
 }
 
-static int __devinit snd_mpu401_probe(struct platform_device *devptr)
+static int snd_mpu401_probe(struct platform_device *devptr)
 {
 	int dev = devptr->id;
 	int err;
@@ -156,7 +156,7 @@ static struct pnp_device_id snd_mpu401_pnpids[] = {
 
 MODULE_DEVICE_TABLE(pnp, snd_mpu401_pnpids);
 
-static int __devinit snd_mpu401_pnp(int dev, struct pnp_dev *device,
+static int snd_mpu401_pnp(int dev, struct pnp_dev *device,
 				 const struct pnp_device_id *id)
 {
 	if (!pnp_port_valid(device, 0) ||
@@ -182,7 +182,7 @@ static int __devinit snd_mpu401_pnp(int dev, struct pnp_dev *device,
 	return 0;
 }
 
-static int __devinit snd_mpu401_pnp_probe(struct pnp_dev *pnp_dev,
+static int snd_mpu401_pnp_probe(struct pnp_dev *pnp_dev,
 					  const struct pnp_device_id *id)
 {
 	static int dev;
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index ebeff33..8fd51d5 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -583,7 +583,7 @@ static irqreturn_t snd_mtpav_irqh(int irq, void *dev_id)
 /*
  * get ISA resources
  */
-static int __devinit snd_mtpav_get_ISA(struct mtpav * mcard)
+static int snd_mtpav_get_ISA(struct mtpav * mcard)
 {
 	if ((mcard->res_port = request_region(port, 3, "MotuMTPAV MIDI")) == NULL) {
 		snd_printk(KERN_ERR "MTVAP port 0x%lx is busy\n", port);
@@ -619,7 +619,7 @@ static struct snd_rawmidi_ops snd_mtpav_input = {
  * get RAWMIDI resources
  */
 
-static void __devinit snd_mtpav_set_name(struct mtpav *chip,
+static void snd_mtpav_set_name(struct mtpav *chip,
 				      struct snd_rawmidi_substream *substream)
 {
 	if (substream->number >= 0 && substream->number < chip->num_ports)
@@ -634,7 +634,7 @@ static void __devinit snd_mtpav_set_name(struct mtpav *chip,
 		strcpy(substream->name, "MTP broadcast");
 }
 
-static int __devinit snd_mtpav_get_RAWMIDI(struct mtpav *mcard)
+static int snd_mtpav_get_RAWMIDI(struct mtpav *mcard)
 {
 	int rval;
 	struct snd_rawmidi *rawmidi;
@@ -691,7 +691,7 @@ static void snd_mtpav_free(struct snd_card *card)
 
 /*
  */
-static int __devinit snd_mtpav_probe(struct platform_device *dev)
+static int snd_mtpav_probe(struct platform_device *dev)
 {
 	struct snd_card *card;
 	int err;
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index d2b9e09..2cbacb4 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -83,7 +83,7 @@ static int snd_mts64_free(struct mts64 *mts)
 	return 0;
 }
 
-static int __devinit snd_mts64_create(struct snd_card *card, 
+static int snd_mts64_create(struct snd_card *card,
 				      struct pardevice *pardev, 
 				      struct mts64 **rchip)
 {
@@ -214,7 +214,7 @@ static int mts64_device_ready(struct parport *p)
  *  0 init ok
  *  -EIO failure
  */
-static int __devinit mts64_device_init(struct parport *p)
+static int mts64_device_init(struct parport *p)
 {
 	int i;
 
@@ -290,7 +290,7 @@ static u8 mts64_map_midi_input(u8 c)
  *  0       device found
  *  -ENODEV no device
  */
-static int __devinit mts64_probe(struct parport *p)
+static int mts64_probe(struct parport *p)
 {
 	u8 c;
 
@@ -663,7 +663,7 @@ static struct snd_kcontrol_new mts64_ctl_smpte_fps __devinitdata = {
 };
 
 
-static int __devinit snd_mts64_ctl_create(struct snd_card *card, 
+static int snd_mts64_ctl_create(struct snd_card *card,
 					  struct mts64 *mts) 
 {
 	int err, i;
@@ -774,7 +774,7 @@ static struct snd_rawmidi_ops snd_mts64_rawmidi_input_ops = {
 };
 
 /* Create and initialize the rawmidi component */
-static int __devinit snd_mts64_rawmidi_create(struct snd_card *card)
+static int snd_mts64_rawmidi_create(struct snd_card *card)
 {
 	struct mts64 *mts = card->private_data;
 	struct snd_rawmidi *rmidi;
@@ -860,7 +860,7 @@ __out:
 	spin_unlock(&mts->lock);
 }
 
-static int __devinit snd_mts64_probe_port(struct parport *p)
+static int snd_mts64_probe_port(struct parport *p)
 {
 	struct pardevice *pardev;
 	int res;
@@ -884,7 +884,7 @@ static int __devinit snd_mts64_probe_port(struct parport *p)
 	return res;
 }
 
-static void __devinit snd_mts64_attach(struct parport *p)
+static void snd_mts64_attach(struct parport *p)
 {
 	struct platform_device *device;
 
@@ -940,7 +940,7 @@ static void snd_mts64_card_private_free(struct snd_card *card)
 	snd_mts64_free(mts);
 }
 
-static int __devinit snd_mts64_probe(struct platform_device *pdev)
+static int snd_mts64_probe(struct platform_device *pdev)
 {
 	struct pardevice *pardev;
 	struct parport *p;
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index c9e5af9..0ad0105 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -39,7 +39,7 @@ MODULE_PARM_DESC(nopcm, "Disable PC-Speaker PCM sound. Only beeps remain.");
 
 struct snd_pcsp pcsp_chip;
 
-static int __devinit snd_pcsp_create(struct snd_card *card)
+static int snd_pcsp_create(struct snd_card *card)
 {
 	static struct snd_device_ops ops = { };
 	struct timespec tp;
@@ -93,7 +93,7 @@ static int __devinit snd_pcsp_create(struct snd_card *card)
 	return 0;
 }
 
-static int __devinit snd_card_pcsp_probe(int devnum, struct device *dev)
+static int snd_card_pcsp_probe(int devnum, struct device *dev)
 {
 	struct snd_card *card;
 	int err;
@@ -142,7 +142,7 @@ static int __devinit snd_card_pcsp_probe(int devnum, struct device *dev)
 	return 0;
 }
 
-static int __devinit alsa_card_pcsp_init(struct device *dev)
+static int alsa_card_pcsp_init(struct device *dev)
 {
 	int err;
 
@@ -166,7 +166,7 @@ static void __devexit alsa_card_pcsp_exit(struct snd_pcsp *chip)
 	snd_card_free(chip->card);
 }
 
-static int __devinit pcsp_probe(struct platform_device *dev)
+static int pcsp_probe(struct platform_device *dev)
 {
 	int err;
 
diff --git a/sound/drivers/pcsp/pcsp_input.c b/sound/drivers/pcsp/pcsp_input.c
index b5e2b54..b874b0a 100644
--- a/sound/drivers/pcsp/pcsp_input.c
+++ b/sound/drivers/pcsp/pcsp_input.c
@@ -77,7 +77,7 @@ static int pcspkr_input_event(struct input_dev *dev, unsigned int type,
 	return 0;
 }
 
-int __devinit pcspkr_input_init(struct input_dev **rdev, struct device *dev)
+int pcspkr_input_init(struct input_dev **rdev, struct device *dev)
 {
 	int err;
 
diff --git a/sound/drivers/pcsp/pcsp_input.h b/sound/drivers/pcsp/pcsp_input.h
index e66738c..d692749 100644
--- a/sound/drivers/pcsp/pcsp_input.h
+++ b/sound/drivers/pcsp/pcsp_input.h
@@ -7,7 +7,7 @@
 #ifndef __PCSP_INPUT_H__
 #define __PCSP_INPUT_H__
 
-int __devinit pcspkr_input_init(struct input_dev **rdev, struct device *dev);
+int pcspkr_input_init(struct input_dev **rdev, struct device *dev);
 int pcspkr_input_remove(struct input_dev *dev);
 void pcspkr_stop_sound(void);
 
diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 434981d..29ebaa4 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -334,7 +334,7 @@ static struct snd_pcm_ops snd_pcsp_playback_ops = {
 	.pointer = snd_pcsp_playback_pointer,
 };
 
-int __devinit snd_pcsp_new_pcm(struct snd_pcsp *chip)
+int snd_pcsp_new_pcm(struct snd_pcsp *chip)
 {
 	int err;
 
diff --git a/sound/drivers/pcsp/pcsp_mixer.c b/sound/drivers/pcsp/pcsp_mixer.c
index 6f633f4..82bb082 100644
--- a/sound/drivers/pcsp/pcsp_mixer.c
+++ b/sound/drivers/pcsp/pcsp_mixer.c
@@ -128,7 +128,7 @@ static struct snd_kcontrol_new __devinitdata snd_pcsp_controls_spkr[] = {
 	PCSP_MIXER_CONTROL(pcspkr, "Beep Playback Switch"),
 };
 
-static int __devinit snd_pcsp_ctls_add(struct snd_pcsp *chip,
+static int snd_pcsp_ctls_add(struct snd_pcsp *chip,
 	struct snd_kcontrol_new *ctls, int num)
 {
 	int i, err;
@@ -141,7 +141,7 @@ static int __devinit snd_pcsp_ctls_add(struct snd_pcsp *chip,
 	return 0;
 }
 
-int __devinit snd_pcsp_new_mixer(struct snd_pcsp *chip, int nopcm)
+int snd_pcsp_new_mixer(struct snd_pcsp *chip, int nopcm)
 {
 	int err;
 	struct snd_card *card = chip->card;
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index c7df9dd..bc4be6f 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -96,7 +96,7 @@ static int portman_free(struct portman *pm)
 	return 0;
 }
 
-static int __devinit portman_create(struct snd_card *card, 
+static int portman_create(struct snd_card *card,
 				    struct pardevice *pardev, 
 				    struct portman **rchip)
 {
@@ -561,7 +561,7 @@ static struct snd_rawmidi_ops snd_portman_midi_input = {
 };
 
 /* Create and initialize the rawmidi component */
-static int __devinit snd_portman_rawmidi_create(struct snd_card *card)
+static int snd_portman_rawmidi_create(struct snd_card *card)
 {
 	struct portman *pm = card->private_data;
 	struct snd_rawmidi *rmidi;
@@ -648,7 +648,7 @@ static void snd_portman_interrupt(void *userdata)
 	spin_unlock(&pm->reg_lock);
 }
 
-static int __devinit snd_portman_probe_port(struct parport *p)
+static int snd_portman_probe_port(struct parport *p)
 {
 	struct pardevice *pardev;
 	int res;
@@ -672,7 +672,7 @@ static int __devinit snd_portman_probe_port(struct parport *p)
 	return res ? -EIO : 0;
 }
 
-static void __devinit snd_portman_attach(struct parport *p)
+static void snd_portman_attach(struct parport *p)
 {
 	struct platform_device *device;
 
@@ -728,7 +728,7 @@ static void snd_portman_card_private_free(struct snd_card *card)
 	portman_free(pm);
 }
 
-static int __devinit snd_portman_probe(struct platform_device *pdev)
+static int snd_portman_probe(struct platform_device *pdev)
 {
 	struct pardevice *pardev;
 	struct parport *p;
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 8930e23..310b075 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -328,7 +328,7 @@ static void snd_uart16550_buffer_timer(unsigned long data)
  *  return 0 if found
  *  return negative error if not found
  */
-static int __devinit snd_uart16550_detect(struct snd_uart16550 *uart)
+static int snd_uart16550_detect(struct snd_uart16550 *uart)
 {
 	unsigned long io_base = uart->base;
 	int ok;
@@ -783,7 +783,7 @@ static int snd_uart16550_dev_free(struct snd_device *device)
 	return snd_uart16550_free(uart);
 }
 
-static int __devinit snd_uart16550_create(struct snd_card *card,
+static int snd_uart16550_create(struct snd_card *card,
 				       unsigned long iobase,
 				       int irq,
 				       unsigned int speed,
@@ -863,7 +863,7 @@ static int __devinit snd_uart16550_create(struct snd_card *card,
 	return 0;
 }
 
-static void __devinit snd_uart16550_substreams(struct snd_rawmidi_str *stream)
+static void snd_uart16550_substreams(struct snd_rawmidi_str *stream)
 {
 	struct snd_rawmidi_substream *substream;
 
@@ -872,7 +872,7 @@ static void __devinit snd_uart16550_substreams(struct snd_rawmidi_str *stream)
 	}
 }
 
-static int __devinit snd_uart16550_rmidi(struct snd_uart16550 *uart, int device,
+static int snd_uart16550_rmidi(struct snd_uart16550 *uart, int device,
 				      int outs, int ins,
 				      struct snd_rawmidi **rmidi)
 {
@@ -899,7 +899,7 @@ static int __devinit snd_uart16550_rmidi(struct snd_uart16550 *uart, int device,
 	return 0;
 }
 
-static int __devinit snd_serial_probe(struct platform_device *devptr)
+static int snd_serial_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
 	struct snd_uart16550 *uart;
diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index edcc0b1..ab3ec53 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -83,7 +83,7 @@ struct snd_card_virmidi {
 static struct platform_device *devices[SNDRV_CARDS];
 
 
-static int __devinit snd_virmidi_probe(struct platform_device *devptr)
+static int snd_virmidi_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
 	struct snd_card_virmidi *vmidi;
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 040acff..3ac0b9ed 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -663,7 +663,7 @@ static void fwspk_card_free(struct snd_card *card)
 	mutex_destroy(&fwspk->mutex);
 }
 
-static const struct device_info *__devinit fwspk_detect(struct fw_device *dev)
+static const struct device_info *fwspk_detect(struct fw_device *dev)
 {
 	static const struct device_info griffin_firewave = {
 		.driver_name = "FireWave",
@@ -699,7 +699,7 @@ static const struct device_info *__devinit fwspk_detect(struct fw_device *dev)
 	return NULL;
 }
 
-static int __devinit fwspk_probe(struct device *unit_dev)
+static int fwspk_probe(struct device *unit_dev)
 {
 	struct fw_unit *unit = fw_unit(unit_dev);
 	struct fw_device *fw_dev = fw_parent_device(unit);
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index e8c54d8..2de24dd 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -94,7 +94,7 @@ MODULE_DEVICE_TABLE(pnp_card, snd_ad1816a_pnpids);
 #define	DRIVER_NAME	"snd-card-ad1816a"
 
 
-static int __devinit snd_card_ad1816a_pnp(int dev, struct pnp_card_link *card,
+static int snd_card_ad1816a_pnp(int dev, struct pnp_card_link *card,
 					  const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
@@ -135,7 +135,7 @@ static int __devinit snd_card_ad1816a_pnp(int dev, struct pnp_card_link *card,
 	return 0;
 }
 
-static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
+static int snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
 					    const struct pnp_card_device_id *pid)
 {
 	int error;
@@ -219,7 +219,7 @@ static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard
 
 static unsigned int __devinitdata ad1816a_devices;
 
-static int __devinit snd_ad1816a_pnp_detect(struct pnp_card_link *card,
+static int snd_ad1816a_pnp_detect(struct pnp_card_link *card,
 					    const struct pnp_card_device_id *id)
 {
 	static int dev;
diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index db64df6..2d61df1 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -537,7 +537,7 @@ void snd_ad1816a_resume(struct snd_ad1816a *chip)
 }
 #endif
 
-static int __devinit snd_ad1816a_probe(struct snd_ad1816a *chip)
+static int snd_ad1816a_probe(struct snd_ad1816a *chip)
 {
 	unsigned long flags;
 
@@ -583,7 +583,7 @@ static int snd_ad1816a_dev_free(struct snd_device *device)
 	return snd_ad1816a_free(chip);
 }
 
-static const char __devinit *snd_ad1816a_chip_id(struct snd_ad1816a *chip)
+static const char *snd_ad1816a_chip_id(struct snd_ad1816a *chip)
 {
 	switch (chip->hardware) {
 	case AD1816A_HW_AD1816A: return "AD1816A";
@@ -596,7 +596,7 @@ static const char __devinit *snd_ad1816a_chip_id(struct snd_ad1816a *chip)
 	}
 }
 
-int __devinit snd_ad1816a_create(struct snd_card *card,
+int snd_ad1816a_create(struct snd_card *card,
 				 unsigned long port, int irq, int dma1, int dma2,
 				 struct snd_ad1816a *chip)
 {
@@ -675,7 +675,7 @@ static struct snd_pcm_ops snd_ad1816a_capture_ops = {
 	.pointer =	snd_ad1816a_capture_pointer,
 };
 
-int __devinit snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_pcm **rpcm)
+int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_pcm **rpcm)
 {
 	int error;
 	struct snd_pcm *pcm;
@@ -702,7 +702,7 @@ int __devinit snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_p
 	return 0;
 }
 
-int __devinit snd_ad1816a_timer(struct snd_ad1816a *chip, int device, struct snd_timer **rtimer)
+int snd_ad1816a_timer(struct snd_ad1816a *chip, int device, struct snd_timer **rtimer)
 {
 	struct snd_timer *timer;
 	struct snd_timer_id tid;
@@ -969,7 +969,7 @@ AD1816A_SINGLE("3D Control - Switch", AD1816A_3D_PHAT_CTRL, 15, 1, 1),
 AD1816A_SINGLE("3D Control - Level", AD1816A_3D_PHAT_CTRL, 0, 15, 0),
 };
                                         
-int __devinit snd_ad1816a_mixer(struct snd_ad1816a *chip)
+int snd_ad1816a_mixer(struct snd_ad1816a *chip)
 {
 	struct snd_card *card;
 	unsigned int idx;
diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index 8e0a9b7..3cef9ec 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(dma1, "DMA1 # for " CRD_NAME " driver.");
 module_param_array(thinkpad, bool, NULL, 0444);
 MODULE_PARM_DESC(thinkpad, "Enable only for the onboard CS4248 of IBM Thinkpad 360/750/755 series.");
 
-static int __devinit snd_ad1848_match(struct device *dev, unsigned int n)
+static int snd_ad1848_match(struct device *dev, unsigned int n)
 {
 	if (!enable[n])
 		return 0;
@@ -84,7 +84,7 @@ static int __devinit snd_ad1848_match(struct device *dev, unsigned int n)
 	return 1;
 }
 
-static int __devinit snd_ad1848_probe(struct device *dev, unsigned int n)
+static int snd_ad1848_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_wss *chip;
diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index 87add77..6a1c666 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -30,7 +30,7 @@ MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 
-static int __devinit snd_adlib_match(struct device *dev, unsigned int n)
+static int snd_adlib_match(struct device *dev, unsigned int n)
 {
 	if (!enable[n])
 		return 0;
@@ -47,7 +47,7 @@ static void snd_adlib_free(struct snd_card *card)
 	release_and_free_resource(card->private_data);
 }
 
-static int __devinit snd_adlib_probe(struct device *dev, unsigned int n)
+static int snd_adlib_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index 60c96a1..538f866 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -117,7 +117,7 @@ static struct pnp_card_device_id snd_als100_pnpids[] = {
 
 MODULE_DEVICE_TABLE(pnp_card, snd_als100_pnpids);
 
-static int __devinit snd_card_als100_pnp(int dev, struct snd_card_als100 *acard,
+static int snd_card_als100_pnp(int dev, struct snd_card_als100 *acard,
 					 struct pnp_card_link *card,
 					 const struct pnp_card_device_id *id)
 {
@@ -183,7 +183,7 @@ static int __devinit snd_card_als100_pnp(int dev, struct snd_card_als100 *acard,
 	return 0;
 }
 
-static int __devinit snd_card_als100_probe(int dev,
+static int snd_card_als100_probe(int dev,
 					struct pnp_card_link *pcard,
 					const struct pnp_card_device_id *pid)
 {
@@ -288,7 +288,7 @@ static int __devinit snd_card_als100_probe(int dev,
 
 static unsigned int __devinitdata als100_devices;
 
-static int __devinit snd_als100_pnp_detect(struct pnp_card_link *card,
+static int snd_als100_pnp_detect(struct pnp_card_link *card,
 					   const struct pnp_card_device_id *id)
 {
 	static int dev;
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index 219b611..da5ed43 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -99,7 +99,7 @@ MODULE_DEVICE_TABLE(pnp_card, snd_azt2320_pnpids);
 
 #define	DRIVER_NAME	"snd-card-azt2320"
 
-static int __devinit snd_card_azt2320_pnp(int dev, struct snd_card_azt2320 *acard,
+static int snd_card_azt2320_pnp(int dev, struct snd_card_azt2320 *acard,
 					  struct pnp_card_link *card,
 					  const struct pnp_card_device_id *id)
 {
@@ -147,7 +147,7 @@ static int __devinit snd_card_azt2320_pnp(int dev, struct snd_card_azt2320 *acar
 }
 
 /* same of snd_sbdsp_command by Jaroslav Kysela */
-static int __devinit snd_card_azt2320_command(unsigned long port, unsigned char val)
+static int snd_card_azt2320_command(unsigned long port, unsigned char val)
 {
 	int i;
 	unsigned long limit;
@@ -161,7 +161,7 @@ static int __devinit snd_card_azt2320_command(unsigned long port, unsigned char
 	return -EBUSY;
 }
 
-static int __devinit snd_card_azt2320_enable_wss(unsigned long port)
+static int snd_card_azt2320_enable_wss(unsigned long port)
 {
 	int error;
 
@@ -174,7 +174,7 @@ static int __devinit snd_card_azt2320_enable_wss(unsigned long port)
 	return 0;
 }
 
-static int __devinit snd_card_azt2320_probe(int dev,
+static int snd_card_azt2320_probe(int dev,
 					    struct pnp_card_link *pcard,
 					    const struct pnp_card_device_id *pid)
 {
@@ -266,7 +266,7 @@ static int __devinit snd_card_azt2320_probe(int dev,
 
 static unsigned int __devinitdata azt2320_devices;
 
-static int __devinit snd_azt2320_pnp_detect(struct pnp_card_link *card,
+static int snd_azt2320_pnp_detect(struct pnp_card_link *card,
 					    const struct pnp_card_device_id *id)
 {
 	static int dev;
diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index 55fabcf..6dfead9 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -140,7 +140,7 @@ static void snd_cmi8328_cfg_restore(u16 port, u8 cfg[])
 	snd_cmi8328_cfg_write(port, CFG3, cfg[2]);
 }
 
-static int __devinit snd_cmi8328_mixer(struct snd_wss *chip)
+static int snd_cmi8328_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card;
 	struct snd_ctl_elem_id id1, id2;
@@ -212,7 +212,7 @@ int array_find_l(long array[], long item)
 	return -1;
 }
 
-static int __devinit snd_cmi8328_probe(struct device *pdev, unsigned int ndev)
+static int snd_cmi8328_probe(struct device *pdev, unsigned int ndev)
 {
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index ee534e1..4c6e4eb 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -281,7 +281,7 @@ static unsigned char cmi8330_sb_init_values[][2] __devinitdata = {
 };
 
 
-static int __devinit cmi8330_add_sb_mixers(struct snd_sb *chip)
+static int cmi8330_add_sb_mixers(struct snd_sb *chip)
 {
 	int idx, err;
 	unsigned long flags;
@@ -306,7 +306,7 @@ static int __devinit cmi8330_add_sb_mixers(struct snd_sb *chip)
 }
 #endif
 
-static int __devinit snd_cmi8330_mixer(struct snd_card *card, struct snd_cmi8330 *acard)
+static int snd_cmi8330_mixer(struct snd_card *card, struct snd_cmi8330 *acard)
 {
 	unsigned int idx;
 	int err;
@@ -329,7 +329,7 @@ static int __devinit snd_cmi8330_mixer(struct snd_card *card, struct snd_cmi8330
 }
 
 #ifdef CONFIG_PNP
-static int __devinit snd_cmi8330_pnp(int dev, struct snd_cmi8330 *acard,
+static int snd_cmi8330_pnp(int dev, struct snd_cmi8330 *acard,
 				     struct pnp_card_link *card,
 				     const struct pnp_card_device_id *id)
 {
@@ -437,7 +437,7 @@ static int snd_cmi8330_capture_open(struct snd_pcm_substream *substream)
 	return chip->streams[SNDRV_PCM_STREAM_CAPTURE].open(substream);
 }
 
-static int __devinit snd_cmi8330_pcm(struct snd_card *card, struct snd_cmi8330 *chip)
+static int snd_cmi8330_pcm(struct snd_card *card, struct snd_cmi8330 *chip)
 {
 	struct snd_pcm *pcm;
 	const struct snd_pcm_ops *ops;
@@ -532,7 +532,7 @@ static int snd_cmi8330_card_new(int dev, struct snd_card **cardp)
 	return 0;
 }
 
-static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
+static int snd_cmi8330_probe(struct snd_card *card, int dev)
 {
 	struct snd_cmi8330 *acard;
 	int i, err;
@@ -613,7 +613,7 @@ static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
 	return snd_card_register(card);
 }
 
-static int __devinit snd_cmi8330_isa_match(struct device *pdev,
+static int snd_cmi8330_isa_match(struct device *pdev,
 					   unsigned int dev)
 {
 	if (!enable[dev] || is_isapnp_selected(dev))
@@ -629,7 +629,7 @@ static int __devinit snd_cmi8330_isa_match(struct device *pdev,
 	return 1;
 }
 
-static int __devinit snd_cmi8330_isa_probe(struct device *pdev,
+static int snd_cmi8330_isa_probe(struct device *pdev,
 					   unsigned int dev)
 {
 	struct snd_card *card;
@@ -685,7 +685,7 @@ static struct isa_driver snd_cmi8330_driver = {
 
 
 #ifdef CONFIG_PNP
-static int __devinit snd_cmi8330_pnp_detect(struct pnp_card_link *pcard,
+static int snd_cmi8330_pnp_detect(struct pnp_card_link *pcard,
 					    const struct pnp_card_device_id *pid)
 {
 	static int dev;
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index 0c67c37..ece5d8f 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -68,7 +68,7 @@ MODULE_PARM_DESC(dma1, "DMA1 # for " CRD_NAME " driver.");
 module_param_array(dma2, int, NULL, 0444);
 MODULE_PARM_DESC(dma2, "DMA2 # for " CRD_NAME " driver.");
 
-static int __devinit snd_cs4231_match(struct device *dev, unsigned int n)
+static int snd_cs4231_match(struct device *dev, unsigned int n)
 {
 	if (!enable[n])
 		return 0;
@@ -88,7 +88,7 @@ static int __devinit snd_cs4231_match(struct device *dev, unsigned int n)
 	return 1;
 }
 
-static int __devinit snd_cs4231_probe(struct device *dev, unsigned int n)
+static int snd_cs4231_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_wss *chip;
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index f5fba07..752ccba 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -251,7 +251,7 @@ static struct pnp_card_device_id snd_cs423x_pnpids[] = {
 MODULE_DEVICE_TABLE(pnp_card, snd_cs423x_pnpids);
 
 /* WSS initialization */
-static int __devinit snd_cs423x_pnp_init_wss(int dev, struct pnp_dev *pdev)
+static int snd_cs423x_pnp_init_wss(int dev, struct pnp_dev *pdev)
 {
 	if (pnp_activate_dev(pdev) < 0) {
 		printk(KERN_ERR IDENT " WSS PnP configure failed for WSS (out of resources?)\n");
@@ -272,7 +272,7 @@ static int __devinit snd_cs423x_pnp_init_wss(int dev, struct pnp_dev *pdev)
 }
 
 /* CTRL initialization */
-static int __devinit snd_cs423x_pnp_init_ctrl(int dev, struct pnp_dev *pdev)
+static int snd_cs423x_pnp_init_ctrl(int dev, struct pnp_dev *pdev)
 {
 	if (pnp_activate_dev(pdev) < 0) {
 		printk(KERN_ERR IDENT " CTRL PnP configure failed for WSS (out of resources?)\n");
@@ -284,7 +284,7 @@ static int __devinit snd_cs423x_pnp_init_ctrl(int dev, struct pnp_dev *pdev)
 }
 
 /* MPU initialization */
-static int __devinit snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
+static int snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
 {
 	if (pnp_activate_dev(pdev) < 0) {
 		printk(KERN_ERR IDENT " MPU401 PnP configure failed for WSS (out of resources?)\n");
@@ -303,7 +303,7 @@ static int __devinit snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
 	return 0;
 }
 
-static int __devinit snd_card_cs423x_pnp(int dev, struct snd_card_cs4236 *acard,
+static int snd_card_cs423x_pnp(int dev, struct snd_card_cs4236 *acard,
 					 struct pnp_dev *pdev,
 					 struct pnp_dev *cdev)
 {
@@ -317,7 +317,7 @@ static int __devinit snd_card_cs423x_pnp(int dev, struct snd_card_cs4236 *acard,
 	return 0;
 }
 
-static int __devinit snd_card_cs423x_pnpc(int dev, struct snd_card_cs4236 *acard,
+static int snd_card_cs423x_pnpc(int dev, struct snd_card_cs4236 *acard,
 					  struct pnp_card_link *card,
 					  const struct pnp_card_device_id *id)
 {
@@ -378,7 +378,7 @@ static int snd_cs423x_card_new(int dev, struct snd_card **cardp)
 	return 0;
 }
 
-static int __devinit snd_cs423x_probe(struct snd_card *card, int dev)
+static int snd_cs423x_probe(struct snd_card *card, int dev)
 {
 	struct snd_card_cs4236 *acard;
 	struct snd_pcm *pcm;
@@ -456,7 +456,7 @@ static int __devinit snd_cs423x_probe(struct snd_card *card, int dev)
 	return snd_card_register(card);
 }
 
-static int __devinit snd_cs423x_isa_match(struct device *pdev,
+static int snd_cs423x_isa_match(struct device *pdev,
 					  unsigned int dev)
 {
 	if (!enable[dev] || is_isapnp_selected(dev))
@@ -481,7 +481,7 @@ static int __devinit snd_cs423x_isa_match(struct device *pdev,
 	return 1;
 }
 
-static int __devinit snd_cs423x_isa_probe(struct device *pdev,
+static int snd_cs423x_isa_probe(struct device *pdev,
 					  unsigned int dev)
 {
 	struct snd_card *card;
@@ -552,7 +552,7 @@ static struct isa_driver cs423x_isa_driver = {
 
 
 #ifdef CONFIG_PNP
-static int __devinit snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
+static int snd_cs423x_pnpbios_detect(struct pnp_dev *pdev,
 					       const struct pnp_device_id *id)
 {
 	static int dev;
@@ -626,7 +626,7 @@ static struct pnp_driver cs423x_pnp_driver = {
 #endif
 };
 
-static int __devinit snd_cs423x_pnpc_detect(struct pnp_card_link *pcard,
+static int snd_cs423x_pnpc_detect(struct pnp_card_link *pcard,
 					    const struct pnp_card_device_id *pid)
 {
 	static int dev;
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index ffad710..f62803b 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -90,12 +90,12 @@ MODULE_PARM_DESC(dma8, "8-bit DMA # for " CRD_NAME " driver.");
 #define is_isapnp_selected(dev)		0
 #endif
 
-static int __devinit snd_es1688_match(struct device *dev, unsigned int n)
+static int snd_es1688_match(struct device *dev, unsigned int n)
 {
 	return enable[n] && !is_isapnp_selected(n);
 }
 
-static int __devinit snd_es1688_legacy_create(struct snd_card *card,
+static int snd_es1688_legacy_create(struct snd_card *card,
 					struct device *dev, unsigned int n)
 {
 	struct snd_es1688 *chip = card->private_data;
@@ -134,7 +134,7 @@ static int __devinit snd_es1688_legacy_create(struct snd_card *card,
 	return error;
 }
 
-static int __devinit snd_es1688_probe(struct snd_card *card, unsigned int n)
+static int snd_es1688_probe(struct snd_card *card, unsigned int n)
 {
 	struct snd_es1688 *chip = card->private_data;
 	struct snd_opl3 *opl3;
@@ -182,7 +182,7 @@ static int __devinit snd_es1688_probe(struct snd_card *card, unsigned int n)
 	return snd_card_register(card);
 }
 
-static int __devinit snd_es1688_isa_probe(struct device *dev, unsigned int n)
+static int snd_es1688_isa_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	int error;
@@ -233,7 +233,7 @@ static struct isa_driver snd_es1688_driver = {
 static int snd_es968_pnp_is_probed;
 
 #ifdef CONFIG_PNP
-static int __devinit snd_card_es968_pnp(struct snd_card *card, unsigned int n,
+static int snd_card_es968_pnp(struct snd_card *card, unsigned int n,
 					struct pnp_card_link *pcard,
 					const struct pnp_card_device_id *pid)
 {
@@ -258,7 +258,7 @@ static int __devinit snd_card_es968_pnp(struct snd_card *card, unsigned int n,
 				 mpu_irq[n], dma8[n], ES1688_HW_AUTO);
 }
 
-static int __devinit snd_es968_pnp_detect(struct pnp_card_link *pcard,
+static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 					  const struct pnp_card_device_id *pid)
 {
 	struct snd_card *card;
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index b491185..8fe5dc1 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -348,7 +348,7 @@ static inline int snd_es18xx_mixer_writable(struct snd_es18xx *chip, unsigned ch
 }
 
 
-static int __devinit snd_es18xx_reset(struct snd_es18xx *chip)
+static int snd_es18xx_reset(struct snd_es18xx *chip)
 {
 	int i;
         outb(0x03, chip->port + 0x06);
@@ -1363,7 +1363,7 @@ static struct snd_kcontrol_new snd_es18xx_hw_volume_controls[] = {
 ES18XX_SINGLE("Hardware Master Volume Split", 0, 0x64, 7, 1, 0),
 };
 
-static int __devinit snd_es18xx_config_read(struct snd_es18xx *chip, unsigned char reg)
+static int snd_es18xx_config_read(struct snd_es18xx *chip, unsigned char reg)
 {
 	int data;
 
@@ -1372,7 +1372,7 @@ static int __devinit snd_es18xx_config_read(struct snd_es18xx *chip, unsigned ch
 	return data;
 }
 
-static void __devinit snd_es18xx_config_write(struct snd_es18xx *chip, 
+static void snd_es18xx_config_write(struct snd_es18xx *chip,
 					      unsigned char reg, unsigned char data)
 {
 	/* No need for spinlocks, this function is used only in
@@ -1384,7 +1384,7 @@ static void __devinit snd_es18xx_config_write(struct snd_es18xx *chip,
 #endif
 }
 
-static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip,
+static int snd_es18xx_initialize(struct snd_es18xx *chip,
 					   unsigned long mpu_port,
 					   unsigned long fm_port)
 {
@@ -1549,7 +1549,7 @@ static int __devinit snd_es18xx_initialize(struct snd_es18xx *chip,
         return 0;
 }
 
-static int __devinit snd_es18xx_identify(struct snd_es18xx *chip)
+static int snd_es18xx_identify(struct snd_es18xx *chip)
 {
 	int hi,lo;
 
@@ -1618,7 +1618,7 @@ static int __devinit snd_es18xx_identify(struct snd_es18xx *chip)
 	return 0;
 }
 
-static int __devinit snd_es18xx_probe(struct snd_es18xx *chip,
+static int snd_es18xx_probe(struct snd_es18xx *chip,
 					unsigned long mpu_port,
 					unsigned long fm_port)
 {
@@ -1680,7 +1680,7 @@ static struct snd_pcm_ops snd_es18xx_capture_ops = {
 	.pointer =	snd_es18xx_capture_pointer,
 };
 
-static int __devinit snd_es18xx_pcm(struct snd_card *card, int device,
+static int snd_es18xx_pcm(struct snd_card *card, int device,
 				    struct snd_pcm **rpcm)
 {
 	struct snd_es18xx *chip = card->private_data;
@@ -1777,7 +1777,7 @@ static int snd_es18xx_dev_free(struct snd_device *device)
 	return snd_es18xx_free(device->card);
 }
 
-static int __devinit snd_es18xx_new_device(struct snd_card *card,
+static int snd_es18xx_new_device(struct snd_card *card,
 					   unsigned long port,
 					   unsigned long mpu_port,
 					   unsigned long fm_port,
@@ -1839,7 +1839,7 @@ static int __devinit snd_es18xx_new_device(struct snd_card *card,
         return 0;
 }
 
-static int __devinit snd_es18xx_mixer(struct snd_card *card)
+static int snd_es18xx_mixer(struct snd_card *card)
 {
 	struct snd_es18xx *chip = card->private_data;
 	int err;
@@ -2016,7 +2016,7 @@ static struct pnp_device_id snd_audiodrive_pnpbiosids[] = {
 MODULE_DEVICE_TABLE(pnp, snd_audiodrive_pnpbiosids);
 
 /* PnP main device initialization */
-static int __devinit snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev)
+static int snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev)
 {
 	if (pnp_activate_dev(pdev) < 0) {
 		snd_printk(KERN_ERR PFX "PnP configure failure (out of resources?)\n");
@@ -2043,7 +2043,7 @@ static int __devinit snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev)
 	return 0;
 }
 
-static int __devinit snd_audiodrive_pnp(int dev, struct snd_es18xx *chip,
+static int snd_audiodrive_pnp(int dev, struct snd_es18xx *chip,
 					struct pnp_dev *pdev)
 {
 	chip->dev = pdev;
@@ -2073,7 +2073,7 @@ static struct pnp_card_device_id snd_audiodrive_pnpids[] = {
 
 MODULE_DEVICE_TABLE(pnp_card, snd_audiodrive_pnpids);
 
-static int __devinit snd_audiodrive_pnpc(int dev, struct snd_es18xx *chip,
+static int snd_audiodrive_pnpc(int dev, struct snd_es18xx *chip,
 					struct pnp_card_link *card,
 					const struct pnp_card_device_id *id)
 {
@@ -2111,7 +2111,7 @@ static int snd_es18xx_card_new(int dev, struct snd_card **cardp)
 			       sizeof(struct snd_es18xx), cardp);
 }
 
-static int __devinit snd_audiodrive_probe(struct snd_card *card, int dev)
+static int snd_audiodrive_probe(struct snd_card *card, int dev)
 {
 	struct snd_es18xx *chip = card->private_data;
 	struct snd_opl3 *opl3;
@@ -2169,12 +2169,12 @@ static int __devinit snd_audiodrive_probe(struct snd_card *card, int dev)
 	return snd_card_register(card);
 }
 
-static int __devinit snd_es18xx_isa_match(struct device *pdev, unsigned int dev)
+static int snd_es18xx_isa_match(struct device *pdev, unsigned int dev)
 {
 	return enable[dev] && !is_isapnp_selected(dev);
 }
 
-static int __devinit snd_es18xx_isa_probe1(int dev, struct device *devptr)
+static int snd_es18xx_isa_probe1(int dev, struct device *devptr)
 {
 	struct snd_card *card;
 	int err;
@@ -2191,7 +2191,7 @@ static int __devinit snd_es18xx_isa_probe1(int dev, struct device *devptr)
 	return 0;
 }
 
-static int __devinit snd_es18xx_isa_probe(struct device *pdev, unsigned int dev)
+static int snd_es18xx_isa_probe(struct device *pdev, unsigned int dev)
 {
 	int err;
 	static int possible_irqs[] = {5, 9, 10, 7, 11, 12, -1};
@@ -2269,7 +2269,7 @@ static struct isa_driver snd_es18xx_isa_driver = {
 
 
 #ifdef CONFIG_PNP
-static int __devinit snd_audiodrive_pnp_detect(struct pnp_dev *pdev,
+static int snd_audiodrive_pnp_detect(struct pnp_dev *pdev,
 					    const struct pnp_device_id *id)
 {
 	static int dev;
@@ -2330,7 +2330,7 @@ static struct pnp_driver es18xx_pnp_driver = {
 #endif
 };
 
-static int __devinit snd_audiodrive_pnpc_detect(struct pnp_card_link *pcard,
+static int snd_audiodrive_pnpc_detect(struct pnp_card_link *pcard,
 					       const struct pnp_card_device_id *pid)
 {
 	static int dev;
diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index 1858535..6955e78 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -84,7 +84,7 @@ MODULE_PARM_DESC(dma2, "Capture DMA # for " CRD_NAME " driver.");
 
 #define DSP_COMMAND_GET_VERSION	0xe1
 
-static int __devinit dsp_get_byte(void __iomem *port, u8 *val)
+static int dsp_get_byte(void __iomem *port, u8 *val)
 {
 	int loops = 1000;
 
@@ -97,7 +97,7 @@ static int __devinit dsp_get_byte(void __iomem *port, u8 *val)
 	return 0;
 }
 
-static int __devinit dsp_reset(void __iomem *port)
+static int dsp_reset(void __iomem *port)
 {
 	u8 val;
 
@@ -111,7 +111,7 @@ static int __devinit dsp_reset(void __iomem *port)
 	return 0;
 }
 
-static int __devinit dsp_command(void __iomem *port, u8 cmd)
+static int dsp_command(void __iomem *port, u8 cmd)
 {
 	int loops = 1000;
 
@@ -124,7 +124,7 @@ static int __devinit dsp_command(void __iomem *port, u8 cmd)
 	return 0;
 }
 
-static int __devinit dsp_get_version(void __iomem *port, u8 *major, u8 *minor)
+static int dsp_get_version(void __iomem *port, u8 *major, u8 *minor)
 {
 	int err;
 
@@ -161,7 +161,7 @@ static int __devinit dsp_get_version(void __iomem *port, u8 *major, u8 *minor)
 
 #define WSS_SIGNATURE		4
 
-static int __devinit wss_detect(void __iomem *wss_port)
+static int wss_detect(void __iomem *wss_port)
 {
 	if ((ioread8(wss_port + WSS_PORT_SIGNATURE) & 0x3f) != WSS_SIGNATURE)
 		return -ENODEV;
@@ -204,7 +204,7 @@ struct snd_galaxy {
 static u32 config[SNDRV_CARDS];
 static u8 wss_config[SNDRV_CARDS];
 
-static int __devinit snd_galaxy_match(struct device *dev, unsigned int n)
+static int snd_galaxy_match(struct device *dev, unsigned int n)
 {
 	if (!enable[n])
 		return 0;
@@ -379,7 +379,7 @@ fm:
 	return 1;
 }
 
-static int __devinit galaxy_init(struct snd_galaxy *galaxy, u8 *type)
+static int galaxy_init(struct snd_galaxy *galaxy, u8 *type)
 {
 	u8 major;
 	u8 minor;
@@ -411,7 +411,7 @@ static int __devinit galaxy_init(struct snd_galaxy *galaxy, u8 *type)
 	return 0;
 }
 
-static int __devinit galaxy_set_mode(struct snd_galaxy *galaxy, u8 mode)
+static int galaxy_set_mode(struct snd_galaxy *galaxy, u8 mode)
 {
 	int err;
 
@@ -449,7 +449,7 @@ static void galaxy_set_config(struct snd_galaxy *galaxy, u32 config)
 	msleep(10);
 }
 
-static void __devinit galaxy_config(struct snd_galaxy *galaxy, u32 config)
+static void galaxy_config(struct snd_galaxy *galaxy, u32 config)
 {
 	int i;
 
@@ -461,7 +461,7 @@ static void __devinit galaxy_config(struct snd_galaxy *galaxy, u32 config)
 	galaxy_set_config(galaxy, config);
 }
 
-static int __devinit galaxy_wss_config(struct snd_galaxy *galaxy, u8 wss_config)
+static int galaxy_wss_config(struct snd_galaxy *galaxy, u8 wss_config)
 {
 	int err;
 
@@ -498,7 +498,7 @@ static void snd_galaxy_free(struct snd_card *card)
 	}
 }
 
-static int __devinit snd_galaxy_probe(struct device *dev, unsigned int n)
+static int snd_galaxy_probe(struct device *dev, unsigned int n)
 {
 	struct snd_galaxy *galaxy;
 	struct snd_wss *chip;
diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index ec4bd7e..4a4c856 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -73,12 +73,12 @@ MODULE_PARM_DESC(channels, "GF1 channels for " CRD_NAME " driver.");
 module_param_array(pcm_channels, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for " CRD_NAME " driver.");
 
-static int __devinit snd_gusclassic_match(struct device *dev, unsigned int n)
+static int snd_gusclassic_match(struct device *dev, unsigned int n)
 {
 	return enable[n];
 }
 
-static int __devinit snd_gusclassic_create(struct snd_card *card,
+static int snd_gusclassic_create(struct snd_card *card,
 		struct device *dev, unsigned int n, struct snd_gus_card **rgus)
 {
 	static long possible_ports[] = {0x220, 0x230, 0x240, 0x250, 0x260};
@@ -123,7 +123,7 @@ static int __devinit snd_gusclassic_create(struct snd_card *card,
 	return error;
 }
 
-static int __devinit snd_gusclassic_detect(struct snd_gus_card *gus)
+static int snd_gusclassic_detect(struct snd_gus_card *gus)
 {
 	unsigned char d;
 
@@ -142,7 +142,7 @@ static int __devinit snd_gusclassic_detect(struct snd_gus_card *gus)
 	return 0;
 }
 
-static int __devinit snd_gusclassic_probe(struct device *dev, unsigned int n)
+static int snd_gusclassic_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_gus_card *gus;
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 3d76215..e8ee416 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -89,12 +89,12 @@ MODULE_PARM_DESC(channels, "GF1 channels for " CRD_NAME " driver.");
 module_param_array(pcm_channels, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for " CRD_NAME " driver.");
 
-static int __devinit snd_gusextreme_match(struct device *dev, unsigned int n)
+static int snd_gusextreme_match(struct device *dev, unsigned int n)
 {
 	return enable[n];
 }
 
-static int __devinit snd_gusextreme_es1688_create(struct snd_card *card,
+static int snd_gusextreme_es1688_create(struct snd_card *card,
 		struct snd_es1688 *chip, struct device *dev, unsigned int n)
 {
 	static long possible_ports[] = {0x220, 0x240, 0x260};
@@ -132,7 +132,7 @@ static int __devinit snd_gusextreme_es1688_create(struct snd_card *card,
 	return error;
 }
 
-static int __devinit snd_gusextreme_gus_card_create(struct snd_card *card,
+static int snd_gusextreme_gus_card_create(struct snd_card *card,
 		struct device *dev, unsigned int n, struct snd_gus_card **rgus)
 {
 	static int possible_irqs[] = {11, 12, 15, 9, 5, 7, 3, -1};
@@ -156,7 +156,7 @@ static int __devinit snd_gusextreme_gus_card_create(struct snd_card *card,
 			0, channels[n], pcm_channels[n], 0, rgus);
 }
 
-static int __devinit snd_gusextreme_detect(struct snd_gus_card *gus,
+static int snd_gusextreme_detect(struct snd_gus_card *gus,
 	struct snd_es1688 *es1688)
 {
 	unsigned long flags;
@@ -206,7 +206,7 @@ static int __devinit snd_gusextreme_detect(struct snd_gus_card *gus,
 	return 0;
 }
 
-static int __devinit snd_gusextreme_mixer(struct snd_card *card)
+static int snd_gusextreme_mixer(struct snd_card *card)
 {
 	struct snd_ctl_elem_id id1, id2;
 	int error;
@@ -232,7 +232,7 @@ static int __devinit snd_gusextreme_mixer(struct snd_card *card)
 	return 0;
 }
 
-static int __devinit snd_gusextreme_probe(struct device *dev, unsigned int n)
+static int snd_gusextreme_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_gus_card *gus;
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index fefd5ae..6e297c8 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -82,7 +82,7 @@ struct snd_gusmax {
 
 #define PFX	"gusmax: "
 
-static int __devinit snd_gusmax_detect(struct snd_gus_card * gus)
+static int snd_gusmax_detect(struct snd_gus_card * gus)
 {
 	unsigned char d;
 
@@ -124,7 +124,7 @@ static irqreturn_t snd_gusmax_interrupt(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static void __devinit snd_gusmax_init(int dev, struct snd_card *card,
+static void snd_gusmax_init(int dev, struct snd_card *card,
 				      struct snd_gus_card * gus)
 {
 	gus->equal_irq = 1;
@@ -140,7 +140,7 @@ static void __devinit snd_gusmax_init(int dev, struct snd_card *card,
 	outb(gus->max_cntrl_val, GUSP(gus, MAXCNTRLPORT));
 }
 
-static int __devinit snd_gusmax_mixer(struct snd_wss *chip)
+static int snd_gusmax_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
@@ -199,12 +199,12 @@ static void snd_gusmax_free(struct snd_card *card)
 		free_irq(maxcard->irq, (void *)maxcard);
 }
 
-static int __devinit snd_gusmax_match(struct device *pdev, unsigned int dev)
+static int snd_gusmax_match(struct device *pdev, unsigned int dev)
 {
 	return enable[dev];
 }
 
-static int __devinit snd_gusmax_probe(struct device *pdev, unsigned int dev)
+static int snd_gusmax_probe(struct device *pdev, unsigned int dev)
 {
 	static int possible_irqs[] = {5, 11, 12, 9, 7, 15, 3, -1};
 	static int possible_dmas[] = {5, 6, 7, 1, 3, -1};
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index c61a74c..b5f436a 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -207,7 +207,7 @@ static struct snd_i2c_bit_ops snd_interwave_i2c_bit_ops = {
 	.getdata  = snd_interwave_i2c_getdataline,
 };
 
-static int __devinit snd_interwave_detect_stb(struct snd_interwave *iwcard,
+static int snd_interwave_detect_stb(struct snd_interwave *iwcard,
 					      struct snd_gus_card * gus, int dev,
 					      struct snd_i2c_bus **rbus)
 {
@@ -249,7 +249,7 @@ static int __devinit snd_interwave_detect_stb(struct snd_interwave *iwcard,
 }
 #endif
 
-static int __devinit snd_interwave_detect(struct snd_interwave *iwcard,
+static int snd_interwave_detect(struct snd_interwave *iwcard,
 				          struct snd_gus_card * gus,
 				          int dev
 #ifdef SNDRV_STB
@@ -318,7 +318,7 @@ static irqreturn_t snd_interwave_interrupt(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static void __devinit snd_interwave_reset(struct snd_gus_card * gus)
+static void snd_interwave_reset(struct snd_gus_card * gus)
 {
 	snd_gf1_write8(gus, SNDRV_GF1_GB_RESET, 0x00);
 	udelay(160);
@@ -326,7 +326,7 @@ static void __devinit snd_interwave_reset(struct snd_gus_card * gus)
 	udelay(160);
 }
 
-static void __devinit snd_interwave_bank_sizes(struct snd_gus_card * gus, int *sizes)
+static void snd_interwave_bank_sizes(struct snd_gus_card * gus, int *sizes)
 {
 	unsigned int idx;
 	unsigned int local;
@@ -377,7 +377,7 @@ struct rom_hdr {
 	/* 511 */ unsigned char csum;
 };
 
-static void __devinit snd_interwave_detect_memory(struct snd_gus_card * gus)
+static void snd_interwave_detect_memory(struct snd_gus_card * gus)
 {
 	static unsigned int lmc[13] =
 	{
@@ -475,7 +475,7 @@ static void __devinit snd_interwave_detect_memory(struct snd_gus_card * gus)
 		snd_interwave_reset(gus);
 }
 
-static void __devinit snd_interwave_init(int dev, struct snd_gus_card * gus)
+static void snd_interwave_init(int dev, struct snd_gus_card * gus)
 {
 	unsigned long flags;
 
@@ -508,7 +508,7 @@ WSS_DOUBLE("Mic Playback Volume", 0,
 		CS4231_LEFT_MIC_INPUT, CS4231_RIGHT_MIC_INPUT, 0, 0, 31, 1)
 };
 
-static int __devinit snd_interwave_mixer(struct snd_wss *chip)
+static int snd_interwave_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
@@ -558,7 +558,7 @@ static int __devinit snd_interwave_mixer(struct snd_wss *chip)
 
 #ifdef CONFIG_PNP
 
-static int __devinit snd_interwave_pnp(int dev, struct snd_interwave *iwcard,
+static int snd_interwave_pnp(int dev, struct snd_interwave *iwcard,
 				       struct pnp_card_link *card,
 				       const struct pnp_card_device_id *id)
 {
@@ -644,7 +644,7 @@ static int snd_interwave_card_new(int dev, struct snd_card **cardp)
 	return 0;
 }
 
-static int __devinit snd_interwave_probe(struct snd_card *card, int dev)
+static int snd_interwave_probe(struct snd_card *card, int dev)
 {
 	int xirq, xdma1, xdma2;
 	struct snd_interwave *iwcard = card->private_data;
@@ -775,7 +775,7 @@ static int __devinit snd_interwave_probe(struct snd_card *card, int dev)
 	return 0;
 }
 
-static int __devinit snd_interwave_isa_probe1(int dev, struct device *devptr)
+static int snd_interwave_isa_probe1(int dev, struct device *devptr)
 {
 	struct snd_card *card;
 	int err;
@@ -793,7 +793,7 @@ static int __devinit snd_interwave_isa_probe1(int dev, struct device *devptr)
 	return 0;
 }
 
-static int __devinit snd_interwave_isa_match(struct device *pdev,
+static int snd_interwave_isa_match(struct device *pdev,
 					     unsigned int dev)
 {
 	if (!enable[dev])
@@ -805,7 +805,7 @@ static int __devinit snd_interwave_isa_match(struct device *pdev,
 	return 1;
 }
 
-static int __devinit snd_interwave_isa_probe(struct device *pdev,
+static int snd_interwave_isa_probe(struct device *pdev,
 					     unsigned int dev)
 {
 	int err;
@@ -864,7 +864,7 @@ static struct isa_driver snd_interwave_driver = {
 };
 
 #ifdef CONFIG_PNP
-static int __devinit snd_interwave_pnp_detect(struct pnp_card_link *pcard,
+static int snd_interwave_pnp_detect(struct pnp_card_link *pcard,
 					      const struct pnp_card_device_id *pid)
 {
 	static int dev;
diff --git a/sound/isa/msnd/msnd.h b/sound/isa/msnd/msnd.h
index a168ba3..dbac3a4 100644
--- a/sound/isa/msnd/msnd.h
+++ b/sound/isa/msnd/msnd.h
@@ -303,6 +303,6 @@ int snd_msndmidi_new(struct snd_card *card, int device);
 void snd_msndmidi_input_read(void *mpu);
 
 void snd_msndmix_setup(struct snd_msnd *chip);
-int __devinit snd_msndmix_new(struct snd_card *card);
+int snd_msndmix_new(struct snd_card *card);
 int snd_msndmix_force_recsrc(struct snd_msnd *chip, int recsrc);
 #endif /* __MSND_H */
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 93cafbe..75f297e 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -78,7 +78,7 @@
 #  define LOGNAME			"snd_msnd_pinnacle"
 #endif
 
-static void __devinit set_default_audio_parameters(struct snd_msnd *chip)
+static void set_default_audio_parameters(struct snd_msnd *chip)
 {
 	chip->play_sample_size = DEFSAMPLESIZE;
 	chip->play_sample_rate = DEFSAMPLERATE;
@@ -213,7 +213,7 @@ static int snd_msnd_reset_dsp(long io, unsigned char *info)
 	return -EIO;
 }
 
-static int __devinit snd_msnd_probe(struct snd_card *card)
+static int snd_msnd_probe(struct snd_card *card)
 {
 	struct snd_msnd *chip = card->private_data;
 	unsigned char info;
@@ -497,7 +497,7 @@ static int snd_msnd_send_dsp_cmd_chk(struct snd_msnd *chip, u8 cmd)
 	return snd_msnd_send_dsp_cmd(chip, cmd);
 }
 
-static int __devinit snd_msnd_calibrate_adc(struct snd_msnd *chip, u16 srate)
+static int snd_msnd_calibrate_adc(struct snd_msnd *chip, u16 srate)
 {
 	snd_printdd("snd_msnd_calibrate_adc(%i)\n", srate);
 	writew(srate, chip->SMA + SMA_wCalFreqAtoD);
@@ -535,7 +535,7 @@ static void snd_msnd_mpu401_close(struct snd_mpu401 *mpu)
 static long mpu_io[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
 
-static int __devinit snd_msnd_attach(struct snd_card *card)
+static int snd_msnd_attach(struct snd_card *card)
 {
 	struct snd_msnd *chip = card->private_data;
 	int err;
@@ -649,7 +649,7 @@ static void __devexit snd_msnd_unload(struct snd_card *card)
 
 /* Pinnacle/Fiji Logical Device Configuration */
 
-static int __devinit snd_msnd_write_cfg(int cfg, int reg, int value)
+static int snd_msnd_write_cfg(int cfg, int reg, int value)
 {
 	outb(reg, cfg);
 	outb(value, cfg + 1);
@@ -660,7 +660,7 @@ static int __devinit snd_msnd_write_cfg(int cfg, int reg, int value)
 	return 0;
 }
 
-static int __devinit snd_msnd_write_cfg_io0(int cfg, int num, u16 io)
+static int snd_msnd_write_cfg_io0(int cfg, int num, u16 io)
 {
 	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 		return -EIO;
@@ -671,7 +671,7 @@ static int __devinit snd_msnd_write_cfg_io0(int cfg, int num, u16 io)
 	return 0;
 }
 
-static int __devinit snd_msnd_write_cfg_io1(int cfg, int num, u16 io)
+static int snd_msnd_write_cfg_io1(int cfg, int num, u16 io)
 {
 	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 		return -EIO;
@@ -682,7 +682,7 @@ static int __devinit snd_msnd_write_cfg_io1(int cfg, int num, u16 io)
 	return 0;
 }
 
-static int __devinit snd_msnd_write_cfg_irq(int cfg, int num, u16 irq)
+static int snd_msnd_write_cfg_irq(int cfg, int num, u16 irq)
 {
 	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 		return -EIO;
@@ -693,7 +693,7 @@ static int __devinit snd_msnd_write_cfg_irq(int cfg, int num, u16 irq)
 	return 0;
 }
 
-static int __devinit snd_msnd_write_cfg_mem(int cfg, int num, int mem)
+static int snd_msnd_write_cfg_mem(int cfg, int num, int mem)
 {
 	u16 wmem;
 
@@ -711,7 +711,7 @@ static int __devinit snd_msnd_write_cfg_mem(int cfg, int num, int mem)
 	return 0;
 }
 
-static int __devinit snd_msnd_activate_logical(int cfg, int num)
+static int snd_msnd_activate_logical(int cfg, int num)
 {
 	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 		return -EIO;
@@ -720,7 +720,7 @@ static int __devinit snd_msnd_activate_logical(int cfg, int num)
 	return 0;
 }
 
-static int __devinit snd_msnd_write_cfg_logical(int cfg, int num, u16 io0,
+static int snd_msnd_write_cfg_logical(int cfg, int num, u16 io0,
 						u16 io1, u16 irq, int mem)
 {
 	if (snd_msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
@@ -738,7 +738,7 @@ static int __devinit snd_msnd_write_cfg_logical(int cfg, int num, u16 io0,
 	return 0;
 }
 
-static int __devinit snd_msnd_pinnacle_cfg_reset(int cfg)
+static int snd_msnd_pinnacle_cfg_reset(int cfg)
 {
 	int i;
 
@@ -818,7 +818,7 @@ module_param_array(joystick_io, long, NULL, S_IRUGO);
 #endif
 
 
-static int __devinit snd_msnd_isa_match(struct device *pdev, unsigned int i)
+static int snd_msnd_isa_match(struct device *pdev, unsigned int i)
 {
 	if (io[i] == SNDRV_AUTO_PORT)
 		return 0;
@@ -888,7 +888,7 @@ static int __devinit snd_msnd_isa_match(struct device *pdev, unsigned int i)
 	return 1;
 }
 
-static int __devinit snd_msnd_isa_probe(struct device *pdev, unsigned int idx)
+static int snd_msnd_isa_probe(struct device *pdev, unsigned int idx)
 {
 	int err;
 	struct snd_card *card;
@@ -1081,7 +1081,7 @@ static struct isa_driver snd_msnd_driver = {
 };
 
 #ifdef CONFIG_PNP
-static int __devinit snd_msnd_pnp_detect(struct pnp_card_link *pcard,
+static int snd_msnd_pnp_detect(struct pnp_card_link *pcard,
 					 const struct pnp_card_device_id *pid)
 {
 	static int idx;
diff --git a/sound/isa/msnd/msnd_pinnacle_mixer.c b/sound/isa/msnd/msnd_pinnacle_mixer.c
index 1de59d4..031dc69 100644
--- a/sound/isa/msnd/msnd_pinnacle_mixer.c
+++ b/sound/isa/msnd/msnd_pinnacle_mixer.c
@@ -302,7 +302,7 @@ DUMMY_VOLUME("Monitor",	0, MSND_MIXER_IMIX),
 };
 
 
-int __devinit snd_msndmix_new(struct snd_card *card)
+int snd_msndmix_new(struct snd_card *card)
 {
 	struct snd_msnd *chip = card->private_data;
 	unsigned int idx;
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index 99855d5..9f71f956 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -221,7 +221,7 @@ static void snd_opl3sa2_write(struct snd_opl3sa2 *chip, unsigned char reg, unsig
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-static int __devinit snd_opl3sa2_detect(struct snd_card *card)
+static int snd_opl3sa2_detect(struct snd_card *card)
 {
 	struct snd_opl3sa2 *chip = card->private_data;
 	unsigned long port;
@@ -496,7 +496,7 @@ static void snd_opl3sa2_master_free(struct snd_kcontrol *kcontrol)
 	chip->master_volume = NULL;
 }
 
-static int __devinit snd_opl3sa2_mixer(struct snd_card *card)
+static int snd_opl3sa2_mixer(struct snd_card *card)
 {
 	struct snd_opl3sa2 *chip = card->private_data;
 	struct snd_ctl_elem_id id1, id2;
@@ -596,7 +596,7 @@ static int snd_opl3sa2_resume(struct snd_card *card)
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PNP
-static int __devinit snd_opl3sa2_pnp(int dev, struct snd_opl3sa2 *chip,
+static int snd_opl3sa2_pnp(int dev, struct snd_opl3sa2 *chip,
 				     struct pnp_dev *pdev)
 {
 	if (pnp_activate_dev(pdev) < 0) {
@@ -647,7 +647,7 @@ static int snd_opl3sa2_card_new(int dev, struct snd_card **cardp)
 	return 0;
 }
 
-static int __devinit snd_opl3sa2_probe(struct snd_card *card, int dev)
+static int snd_opl3sa2_probe(struct snd_card *card, int dev)
 {
 	int xirq, xdma1, xdma2;
 	struct snd_opl3sa2 *chip;
@@ -721,7 +721,7 @@ static int __devinit snd_opl3sa2_probe(struct snd_card *card, int dev)
 }
 
 #ifdef CONFIG_PNP
-static int __devinit snd_opl3sa2_pnp_detect(struct pnp_dev *pdev,
+static int snd_opl3sa2_pnp_detect(struct pnp_dev *pdev,
 					    const struct pnp_device_id *id)
 {
 	static int dev;
@@ -782,7 +782,7 @@ static struct pnp_driver opl3sa2_pnp_driver = {
 #endif
 };
 
-static int __devinit snd_opl3sa2_pnp_cdetect(struct pnp_card_link *pcard,
+static int snd_opl3sa2_pnp_cdetect(struct pnp_card_link *pcard,
 					     const struct pnp_card_device_id *id)
 {
 	static int dev;
@@ -850,7 +850,7 @@ static struct pnp_card_driver opl3sa2_pnpc_driver = {
 };
 #endif /* CONFIG_PNP */
 
-static int __devinit snd_opl3sa2_isa_match(struct device *pdev,
+static int snd_opl3sa2_isa_match(struct device *pdev,
 					   unsigned int dev)
 {
 	if (!enable[dev])
@@ -878,7 +878,7 @@ static int __devinit snd_opl3sa2_isa_match(struct device *pdev,
 	return 1;
 }
 
-static int __devinit snd_opl3sa2_isa_probe(struct device *pdev,
+static int snd_opl3sa2_isa_probe(struct device *pdev,
 					   unsigned int dev)
 {
 	struct snd_card *card;
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index cb8c930..25418dd 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -670,7 +670,7 @@ static unsigned char aci_init_values[][2] __devinitdata = {
 	{ ACI_SET_MASTER + 1, 0x20 },
 };
 
-static int __devinit snd_set_aci_init_values(struct snd_miro *miro)
+static int snd_set_aci_init_values(struct snd_miro *miro)
 {
 	int idx, error;
 	struct snd_miro_aci *aci = miro->aci;
@@ -713,7 +713,7 @@ static int __devinit snd_set_aci_init_values(struct snd_miro *miro)
 	return 0;
 }
 
-static int __devinit snd_miro_mixer(struct snd_card *card,
+static int snd_miro_mixer(struct snd_card *card,
 				    struct snd_miro *miro)
 {
 	unsigned int idx;
@@ -771,7 +771,7 @@ static int __devinit snd_miro_mixer(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit snd_miro_init(struct snd_miro *chip,
+static int snd_miro_init(struct snd_miro *chip,
 				   unsigned short hardware)
 {
 	static int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
@@ -989,7 +989,7 @@ static void snd_miro_proc_read(struct snd_info_entry * entry,
 	snd_iprintf(buffer, "  preamp  : 0x%x\n", aci->aci_preamp);
 }
 
-static void __devinit snd_miro_proc_init(struct snd_card *card,
+static void snd_miro_proc_init(struct snd_card *card,
 					 struct snd_miro *miro)
 {
 	struct snd_info_entry *entry;
@@ -1002,7 +1002,7 @@ static void __devinit snd_miro_proc_init(struct snd_card *card,
  *  Init
  */
 
-static int __devinit snd_miro_configure(struct snd_miro *chip)
+static int snd_miro_configure(struct snd_miro *chip)
 {
 	unsigned char wss_base_bits;
 	unsigned char irq_bits;
@@ -1162,7 +1162,7 @@ __skip_mpu:
 	return 0;
 }
 
-static int __devinit snd_miro_opti_check(struct snd_miro *chip)
+static int snd_miro_opti_check(struct snd_miro *chip)
 {
 	unsigned char value;
 
@@ -1182,7 +1182,7 @@ static int __devinit snd_miro_opti_check(struct snd_miro *chip)
 	return -ENODEV;
 }
 
-static int __devinit snd_card_miro_detect(struct snd_card *card,
+static int snd_card_miro_detect(struct snd_card *card,
 					  struct snd_miro *chip)
 {
 	int i, err;
@@ -1200,7 +1200,7 @@ static int __devinit snd_card_miro_detect(struct snd_card *card,
 	return -ENODEV;
 }
 
-static int __devinit snd_card_miro_aci_detect(struct snd_card *card,
+static int snd_card_miro_aci_detect(struct snd_card *card,
 					      struct snd_miro *miro)
 {
 	unsigned char regval;
@@ -1265,7 +1265,7 @@ static void snd_card_miro_free(struct snd_card *card)
 	release_and_free_resource(miro->res_mc_base);
 }
 
-static int __devinit snd_miro_probe(struct snd_card *card)
+static int snd_miro_probe(struct snd_card *card)
 {
 	int error;
 	struct snd_miro *miro = card->private_data;
@@ -1386,7 +1386,7 @@ static int __devinit snd_miro_probe(struct snd_card *card)
 	return snd_card_register(card);
 }
 
-static int __devinit snd_miro_isa_match(struct device *devptr, unsigned int n)
+static int snd_miro_isa_match(struct device *devptr, unsigned int n)
 {
 #ifdef CONFIG_PNP
 	if (snd_miro_pnp_is_probed)
@@ -1397,7 +1397,7 @@ static int __devinit snd_miro_isa_match(struct device *devptr, unsigned int n)
 	return 1;
 }
 
-static int __devinit snd_miro_isa_probe(struct device *devptr, unsigned int n)
+static int snd_miro_isa_probe(struct device *devptr, unsigned int n)
 {
 	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
 	static long possible_mpu_ports[] = {0x330, 0x300, 0x310, 0x320, -1};
@@ -1513,7 +1513,7 @@ static struct isa_driver snd_miro_driver = {
 
 #ifdef CONFIG_PNP
 
-static int __devinit snd_card_miro_pnp(struct snd_miro *chip,
+static int snd_card_miro_pnp(struct snd_miro *chip,
 					struct pnp_card_link *card,
 					const struct pnp_card_device_id *pid)
 {
@@ -1574,7 +1574,7 @@ static int __devinit snd_card_miro_pnp(struct snd_miro *chip,
 	return 0;
 }
 
-static int __devinit snd_miro_pnp_probe(struct pnp_card_link *pcard,
+static int snd_miro_pnp_probe(struct pnp_card_link *pcard,
 					const struct pnp_card_device_id *pid)
 {
 	struct snd_card *card;
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 72b1769..4a0d193 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -186,7 +186,7 @@ static char * snd_opti9xx_names[] = {
 	"82C930",	"82C931",	"82C933"
 };
 
-static int __devinit snd_opti9xx_init(struct snd_opti9xx *chip,
+static int snd_opti9xx_init(struct snd_opti9xx *chip,
 				      unsigned short hardware)
 {
 	static int opti9xx_mc_size[] = {7, 7, 10, 10, 2, 2, 2};
@@ -593,7 +593,7 @@ WSS_DOUBLE_TLV("Aux Playback Volume", 0,
 		db_scale_4bit_12db_max),
 };
 
-static int __devinit snd_opti93x_mixer(struct snd_wss *chip)
+static int snd_opti93x_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card;
 	unsigned int idx;
@@ -666,7 +666,7 @@ static irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id)
 
 #endif /* OPTi93X */
 
-static int __devinit snd_opti9xx_read_check(struct snd_opti9xx *chip)
+static int snd_opti9xx_read_check(struct snd_opti9xx *chip)
 {
 	unsigned char value;
 #ifdef OPTi93X
@@ -707,7 +707,7 @@ static int __devinit snd_opti9xx_read_check(struct snd_opti9xx *chip)
 	return -ENODEV;
 }
 
-static int __devinit snd_card_opti9xx_detect(struct snd_card *card,
+static int snd_card_opti9xx_detect(struct snd_card *card,
 					     struct snd_opti9xx *chip)
 {
 	int i, err;
@@ -732,7 +732,7 @@ static int __devinit snd_card_opti9xx_detect(struct snd_card *card,
 }
 
 #ifdef CONFIG_PNP
-static int __devinit snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
+static int snd_card_opti9xx_pnp(struct snd_opti9xx *chip,
 					  struct pnp_card_link *card,
 					  const struct pnp_card_device_id *pid)
 {
@@ -817,7 +817,7 @@ static void snd_card_opti9xx_free(struct snd_card *card)
 	}
 }
 
-static int __devinit snd_opti9xx_probe(struct snd_card *card)
+static int snd_opti9xx_probe(struct snd_card *card)
 {
 	static long possible_ports[] = {0x530, 0xe80, 0xf40, 0x604, -1};
 	int error;
@@ -952,7 +952,7 @@ static int snd_opti9xx_card_new(struct snd_card **cardp)
 	return 0;
 }
 
-static int __devinit snd_opti9xx_isa_match(struct device *devptr,
+static int snd_opti9xx_isa_match(struct device *devptr,
 					   unsigned int dev)
 {
 #ifdef CONFIG_PNP
@@ -964,7 +964,7 @@ static int __devinit snd_opti9xx_isa_match(struct device *devptr,
 	return 1;
 }
 
-static int __devinit snd_opti9xx_isa_probe(struct device *devptr,
+static int snd_opti9xx_isa_probe(struct device *devptr,
 					   unsigned int dev)
 {
 	struct snd_card *card;
@@ -1094,7 +1094,7 @@ static struct isa_driver snd_opti9xx_driver = {
 };
 
 #ifdef CONFIG_PNP
-static int __devinit snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
+static int snd_opti9xx_pnp_probe(struct pnp_card_link *pcard,
 					   const struct pnp_card_device_id *pid)
 {
 	struct snd_card *card;
diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 2aae6a0..3456c92 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -131,8 +131,7 @@ snd_emu8000_dma_chan(struct snd_emu8000 *emu, int ch, int mode)
 
 /*
  */
-static void __devinit
-snd_emu8000_read_wait(struct snd_emu8000 *emu)
+static void snd_emu8000_read_wait(struct snd_emu8000 *emu)
 {
 	while ((EMU8000_SMALR_READ(emu) & 0x80000000) != 0) {
 		schedule_timeout_interruptible(1);
@@ -143,8 +142,7 @@ snd_emu8000_read_wait(struct snd_emu8000 *emu)
 
 /*
  */
-static void __devinit
-snd_emu8000_write_wait(struct snd_emu8000 *emu)
+static void snd_emu8000_write_wait(struct snd_emu8000 *emu)
 {
 	while ((EMU8000_SMALW_READ(emu) & 0x80000000) != 0) {
 		schedule_timeout_interruptible(1);
@@ -156,8 +154,7 @@ snd_emu8000_write_wait(struct snd_emu8000 *emu)
 /*
  * detect a card at the given port
  */
-static int __devinit
-snd_emu8000_detect(struct snd_emu8000 *emu)
+static int snd_emu8000_detect(struct snd_emu8000 *emu)
 {
 	/* Initialise */
 	EMU8000_HWCF1_WRITE(emu, 0x0059);
@@ -182,8 +179,7 @@ snd_emu8000_detect(struct snd_emu8000 *emu)
 /*
  * intiailize audio channels
  */
-static void __devinit
-init_audio(struct snd_emu8000 *emu)
+static void init_audio(struct snd_emu8000 *emu)
 {
 	int ch;
 
@@ -223,8 +219,7 @@ init_audio(struct snd_emu8000 *emu)
 /*
  * initialize DMA address
  */
-static void __devinit
-init_dma(struct snd_emu8000 *emu)
+static void init_dma(struct snd_emu8000 *emu)
 {
 	EMU8000_SMALR_WRITE(emu, 0);
 	EMU8000_SMARR_WRITE(emu, 0);
@@ -327,8 +322,7 @@ static unsigned short init4[128] /*__devinitdata*/ = {
  * Taken from the oss driver, not obvious from the doc how this
  * is meant to work
  */
-static void __devinit
-send_array(struct snd_emu8000 *emu, unsigned short *data, int size)
+static void send_array(struct snd_emu8000 *emu, unsigned short *data, int size)
 {
 	int i;
 	unsigned short *p;
@@ -349,8 +343,7 @@ send_array(struct snd_emu8000 *emu, unsigned short *data, int size)
  * Send initialization arrays to start up, this just follows the
  * initialisation sequence in the adip.
  */
-static void __devinit
-init_arrays(struct snd_emu8000 *emu)
+static void init_arrays(struct snd_emu8000 *emu)
 {
 	send_array(emu, init1, ARRAY_SIZE(init1)/4);
 
@@ -375,8 +368,7 @@ init_arrays(struct snd_emu8000 *emu)
  * seems that the only way to do this is to use the one channel and keep
  * reallocating between read and write.
  */
-static void __devinit
-size_dram(struct snd_emu8000 *emu)
+static void size_dram(struct snd_emu8000 *emu)
 {
 	int i, size, detected_size;
 
@@ -512,8 +504,7 @@ snd_emu8000_init_fm(struct snd_emu8000 *emu)
 /*
  * The main initialization routine.
  */
-static void __devinit
-snd_emu8000_init_hw(struct snd_emu8000 *emu)
+static void snd_emu8000_init_hw(struct snd_emu8000 *emu)
 {
 	int i;
 
@@ -1031,8 +1022,7 @@ static struct snd_kcontrol_new *mixer_defs[EMU8000_NUM_CONTROLS] = {
 /*
  * create and attach mixer elements for WaveTable treble/bass controls
  */
-static int __devinit
-snd_emu8000_create_mixer(struct snd_card *card, struct snd_emu8000 *emu)
+static int snd_emu8000_create_mixer(struct snd_card *card, struct snd_emu8000 *emu)
 {
 	int i, err = 0;
 
@@ -1082,8 +1072,7 @@ static int snd_emu8000_dev_free(struct snd_device *device)
 /*
  * initialize and register emu8000 synth device.
  */
-int __devinit
-snd_emu8000_new(struct snd_card *card, int index, long port, int seq_ports,
+int snd_emu8000_new(struct snd_card *card, int index, long port, int seq_ports,
 		struct snd_seq_device **awe_ret)
 {
 	struct snd_seq_device *awe;
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 529f175..5bc42fe 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -78,7 +78,7 @@ static irqreturn_t jazz16_interrupt(int irq, void *chip)
 	return snd_sb8dsp_interrupt(chip);
 }
 
-static int __devinit jazz16_configure_ports(unsigned long port,
+static int jazz16_configure_ports(unsigned long port,
 					    unsigned long mpu_port, int idx)
 {
 	unsigned char val;
@@ -99,7 +99,7 @@ static int __devinit jazz16_configure_ports(unsigned long port,
 	return 0;
 }
 
-static int __devinit jazz16_detect_board(unsigned long port,
+static int jazz16_detect_board(unsigned long port,
 					 unsigned long mpu_port)
 {
 	int err;
@@ -156,7 +156,7 @@ err_unmap:
 	return err;
 }
 
-static int __devinit jazz16_configure_board(struct snd_sb *chip, int mpu_irq)
+static int jazz16_configure_board(struct snd_sb *chip, int mpu_irq)
 {
 	static unsigned char jazz_irq_bits[] = { 0, 0, 2, 3, 0, 1, 0, 4,
 						 0, 2, 5, 0, 0, 0, 0, 6 };
@@ -183,7 +183,7 @@ static int __devinit jazz16_configure_board(struct snd_sb *chip, int mpu_irq)
 	return 0;
 }
 
-static int __devinit snd_jazz16_match(struct device *devptr, unsigned int dev)
+static int snd_jazz16_match(struct device *devptr, unsigned int dev)
 {
 	if (!enable[dev])
 		return 0;
@@ -218,7 +218,7 @@ static int __devinit snd_jazz16_match(struct device *devptr, unsigned int dev)
 	return 1;
 }
 
-static int __devinit snd_jazz16_probe(struct device *devptr, unsigned int dev)
+static int snd_jazz16_probe(struct device *devptr, unsigned int dev)
 {
 	struct snd_card *card;
 	struct snd_card_jazz16 *jazz16;
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index bb8a688..fcb14b8 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -250,7 +250,7 @@ MODULE_DEVICE_TABLE(pnp_card, snd_sb16_pnpids);
 
 #ifdef CONFIG_PNP
 
-static int __devinit snd_card_sb16_pnp(int dev, struct snd_card_sb16 *acard,
+static int snd_card_sb16_pnp(int dev, struct snd_card_sb16 *acard,
 				       struct pnp_card_link *card,
 				       const struct pnp_card_device_id *id)
 {
@@ -337,7 +337,7 @@ static int snd_sb16_card_new(int dev, struct snd_card **cardp)
 	return 0;
 }
 
-static int __devinit snd_sb16_probe(struct snd_card *card, int dev)
+static int snd_sb16_probe(struct snd_card *card, int dev)
 {
 	int xirq, xdma8, xdma16;
 	struct snd_sb *chip;
@@ -487,7 +487,7 @@ static int snd_sb16_resume(struct snd_card *card)
 }
 #endif
 
-static int __devinit snd_sb16_isa_probe1(int dev, struct device *pdev)
+static int snd_sb16_isa_probe1(int dev, struct device *pdev)
 {
 	struct snd_card_sb16 *acard;
 	struct snd_card *card;
@@ -517,12 +517,12 @@ static int __devinit snd_sb16_isa_probe1(int dev, struct device *pdev)
 }
 
 
-static int __devinit snd_sb16_isa_match(struct device *pdev, unsigned int dev)
+static int snd_sb16_isa_match(struct device *pdev, unsigned int dev)
 {
 	return enable[dev] && !is_isapnp_selected(dev);
 }
 
-static int __devinit snd_sb16_isa_probe(struct device *pdev, unsigned int dev)
+static int snd_sb16_isa_probe(struct device *pdev, unsigned int dev)
 {
 	int err;
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
@@ -604,7 +604,7 @@ static struct isa_driver snd_sb16_isa_driver = {
 
 
 #ifdef CONFIG_PNP
-static int __devinit snd_sb16_pnp_detect(struct pnp_card_link *pcard,
+static int snd_sb16_pnp_detect(struct pnp_card_link *pcard,
 					 const struct pnp_card_device_id *pid)
 {
 	static int dev;
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index 0cc9a9a..69aa275 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -79,7 +79,7 @@ static void snd_sb8_free(struct snd_card *card)
 	release_and_free_resource(acard->fm_res);
 }
 
-static int __devinit snd_sb8_match(struct device *pdev, unsigned int dev)
+static int snd_sb8_match(struct device *pdev, unsigned int dev)
 {
 	if (!enable[dev])
 		return 0;
@@ -94,7 +94,7 @@ static int __devinit snd_sb8_match(struct device *pdev, unsigned int dev)
 	return 1;
 }
 
-static int __devinit snd_sb8_probe(struct device *pdev, unsigned int dev)
+static int snd_sb8_probe(struct device *pdev, unsigned int dev)
 {
 	struct snd_sb *chip;
 	struct snd_card *card;
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index 57266de..486da56 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -121,7 +121,7 @@ MODULE_PARM_DESC(joystick, "Enable gameport.");
 /*
  * sc6000_irq_to_softcfg - Decode irq number into cfg code.
  */
-static __devinit unsigned char sc6000_irq_to_softcfg(int irq)
+static unsigned char sc6000_irq_to_softcfg(int irq)
 {
 	unsigned char val = 0;
 
@@ -150,7 +150,7 @@ static __devinit unsigned char sc6000_irq_to_softcfg(int irq)
 /*
  * sc6000_dma_to_softcfg - Decode dma number into cfg code.
  */
-static __devinit unsigned char sc6000_dma_to_softcfg(int dma)
+static unsigned char sc6000_dma_to_softcfg(int dma)
 {
 	unsigned char val = 0;
 
@@ -173,7 +173,7 @@ static __devinit unsigned char sc6000_dma_to_softcfg(int dma)
 /*
  * sc6000_mpu_irq_to_softcfg - Decode MPU-401 irq number into cfg code.
  */
-static __devinit unsigned char sc6000_mpu_irq_to_softcfg(int mpu_irq)
+static unsigned char sc6000_mpu_irq_to_softcfg(int mpu_irq)
 {
 	unsigned char val = 0;
 
@@ -242,7 +242,7 @@ static int sc6000_write(char __iomem *vport, int cmd)
 	return -EIO;
 }
 
-static int __devinit sc6000_dsp_get_answer(char __iomem *vport, int command,
+static int sc6000_dsp_get_answer(char __iomem *vport, int command,
 					   char *data, int data_len)
 {
 	int len = 0;
@@ -269,7 +269,7 @@ static int __devinit sc6000_dsp_get_answer(char __iomem *vport, int command,
 	return len ? len : -EIO;
 }
 
-static int __devinit sc6000_dsp_reset(char __iomem *vport)
+static int sc6000_dsp_reset(char __iomem *vport)
 {
 	iowrite8(1, vport + DSP_RESET);
 	udelay(10);
@@ -281,7 +281,7 @@ static int __devinit sc6000_dsp_reset(char __iomem *vport)
 }
 
 /* detection and initialization */
-static int __devinit sc6000_hw_cfg_write(char __iomem *vport, const int *cfg)
+static int sc6000_hw_cfg_write(char __iomem *vport, const int *cfg)
 {
 	if (sc6000_write(vport, COMMAND_6C) < 0) {
 		snd_printk(KERN_WARNING "CMD 0x%x: failed!\n", COMMAND_6C);
@@ -345,7 +345,7 @@ static int sc6000_setup_board(char __iomem *vport, int config)
 	return 0;
 }
 
-static int __devinit sc6000_init_mss(char __iomem *vport, int config,
+static int sc6000_init_mss(char __iomem *vport, int config,
 				     char __iomem *vmss_port, int mss_config)
 {
 	if (sc6000_write(vport, DSP_INIT_MSS)) {
@@ -364,7 +364,7 @@ static int __devinit sc6000_init_mss(char __iomem *vport, int config,
 	return 0;
 }
 
-static void __devinit sc6000_hw_cfg_encode(char __iomem *vport, int *cfg,
+static void sc6000_hw_cfg_encode(char __iomem *vport, int *cfg,
 					   long xport, long xmpu,
 					   long xmss_port, int joystick)
 {
@@ -386,7 +386,7 @@ static void __devinit sc6000_hw_cfg_encode(char __iomem *vport, int *cfg,
 	snd_printd("hw cfg %x, %x\n", cfg[0], cfg[1]);
 }
 
-static int __devinit sc6000_init_board(char __iomem *vport,
+static int sc6000_init_board(char __iomem *vport,
 					char __iomem *vmss_port, int dev)
 {
 	char answer[15];
@@ -467,7 +467,7 @@ static int __devinit sc6000_init_board(char __iomem *vport,
 	return 0;
 }
 
-static int __devinit snd_sc6000_mixer(struct snd_wss *chip)
+static int snd_sc6000_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
@@ -502,7 +502,7 @@ static int __devinit snd_sc6000_mixer(struct snd_wss *chip)
 	return 0;
 }
 
-static int __devinit snd_sc6000_match(struct device *devptr, unsigned int dev)
+static int snd_sc6000_match(struct device *devptr, unsigned int dev)
 {
 	if (!enable[dev])
 		return 0;
@@ -545,7 +545,7 @@ static int __devinit snd_sc6000_match(struct device *devptr, unsigned int dev)
 	return 1;
 }
 
-static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
+static int snd_sc6000_probe(struct device *devptr, unsigned int dev)
 {
 	static int possible_irqs[] = { 5, 7, 9, 10, 11, -1 };
 	static int possible_dmas[] = { 1, 3, 0, -1 };
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index eb8fe7f..0b67a79 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -683,7 +683,7 @@ static struct snd_kcontrol_new midi_mixer_ctl = {
  * These IRQs are encoded as bit patterns so that they can be
  * written to the control registers.
  */
-static unsigned __devinit get_irq_config(int sscape_type, int irq)
+static unsigned get_irq_config(int sscape_type, int irq)
 {
 	static const int valid_irq[] = { 9, 5, 7, 10 };
 	static const int old_irq[] = { 9, 7, 5, 15 };
@@ -706,7 +706,7 @@ static unsigned __devinit get_irq_config(int sscape_type, int irq)
  * Perform certain arcane port-checks to see whether there
  * is a SoundScape board lurking behind the given ports.
  */
-static int __devinit detect_sscape(struct soundscape *s, long wss_io)
+static int detect_sscape(struct soundscape *s, long wss_io)
 {
 	unsigned long flags;
 	unsigned d;
@@ -817,7 +817,7 @@ static int mpu401_open(struct snd_mpu401 *mpu)
 /*
  * Initialse an MPU-401 subdevice for MIDI support on the SoundScape.
  */
-static int __devinit create_mpu401(struct snd_card *card, int devnum,
+static int create_mpu401(struct snd_card *card, int devnum,
 				   unsigned long port, int irq)
 {
 	struct soundscape *sscape = get_card_soundscape(card);
@@ -845,7 +845,7 @@ static int __devinit create_mpu401(struct snd_card *card, int devnum,
  * try to support at least some of the extra bits by overriding
  * some of the CS4231 callback.
  */
-static int __devinit create_ad1845(struct snd_card *card, unsigned port,
+static int create_ad1845(struct snd_card *card, unsigned port,
 				   int irq, int dma1, int dma2)
 {
 	register struct soundscape *sscape = get_card_soundscape(card);
@@ -937,7 +937,7 @@ _error:
  * Create an ALSA soundcard entry for the SoundScape, using
  * the given list of port, IRQ and DMA resources.
  */
-static int __devinit create_sscape(int dev, struct snd_card *card)
+static int create_sscape(int dev, struct snd_card *card)
 {
 	struct soundscape *sscape = get_card_soundscape(card);
 	unsigned dma_cfg;
@@ -1143,7 +1143,7 @@ _release_region:
 }
 
 
-static int __devinit snd_sscape_match(struct device *pdev, unsigned int i)
+static int snd_sscape_match(struct device *pdev, unsigned int i)
 {
 	/*
 	 * Make sure we were given ALL of the other parameters.
@@ -1163,7 +1163,7 @@ static int __devinit snd_sscape_match(struct device *pdev, unsigned int i)
 	return 1;
 }
 
-static int __devinit snd_sscape_probe(struct device *pdev, unsigned int dev)
+static int snd_sscape_probe(struct device *pdev, unsigned int dev)
 {
 	struct snd_card *card;
 	struct soundscape *sscape;
@@ -1217,7 +1217,7 @@ static struct isa_driver snd_sscape_driver = {
 };
 
 #ifdef CONFIG_PNP
-static inline int __devinit get_next_autoindex(int i)
+static inline int get_next_autoindex(int i)
 {
 	while (i < SNDRV_CARDS && port[i] != SNDRV_AUTO_PORT)
 		++i;
@@ -1225,7 +1225,7 @@ static inline int __devinit get_next_autoindex(int i)
 }
 
 
-static int __devinit sscape_pnp_detect(struct pnp_card_link *pcard,
+static int sscape_pnp_detect(struct pnp_card_link *pcard,
 				       const struct pnp_card_device_id *pid)
 {
 	static int idx = 0;
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index d700ca9..abe3c34 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -98,8 +98,7 @@ static struct pnp_card_device_id snd_wavefront_pnpids[] = {
 
 MODULE_DEVICE_TABLE(pnp_card, snd_wavefront_pnpids);
 
-static int __devinit
-snd_wavefront_pnp (int dev, snd_wavefront_card_t *acard, struct pnp_card_link *card,
+static int snd_wavefront_pnp (int dev, snd_wavefront_card_t *acard, struct pnp_card_link *card,
 		   const struct pnp_card_device_id *id)
 {
 	struct pnp_dev *pdev;
@@ -231,8 +230,7 @@ static irqreturn_t snd_wavefront_ics2115_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct snd_hwdep * __devinit
-snd_wavefront_new_synth (struct snd_card *card,
+static struct snd_hwdep *snd_wavefront_new_synth (struct snd_card *card,
 			 int hw_dev,
 			 snd_wavefront_card_t *acard)
 {
@@ -257,8 +255,7 @@ snd_wavefront_new_synth (struct snd_card *card,
 	return wavefront_synth;
 }
 
-static struct snd_hwdep * __devinit
-snd_wavefront_new_fx (struct snd_card *card,
+static struct snd_hwdep *snd_wavefront_new_fx (struct snd_card *card,
 		      int hw_dev,
 		      snd_wavefront_card_t *acard,
 		      unsigned long port)
@@ -284,8 +281,7 @@ snd_wavefront_new_fx (struct snd_card *card,
 static snd_wavefront_mpu_id internal_id = internal_mpu;
 static snd_wavefront_mpu_id external_id = external_mpu;
 
-static struct snd_rawmidi *__devinit
-snd_wavefront_new_midi (struct snd_card *card,
+static struct snd_rawmidi *snd_wavefront_new_midi (struct snd_card *card,
 			int midi_dev,
 			snd_wavefront_card_t *acard,
 			unsigned long port,
@@ -361,8 +357,7 @@ static int snd_wavefront_card_new(int dev, struct snd_card **cardp)
 	return 0;
 }
 
-static int __devinit
-snd_wavefront_probe (struct snd_card *card, int dev)
+static int snd_wavefront_probe (struct snd_card *card, int dev)
 {
 	snd_wavefront_card_t *acard = card->private_data;
 	struct snd_wss *chip;
@@ -541,7 +536,7 @@ snd_wavefront_probe (struct snd_card *card, int dev)
 	return snd_card_register(card);
 }	
 
-static int __devinit snd_wavefront_isa_match(struct device *pdev,
+static int snd_wavefront_isa_match(struct device *pdev,
 					     unsigned int dev)
 {
 	if (!enable[dev])
@@ -561,7 +556,7 @@ static int __devinit snd_wavefront_isa_match(struct device *pdev,
 	return 1;
 }
 
-static int __devinit snd_wavefront_isa_probe(struct device *pdev,
+static int snd_wavefront_isa_probe(struct device *pdev,
 					     unsigned int dev)
 {
 	struct snd_card *card;
@@ -602,7 +597,7 @@ static struct isa_driver snd_wavefront_driver = {
 
 
 #ifdef CONFIG_PNP
-static int __devinit snd_wavefront_pnp_detect(struct pnp_card_link *pcard,
+static int snd_wavefront_pnp_detect(struct pnp_card_link *pcard,
 					const struct pnp_card_device_id *pid)
 {
 	static int dev;
diff --git a/sound/isa/wavefront/wavefront_fx.c b/sound/isa/wavefront/wavefront_fx.c
index e51e090..2d4fa4a 100644
--- a/sound/isa/wavefront/wavefront_fx.c
+++ b/sound/isa/wavefront/wavefront_fx.c
@@ -240,8 +240,7 @@ snd_wavefront_fx_ioctl (struct snd_hwdep *sdev, struct file *file,
    that outputs it.
 */
 
-int __devinit
-snd_wavefront_fx_start (snd_wavefront_t *dev)
+int snd_wavefront_fx_start (snd_wavefront_t *dev)
 {
 	unsigned int i;
 	int err;
diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 65329f3..faa2483 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -481,8 +481,7 @@ snd_wavefront_midi_disable_virtual (snd_wavefront_card_t *card)
 	spin_unlock_irqrestore (&card->wavefront.midi.virtual, flags);
 }
 
-int __devinit
-snd_wavefront_midi_start (snd_wavefront_card_t *card)
+int snd_wavefront_midi_start (snd_wavefront_card_t *card)
 
 {
 	int ok, i;
diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index b1bf8d4..7345a87 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -1739,8 +1739,7 @@ snd_wavefront_internal_interrupt (snd_wavefront_card_t *card)
 7 Unused
 */
 
-static int __devinit
-snd_wavefront_interrupt_bits (int irq)
+static int snd_wavefront_interrupt_bits (int irq)
 
 {
 	int bits;
@@ -1767,8 +1766,7 @@ snd_wavefront_interrupt_bits (int irq)
 	return bits;
 }
 
-static void __devinit
-wavefront_should_cause_interrupt (snd_wavefront_t *dev, 
+static void wavefront_should_cause_interrupt (snd_wavefront_t *dev,
 				  int val, int port, unsigned long timeout)
 
 {
@@ -1786,8 +1784,7 @@ wavefront_should_cause_interrupt (snd_wavefront_t *dev,
 	}
 }
 
-static int __devinit
-wavefront_reset_to_cleanliness (snd_wavefront_t *dev)
+static int wavefront_reset_to_cleanliness (snd_wavefront_t *dev)
 
 {
 	int bits;
@@ -1937,8 +1934,7 @@ wavefront_reset_to_cleanliness (snd_wavefront_t *dev)
 	return (1);
 }
 
-static int __devinit
-wavefront_download_firmware (snd_wavefront_t *dev, char *path)
+static int wavefront_download_firmware (snd_wavefront_t *dev, char *path)
 
 {
 	const unsigned char *buf;
@@ -2010,8 +2006,7 @@ wavefront_download_firmware (snd_wavefront_t *dev, char *path)
 }
 
 
-static int __devinit
-wavefront_do_reset (snd_wavefront_t *dev)
+static int wavefront_do_reset (snd_wavefront_t *dev)
 
 {
 	char voices[1];
@@ -2099,8 +2094,7 @@ wavefront_do_reset (snd_wavefront_t *dev)
 	return 1;
 }
 
-int __devinit
-snd_wavefront_start (snd_wavefront_t *dev)
+int snd_wavefront_start (snd_wavefront_t *dev)
 
 {
 	int samples_are_from_rom;
@@ -2141,8 +2135,7 @@ snd_wavefront_start (snd_wavefront_t *dev)
 	return (0);
 }
 
-int __devinit
-snd_wavefront_detect (snd_wavefront_card_t *card)
+int snd_wavefront_detect (snd_wavefront_card_t *card)
 
 {
 	unsigned char   rbuf[4], wbuf[4];
diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 3f3ec0b..6110c12 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -439,8 +439,7 @@ static struct snd_pcm_ops snd_card_au1000_capture_ops = {
 	.pointer		= snd_au1000_pointer,
 };
 
-static int __devinit
-snd_au1000_pcm_new(struct snd_au1000 *au1000)
+static int snd_au1000_pcm_new(struct snd_au1000 *au1000)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -552,8 +551,7 @@ get the interrupt driven case to work efficiently */
 	spin_unlock(&au1000->ac97_lock);
 }
 
-static int __devinit
-snd_au1000_ac97_new(struct snd_au1000 *au1000)
+static int snd_au1000_ac97_new(struct snd_au1000 *au1000)
 {
 	int err;
 	struct snd_ac97_bus *pbus;
diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 0bd7fb5..0670a83 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -280,7 +280,7 @@ static struct snd_kcontrol_new hal2_ctrl_mic __devinitdata = {
 	.put            = hal2_gain_put,
 };
 
-static int __devinit hal2_mixer_create(struct snd_hal2 *hal2)
+static int hal2_mixer_create(struct snd_hal2 *hal2)
 {
 	int err;
 
@@ -733,7 +733,7 @@ static struct snd_pcm_ops hal2_capture_ops = {
 	.ack =         hal2_capture_ack,
 };
 
-static int __devinit hal2_pcm_create(struct snd_hal2 *hal2)
+static int hal2_pcm_create(struct snd_hal2 *hal2)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -874,7 +874,7 @@ static int hal2_create(struct snd_card *card, struct snd_hal2 **rchip)
 	return 0;
 }
 
-static int __devinit hal2_probe(struct platform_device *pdev)
+static int hal2_probe(struct platform_device *pdev)
 {
 	struct snd_card *card;
 	struct snd_hal2 *chip;
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index b67d555..ff32a07 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -317,7 +317,7 @@ static struct snd_kcontrol_new sgio2audio_ctrl_mic __devinitdata = {
 };
 
 
-static int __devinit snd_sgio2audio_new_mixer(struct snd_sgio2audio *chip)
+static int snd_sgio2audio_new_mixer(struct snd_sgio2audio *chip)
 {
 	int err;
 
@@ -726,7 +726,7 @@ static struct snd_pcm_ops snd_sgio2audio_capture_ops = {
  */
 
 /* create a pcm device */
-static int __devinit snd_sgio2audio_new_pcm(struct snd_sgio2audio *chip)
+static int snd_sgio2audio_new_pcm(struct snd_sgio2audio *chip)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -834,7 +834,7 @@ static struct snd_device_ops ops = {
 	.dev_free = snd_sgio2audio_dev_free,
 };
 
-static int __devinit snd_sgio2audio_create(struct snd_card *card,
+static int snd_sgio2audio_create(struct snd_card *card,
 					   struct snd_sgio2audio **rchip)
 {
 	struct snd_sgio2audio *chip;
@@ -914,7 +914,7 @@ static int __devinit snd_sgio2audio_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit snd_sgio2audio_probe(struct platform_device *pdev)
+static int snd_sgio2audio_probe(struct platform_device *pdev)
 {
 	struct snd_card *card;
 	struct snd_sgio2audio *chip;
diff --git a/sound/oss/kahlua.c b/sound/oss/kahlua.c
index f0836bc..5d092d2 100644
--- a/sound/oss/kahlua.c
+++ b/sound/oss/kahlua.c
@@ -43,7 +43,7 @@
  *	not real hardware.
  */
 
-static u8 __devinit mixer_read(unsigned long io, u8 reg)
+static u8 mixer_read(unsigned long io, u8 reg)
 {
 	outb(reg, io + 4);
 	udelay(20);
@@ -52,7 +52,7 @@ static u8 __devinit mixer_read(unsigned long io, u8 reg)
 	return reg;
 }
 
-static int __devinit probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct address_info *hw_config;
 	unsigned long base;
diff --git a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
index 7d8803a..067ff1b 100644
--- a/sound/oss/swarm_cs4297a.c
+++ b/sound/oss/swarm_cs4297a.c
@@ -46,7 +46,7 @@
 *                libOSSm.so)
 * 10/11/00 trw - modified for 2.4.0-test9 kernel enhancements (NR_MAP removal)
 * 11/03/00 trw - fixed interrupt loss/stutter, added debug.
-* 11/10/00 bkz - added __devinit to cs4297a_hw_init()
+* 11/10/00 bkz - added to cs4297a_hw_init()
 * 11/10/00 trw - fixed SMP and capture spinlock hang.
 * 12/04/00 trw - cleaned up CSDEBUG flags and added "defaultorder" moduleparm.
 * 12/05/00 trw - fixed polling (myth2), and added underrun swptr fix.
diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 41307cc..cef6a11 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -856,8 +856,7 @@ static struct snd_kcontrol_new snd_harmony_controls[] = {
 		       HARMONY_GAIN_HE_SHIFT, 1, 0),
 };
 
-static void __devinit
-snd_harmony_mixer_reset(struct snd_harmony *h)
+static void snd_harmony_mixer_reset(struct snd_harmony *h)
 {
 	harmony_mute(h);
 	harmony_reset(h);
@@ -865,8 +864,7 @@ snd_harmony_mixer_reset(struct snd_harmony *h)
 	harmony_unmute(h);
 }
 
-static int __devinit
-snd_harmony_mixer_init(struct snd_harmony *h)
+static int snd_harmony_mixer_init(struct snd_harmony *h)
 {
 	struct snd_card *card;
 	int idx, err;
@@ -915,8 +913,7 @@ snd_harmony_dev_free(struct snd_device *dev)
 	return snd_harmony_free(h);
 }
 
-static int __devinit
-snd_harmony_create(struct snd_card *card, 
+static int snd_harmony_create(struct snd_card *card,
 		   struct parisc_device *padev, 
 		   struct snd_harmony **rchip)
 {
@@ -972,8 +969,7 @@ free_and_ret:
 	return err;
 }
 
-static int __devinit
-snd_harmony_probe(struct parisc_device *padev)
+static int snd_harmony_probe(struct parisc_device *padev)
 {
 	int err;
 	struct snd_card *card;
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index b4dc050..099d9fd 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -624,8 +624,7 @@ snd_ad1889_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit
-snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
+static int snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
 {
 	int err;
 	struct snd_pcm *pcm;
@@ -747,8 +746,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 	snd_iprintf(buffer, "Resampler samplerate: %u Hz\n", reg);
 }
 
-static void __devinit
-snd_ad1889_proc_init(struct snd_ad1889 *chip)
+static void snd_ad1889_proc_init(struct snd_ad1889 *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -767,8 +765,7 @@ static struct ac97_quirk ac97_quirks[] = {
 	{ } /* terminator */
 };
 
-static void __devinit
-snd_ad1889_ac97_xinit(struct snd_ad1889 *chip)
+static void snd_ad1889_ac97_xinit(struct snd_ad1889 *chip)
 {
 	u16 reg;
 
@@ -805,8 +802,7 @@ snd_ad1889_ac97_free(struct snd_ac97 *ac97)
 	chip->ac97 = NULL;
 }
 
-static int __devinit
-snd_ad1889_ac97_init(struct snd_ad1889 *chip, const char *quirk_override)
+static int snd_ad1889_ac97_init(struct snd_ad1889 *chip, const char *quirk_override)
 {
 	int err;
 	struct snd_ac97_template ac97;
@@ -878,8 +874,7 @@ snd_ad1889_dev_free(struct snd_device *device)
 	return snd_ad1889_free(chip);
 }
 
-static int __devinit
-snd_ad1889_init(struct snd_ad1889 *chip) 
+static int snd_ad1889_init(struct snd_ad1889 *chip)
 {
 	ad1889_writew(chip, AD_DS_CCS, AD_DS_CCS_CLKEN); /* turn on clock */
 	ad1889_readw(chip, AD_DS_CCS);	/* flush posted write */
@@ -892,8 +887,7 @@ snd_ad1889_init(struct snd_ad1889 *chip)
 	return 0;
 }
 
-static int __devinit
-snd_ad1889_create(struct snd_card *card,
+static int snd_ad1889_create(struct snd_card *card,
 		  struct pci_dev *pci,
 		  struct snd_ad1889 **rchip)
 {
@@ -978,8 +972,7 @@ free_and_ret:
 	return err;
 }
 
-static int __devinit
-snd_ad1889_probe(struct pci_dev *pci,
+static int snd_ad1889_probe(struct pci_dev *pci,
 		 const struct pci_device_id *pci_id)
 {
 	int err;
diff --git a/sound/pci/ak4531_codec.c b/sound/pci/ak4531_codec.c
index cadf7b9..d3e5cf1 100644
--- a/sound/pci/ak4531_codec.c
+++ b/sound/pci/ak4531_codec.c
@@ -383,7 +383,7 @@ static u8 snd_ak4531_initial_map[0x19 + 1] = {
 	0x01		/* 19: Mic Amp Setup */
 };
 
-int __devinit snd_ak4531_mixer(struct snd_card *card,
+int snd_ak4531_mixer(struct snd_card *card,
 			       struct snd_ak4531 *_ak4531,
 			       struct snd_ak4531 **rak4531)
 {
@@ -483,8 +483,7 @@ static void snd_ak4531_proc_read(struct snd_info_entry *entry,
 		    ak4531->regs[AK4531_MIC_GAIN] & 1 ? "+30dB" : "+0dB");
 }
 
-static void __devinit
-snd_ak4531_proc_init(struct snd_card *card, struct snd_ak4531 *ak4531)
+static void snd_ak4531_proc_init(struct snd_card *card, struct snd_ak4531 *ak4531)
 {
 	struct snd_info_entry *entry;
 
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 5550bfb..7691659 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1678,7 +1678,7 @@ static void snd_ali_pcm_free(struct snd_pcm *pcm)
 }
 
 
-static int __devinit snd_ali_pcm(struct snd_ali * codec, int device,
+static int snd_ali_pcm(struct snd_ali * codec, int device,
 				 struct ali_pcm_description *desc)
 {
 	struct snd_pcm *pcm;
@@ -1727,7 +1727,7 @@ static struct ali_pcm_description ali_pcms[] = {
 	}
 };
 
-static int __devinit snd_ali_build_pcms(struct snd_ali *codec)
+static int snd_ali_build_pcms(struct snd_ali *codec)
 {
 	int i, err;
 	for (i = 0; i < codec->num_of_codecs && i < ARRAY_SIZE(ali_pcms); i++) {
@@ -1842,7 +1842,7 @@ static struct snd_kcontrol_new snd_ali5451_mixer_spdif[] __devinitdata = {
 	ALI5451_SPDIF(SNDRV_CTL_NAME_IEC958("",CAPTURE,SWITCH), 0, 2)
 };
 
-static int __devinit snd_ali_mixer(struct snd_ali * codec)
+static int snd_ali_mixer(struct snd_ali * codec)
 {
 	struct snd_ac97_template ac97;
 	unsigned int idx;
@@ -2079,14 +2079,14 @@ static void snd_ali_proc_read(struct snd_info_entry *entry,
 		snd_iprintf(buf, "%02x: %08x\n", i, inl(ALI_REG(codec, i)));
 }
 
-static void __devinit snd_ali_proc_init(struct snd_ali *codec)
+static void snd_ali_proc_init(struct snd_ali *codec)
 {
 	struct snd_info_entry *entry;
 	if (!snd_card_proc_new(codec->card, "ali5451", &entry))
 		snd_info_set_text_ops(entry, codec, snd_ali_proc_read);
 }
 
-static int __devinit snd_ali_resources(struct snd_ali *codec)
+static int snd_ali_resources(struct snd_ali *codec)
 {
 	int err;
 
@@ -2112,7 +2112,7 @@ static int snd_ali_dev_free(struct snd_device *device)
 	return 0;
 }
 
-static int __devinit snd_ali_create(struct snd_card *card,
+static int snd_ali_create(struct snd_card *card,
 				    struct pci_dev *pci,
 				    int pcm_streams,
 				    int spdif_support,
@@ -2246,7 +2246,7 @@ static int __devinit snd_ali_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit snd_ali_probe(struct pci_dev *pci,
+static int snd_ali_probe(struct pci_dev *pci,
 				   const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 4e7e625..8fac3ce 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -622,7 +622,7 @@ static struct snd_pcm_ops snd_als300_capture_ops = {
 	.pointer =	snd_als300_pointer,
 };
 
-static int __devinit snd_als300_new_pcm(struct snd_als300 *chip)
+static int snd_als300_new_pcm(struct snd_als300 *chip)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -683,7 +683,7 @@ static void snd_als300_init(struct snd_als300 *chip)
 	snd_als300_dbgcallleave();
 }
 
-static int __devinit snd_als300_create(struct snd_card *card,
+static int snd_als300_create(struct snd_card *card,
 				       struct pci_dev *pci, int chip_type,
 				       struct snd_als300 **rchip)
 {
@@ -815,7 +815,7 @@ static SIMPLE_DEV_PM_OPS(snd_als300_pm, snd_als300_suspend, snd_als300_resume);
 #define SND_ALS300_PM_OPS	NULL
 #endif
 
-static int __devinit snd_als300_probe(struct pci_dev *pci,
+static int snd_als300_probe(struct pci_dev *pci,
                              const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 3e0461e..2588c47 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -694,7 +694,7 @@ static struct snd_pcm_ops snd_als4000_capture_ops = {
 	.pointer =	snd_als4000_capture_pointer
 };
 
-static int __devinit snd_als4000_pcm(struct snd_sb *chip, int device)
+static int snd_als4000_pcm(struct snd_sb *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -770,7 +770,7 @@ static void snd_als4000_configure(struct snd_sb *chip)
 }
 
 #ifdef SUPPORT_JOYSTICK
-static int __devinit snd_als4000_create_gameport(struct snd_card_als4000 *acard, int dev)
+static int snd_als4000_create_gameport(struct snd_card_als4000 *acard, int dev)
 {
 	struct gameport *gp;
 	struct resource *r;
@@ -847,7 +847,7 @@ static void snd_card_als4000_free( struct snd_card *card )
 	pci_disable_device(acard->pci);
 }
 
-static int __devinit snd_card_als4000_probe(struct pci_dev *pci,
+static int snd_card_als4000_probe(struct pci_dev *pci,
 					  const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 7924f05..a01739c 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1235,7 +1235,7 @@ static struct snd_pcm_ops snd_card_asihpi_capture_mmap_ops = {
 	.pointer = snd_card_asihpi_capture_pointer,
 };
 
-static int __devinit snd_card_asihpi_pcm_new(
+static int snd_card_asihpi_pcm_new(
 		struct snd_card_asihpi *asihpi, int device)
 {
 	struct snd_pcm *pcm;
@@ -1497,7 +1497,7 @@ static int snd_asihpi_volume_mute_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static int __devinit snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -1593,7 +1593,7 @@ static int snd_asihpi_level_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_level, -1000, 100, 0);
 
-static int __devinit snd_asihpi_level_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_level_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -1715,7 +1715,7 @@ static int snd_asihpi_aesebu_rxstatus_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int __devinit snd_asihpi_aesebu_rx_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_aesebu_rx_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -1753,7 +1753,7 @@ static int snd_asihpi_aesebu_tx_format_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static int __devinit snd_asihpi_aesebu_tx_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_aesebu_tx_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -1996,7 +1996,7 @@ static int snd_asihpi_tuner_freq_put(struct snd_kcontrol *kcontrol,
 }
 
 /* Tuner control group initializer  */
-static int __devinit snd_asihpi_tuner_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_tuner_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -2100,7 +2100,7 @@ static int snd_asihpi_meter_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int __devinit snd_asihpi_meter_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_meter_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl, int subidx)
 {
 	struct snd_card *card = asihpi->card;
@@ -2214,7 +2214,7 @@ static int snd_asihpi_mux_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static int  __devinit snd_asihpi_mux_add(struct snd_card_asihpi *asihpi,
+static int  snd_asihpi_mux_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -2303,7 +2303,7 @@ static int snd_asihpi_cmode_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static int __devinit snd_asihpi_cmode_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_cmode_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -2471,7 +2471,7 @@ static int snd_asihpi_clkrate_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 					struct hpi_control *hpi_ctl)
 {
 	struct snd_card *card = asihpi->card;
@@ -2548,7 +2548,7 @@ static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
    Mixer
  ------------------------------------------------------------*/
 
-static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
+static int snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 {
 	struct snd_card *card = asihpi->card;
 	unsigned int idx = 0;
@@ -2722,7 +2722,7 @@ snd_asihpi_proc_read(struct snd_info_entry *entry,
 	}
 }
 
-static void __devinit snd_asihpi_proc_init(struct snd_card_asihpi *asihpi)
+static void snd_asihpi_proc_init(struct snd_card_asihpi *asihpi)
 {
 	struct snd_info_entry *entry;
 
@@ -2764,7 +2764,7 @@ static int snd_asihpi_hpi_ioctl(struct snd_hwdep *hw, struct file *file,
 /* results in /dev/snd/hwC#D0 file for each card with index #
    also /proc/asound/hwdep will contain '#-00: asihpi (HPI) for each card'
 */
-static int __devinit snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi,
+static int snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi,
 	int device, struct snd_hwdep **rhwdep)
 {
 	struct snd_hwdep *hw;
@@ -2789,7 +2789,7 @@ static int __devinit snd_asihpi_hpi_new(struct snd_card_asihpi *asihpi,
 /*------------------------------------------------------------
    CARD
  ------------------------------------------------------------*/
-static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
+static int snd_asihpi_probe(struct pci_dev *pci_dev,
 				       const struct pci_device_id *pci_id)
 {
 	int err;
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 8f96749..842b94d 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -307,7 +307,7 @@ out:
 	return err;
 }
 
-int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
+int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	const struct pci_device_id *pci_id)
 {
 	int idx, nm;
diff --git a/sound/pci/asihpi/hpioctl.h b/sound/pci/asihpi/hpioctl.h
index 2614aff..f99baea 100644
--- a/sound/pci/asihpi/hpioctl.h
+++ b/sound/pci/asihpi/hpioctl.h
@@ -19,7 +19,7 @@
 Linux HPI ioctl, and shared module init functions
 *******************************************************************************/
 
-int __devinit asihpi_adapter_probe(struct pci_dev *pci_dev,
+int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	const struct pci_device_id *pci_id);
 void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev);
 void __init asihpi_init(void);
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index b281f2a..132c151 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -561,7 +561,7 @@ static int snd_atiixp_aclink_down(struct atiixp *chip)
 	     ATI_REG_ISR_CODEC2_NOT_READY)
 #define CODEC_CHECK_BITS (ALL_CODEC_NOT_READY|ATI_REG_ISR_NEW_FRAME)
 
-static int __devinit ac97_probing_bugs(struct pci_dev *pci)
+static int ac97_probing_bugs(struct pci_dev *pci)
 {
 	const struct snd_pci_quirk *q;
 
@@ -575,7 +575,7 @@ static int __devinit ac97_probing_bugs(struct pci_dev *pci)
 	return -1;
 }
 
-static int __devinit snd_atiixp_codec_detect(struct atiixp *chip)
+static int snd_atiixp_codec_detect(struct atiixp *chip)
 {
 	int timeout;
 
@@ -1247,7 +1247,7 @@ static struct atiixp_dma_ops snd_atiixp_spdif_dma_ops = {
 };
 	
 
-static int __devinit snd_atiixp_pcm_new(struct atiixp *chip)
+static int snd_atiixp_pcm_new(struct atiixp *chip)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_chmap *chmap;
@@ -1412,7 +1412,7 @@ static struct ac97_quirk ac97_quirks[] __devinitdata = {
 	{ } /* terminator */
 };
 
-static int __devinit snd_atiixp_mixer_new(struct atiixp *chip, int clock,
+static int snd_atiixp_mixer_new(struct atiixp *chip, int clock,
 					  const char *quirk_override)
 {
 	struct snd_ac97_bus *pbus;
@@ -1560,7 +1560,7 @@ static void snd_atiixp_proc_read(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "%02x: %08x\n", i, readl(chip->remap_addr + i));
 }
 
-static void __devinit snd_atiixp_proc_init(struct atiixp *chip)
+static void snd_atiixp_proc_init(struct atiixp *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1602,7 +1602,7 @@ static int snd_atiixp_dev_free(struct snd_device *device)
 /*
  * constructor for chip instance
  */
-static int __devinit snd_atiixp_create(struct snd_card *card,
+static int snd_atiixp_create(struct snd_card *card,
 				      struct pci_dev *pci,
 				      struct atiixp **r_chip)
 {
@@ -1661,7 +1661,7 @@ static int __devinit snd_atiixp_create(struct snd_card *card,
 }
 
 
-static int __devinit snd_atiixp_probe(struct pci_dev *pci,
+static int snd_atiixp_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 95b1cd2..5cb8928 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -988,7 +988,7 @@ static struct atiixp_dma_ops snd_atiixp_capture_dma_ops = {
 	.flush_dma = atiixp_in_flush_dma,
 };
 
-static int __devinit snd_atiixp_pcm_new(struct atiixp_modem *chip)
+static int snd_atiixp_pcm_new(struct atiixp_modem *chip)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1061,7 +1061,7 @@ static irqreturn_t snd_atiixp_interrupt(int irq, void *dev_id)
  * ac97 mixer section
  */
 
-static int __devinit snd_atiixp_mixer_new(struct atiixp_modem *chip, int clock)
+static int snd_atiixp_mixer_new(struct atiixp_modem *chip, int clock)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
@@ -1186,7 +1186,7 @@ static void snd_atiixp_proc_read(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "%02x: %08x\n", i, readl(chip->remap_addr + i));
 }
 
-static void __devinit snd_atiixp_proc_init(struct atiixp_modem *chip)
+static void snd_atiixp_proc_init(struct atiixp_modem *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1228,7 +1228,7 @@ static int snd_atiixp_dev_free(struct snd_device *device)
 /*
  * constructor for chip instance
  */
-static int __devinit snd_atiixp_create(struct snd_card *card,
+static int snd_atiixp_create(struct snd_card *card,
 				       struct pci_dev *pci,
 				       struct atiixp_modem **r_chip)
 {
@@ -1287,7 +1287,7 @@ static int __devinit snd_atiixp_create(struct snd_card *card,
 }
 
 
-static int __devinit snd_atiixp_probe(struct pci_dev *pci,
+static int snd_atiixp_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 1b24880..9cf669a 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -78,7 +78,7 @@ static void vortex_fix_agp_bridge(struct pci_dev *via)
 	}
 }
 
-static void __devinit snd_vortex_workaround(struct pci_dev *vortex, int fix)
+static void snd_vortex_workaround(struct pci_dev *vortex, int fix)
 {
 	struct pci_dev *via = NULL;
 
@@ -137,8 +137,7 @@ static int snd_vortex_dev_free(struct snd_device *device)
 
 // chip-specific constructor
 // (see "Management of Cards and Components")
-static int __devinit
-snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
+static int snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 {
 	vortex_t *chip;
 	int err;
@@ -234,8 +233,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 }
 
 // constructor -- see "Constructor" sub-section
-static int __devinit
-snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+static int snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index 9ae8b3b..a00faa0 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -594,7 +594,7 @@ static int Vort3DRend_Initialize(vortex_t * v, unsigned short mode)
 static int vortex_a3d_register_controls(vortex_t * vortex);
 static void vortex_a3d_unregister_controls(vortex_t * vortex);
 /* A3D base support init/shudown */
-static void __devinit vortex_Vort3D_enable(vortex_t * v)
+static void vortex_Vort3D_enable(vortex_t * v)
 {
 	int i;
 
@@ -855,7 +855,7 @@ static struct snd_kcontrol_new vortex_a3d_kcontrol __devinitdata = {
 };
 
 /* Control (un)registration. */
-static int __devinit vortex_a3d_register_controls(vortex_t * vortex)
+static int vortex_a3d_register_controls(vortex_t * vortex)
 {
 	struct snd_kcontrol *kcontrol;
 	int err, i;
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index 2698abf..a7855e2 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2680,7 +2680,7 @@ static void vortex_spdif_init(vortex_t * vortex, int spdif_sr, int spdif_mode)
 
 /* Initialization */
 
-static int __devinit vortex_core_init(vortex_t * vortex)
+static int vortex_core_init(vortex_t * vortex)
 {
 
 	printk(KERN_INFO "Vortex: init.... ");
diff --git a/sound/pci/au88x0/au88x0_eq.c b/sound/pci/au88x0/au88x0_eq.c
index 278ed81..0ddf004a 100644
--- a/sound/pci/au88x0/au88x0_eq.c
+++ b/sound/pci/au88x0/au88x0_eq.c
@@ -877,7 +877,7 @@ static char *EqBandLabels[10] __devinitdata = {
 };
 
 /* ALSA driver entry points. Init and exit. */
-static int __devinit vortex_eq_init(vortex_t * vortex)
+static int vortex_eq_init(vortex_t * vortex)
 {
 	struct snd_kcontrol *kcontrol;
 	int err, i;
diff --git a/sound/pci/au88x0/au88x0_game.c b/sound/pci/au88x0/au88x0_game.c
index 30a4567..984d015 100644
--- a/sound/pci/au88x0/au88x0_game.c
+++ b/sound/pci/au88x0/au88x0_game.c
@@ -92,7 +92,7 @@ static int vortex_game_open(struct gameport *gameport, int mode)
 	return 0;
 }
 
-static int __devinit vortex_gameport_register(vortex_t * vortex)
+static int vortex_gameport_register(vortex_t * vortex)
 {
 	struct gameport *gp;
 
diff --git a/sound/pci/au88x0/au88x0_mixer.c b/sound/pci/au88x0/au88x0_mixer.c
index fa13efb..965ea58 100644
--- a/sound/pci/au88x0/au88x0_mixer.c
+++ b/sound/pci/au88x0/au88x0_mixer.c
@@ -19,7 +19,7 @@ static int remove_ctl(struct snd_card *card, const char *name)
 	return snd_ctl_remove_id(card, &id);
 }
 
-static int __devinit snd_vortex_mixer(vortex_t * vortex)
+static int snd_vortex_mixer(vortex_t * vortex)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
diff --git a/sound/pci/au88x0/au88x0_mpu401.c b/sound/pci/au88x0/au88x0_mpu401.c
index e6c6a0f..e447719 100644
--- a/sound/pci/au88x0/au88x0_mpu401.c
+++ b/sound/pci/au88x0/au88x0_mpu401.c
@@ -41,7 +41,7 @@
 #define MPU401_ENTER_UART	0x3f
 #define MPU401_ACK		    0xfe
 
-static int __devinit snd_vortex_midi(vortex_t * vortex)
+static int snd_vortex_midi(vortex_t * vortex)
 {
 	struct snd_rawmidi *rmidi;
 	int temp, mode;
diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index b240502..c7d6b35 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -611,7 +611,7 @@ static struct snd_kcontrol_new snd_vortex_pcm_vol __devinitdata = {
 };
 
 /* create a pcm device */
-static int __devinit snd_vortex_new_pcm(vortex_t *chip, int idx, int nr)
+static int snd_vortex_new_pcm(vortex_t *chip, int idx, int nr)
 {
 	struct snd_pcm *pcm;
 	struct snd_kcontrol *kctl;
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 9a9b920..4189705 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -113,9 +113,9 @@ struct aw2 {
  * FUNCTION DECLARATIONS
  ********************************/
 static int snd_aw2_dev_free(struct snd_device *device);
-static int __devinit snd_aw2_create(struct snd_card *card,
+static int snd_aw2_create(struct snd_card *card,
 				    struct pci_dev *pci, struct aw2 **rchip);
-static int __devinit snd_aw2_probe(struct pci_dev *pci,
+static int snd_aw2_probe(struct pci_dev *pci,
 				   const struct pci_device_id *pci_id);
 static void __devexit snd_aw2_remove(struct pci_dev *pci);
 static int snd_aw2_pcm_playback_open(struct snd_pcm_substream *substream);
@@ -135,7 +135,7 @@ static snd_pcm_uframes_t snd_aw2_pcm_pointer_playback(struct snd_pcm_substream
 						      *substream);
 static snd_pcm_uframes_t snd_aw2_pcm_pointer_capture(struct snd_pcm_substream
 						     *substream);
-static int __devinit snd_aw2_new_pcm(struct aw2 *chip);
+static int snd_aw2_new_pcm(struct aw2 *chip);
 
 static int snd_aw2_control_switch_capture_info(struct snd_kcontrol *kcontrol,
 					       struct snd_ctl_elem_info *uinfo);
@@ -242,7 +242,7 @@ static int snd_aw2_dev_free(struct snd_device *device)
 }
 
 /* chip-specific constructor */
-static int __devinit snd_aw2_create(struct snd_card *card,
+static int snd_aw2_create(struct snd_card *card,
 				    struct pci_dev *pci, struct aw2 **rchip)
 {
 	struct aw2 *chip;
@@ -332,7 +332,7 @@ static int __devinit snd_aw2_create(struct snd_card *card,
 }
 
 /* constructor */
-static int __devinit snd_aw2_probe(struct pci_dev *pci,
+static int snd_aw2_probe(struct pci_dev *pci,
 				   const struct pci_device_id *pci_id)
 {
 	static int dev;
@@ -591,7 +591,7 @@ static snd_pcm_uframes_t snd_aw2_pcm_pointer_capture(struct snd_pcm_substream
 }
 
 /* create a pcm device */
-static int __devinit snd_aw2_new_pcm(struct aw2 *chip)
+static int snd_aw2_new_pcm(struct aw2 *chip)
 {
 	struct snd_pcm *pcm_playback_ana;
 	struct snd_pcm *pcm_playback_num;
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 8a48a69..5e4031b 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -817,8 +817,7 @@ snd_azf3328_mixer_ac97_write(struct snd_ac97 *ac97,
 		snd_azf3328_mixer_ac97_map_unsupported(reg_ac97, "write");
 }
 
-static int __devinit
-snd_azf3328_mixer_new(struct snd_azf3328 *chip)
+static int snd_azf3328_mixer_new(struct snd_azf3328 *chip)
 {
 	struct snd_ac97_bus *bus;
 	struct snd_ac97_template ac97;
@@ -1245,8 +1244,7 @@ static u16 __devinitdata snd_azf3328_init_values[][2] = {
         { IDX_MIXER_REC_VOLUME,		MIXER_MUTE_MASK|0x0707 },
 };
 
-static int __devinit
-snd_azf3328_mixer_new(struct snd_azf3328 *chip)
+static int snd_azf3328_mixer_new(struct snd_azf3328 *chip)
 {
 	struct snd_card *card;
 	const struct snd_kcontrol_new *sw;
@@ -1899,8 +1897,7 @@ snd_azf3328_gameport_cooked_read(struct gameport *gameport,
 	return 0;
 }
 
-static int __devinit
-snd_azf3328_gameport(struct snd_azf3328 *chip, int dev)
+static int snd_azf3328_gameport(struct snd_azf3328 *chip, int dev)
 {
 	struct gameport *gp;
 
@@ -2212,8 +2209,7 @@ static struct snd_pcm_ops snd_azf3328_i2s_out_ops = {
 	.pointer =	snd_azf3328_pcm_pointer
 };
 
-static int __devinit
-snd_azf3328_pcm(struct snd_azf3328 *chip)
+static int snd_azf3328_pcm(struct snd_azf3328 *chip)
 {
 enum { AZF_PCMDEV_STD, AZF_PCMDEV_I2S_OUT, NUM_AZF_PCMDEVS }; /* pcm devices */
 
@@ -2344,8 +2340,7 @@ static struct snd_timer_hardware snd_azf3328_timer_hw = {
 	.precise_resolution = snd_azf3328_timer_precise_resolution,
 };
 
-static int __devinit
-snd_azf3328_timer(struct snd_azf3328 *chip, int device)
+static int snd_azf3328_timer(struct snd_azf3328 *chip, int device)
 {
 	struct snd_timer *timer = NULL;
 	struct snd_timer_id tid;
@@ -2489,8 +2484,7 @@ snd_azf3328_debug_show_ports(const struct snd_azf3328 *chip)
 #endif /* DEBUG_MISC */
 }
 
-static int __devinit
-snd_azf3328_create(struct snd_card *card,
+static int snd_azf3328_create(struct snd_card *card,
 		   struct pci_dev *pci,
 		   unsigned long device_type,
 		   struct snd_azf3328 **rchip)
@@ -2615,8 +2609,7 @@ out:
 	return err;
 }
 
-static int __devinit
-snd_azf3328_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+static int snd_azf3328_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index a0ee0c7..6cfb4ee 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -696,7 +696,7 @@ static int snd_bt87x_dev_free(struct snd_device *device)
 	return snd_bt87x_free(chip);
 }
 
-static int __devinit snd_bt87x_pcm(struct snd_bt87x *chip, int device, char *name)
+static int snd_bt87x_pcm(struct snd_bt87x *chip, int device, char *name)
 {
 	int err;
 	struct snd_pcm *pcm;
@@ -714,7 +714,7 @@ static int __devinit snd_bt87x_pcm(struct snd_bt87x *chip, int device, char *nam
 							ALIGN(255 * 4092, 1024));
 }
 
-static int __devinit snd_bt87x_create(struct snd_card *card,
+static int snd_bt87x_create(struct snd_card *card,
 				      struct pci_dev *pci,
 				      struct snd_bt87x **rchip)
 {
@@ -837,7 +837,7 @@ static struct {
 };
 
 /* return the id of the card, or a negative value if it's blacklisted */
-static int __devinit snd_bt87x_detect_card(struct pci_dev *pci)
+static int snd_bt87x_detect_card(struct pci_dev *pci)
 {
 	int i;
 	const struct pci_device_id *supported;
@@ -862,7 +862,7 @@ static int __devinit snd_bt87x_detect_card(struct pci_dev *pci)
 	return SND_BT87X_BOARD_UNKNOWN;
 }
 
-static int __devinit snd_bt87x_probe(struct pci_dev *pci,
+static int snd_bt87x_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 030c846..f827687 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1352,7 +1352,7 @@ static const struct snd_pcm_chmap_elem side_map[] = {
 	{ }
 };
 
-static int __devinit snd_ca0106_pcm(struct snd_ca0106 *emu, int device)
+static int snd_ca0106_pcm(struct snd_ca0106 *emu, int device)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
@@ -1650,7 +1650,7 @@ static void ca0106_stop_chip(struct snd_ca0106 *chip)
 	 */
 }
 
-static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
+static int snd_ca0106_create(int dev, struct snd_card *card,
 					 struct pci_dev *pci,
 					 struct snd_ca0106 **rchip)
 {
@@ -1777,7 +1777,7 @@ static int ca0106_dev_id_port(void *dev_id)
 	return ((struct snd_ca0106 *)dev_id)->port;
 }
 
-static int __devinit snd_ca0106_midi(struct snd_ca0106 *chip, unsigned int channel)
+static int snd_ca0106_midi(struct snd_ca0106 *chip, unsigned int channel)
 {
 	struct snd_ca_midi *midi;
 	char *name;
@@ -1828,7 +1828,7 @@ static int __devinit snd_ca0106_midi(struct snd_ca0106 *chip, unsigned int chann
 }
 
 
-static int __devinit snd_ca0106_probe(struct pci_dev *pci,
+static int snd_ca0106_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 68eacf7..2d040ef 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -691,8 +691,7 @@ static const int spi_dmute_bit[] = {
 	SPI_DMUTE4_BIT,
 };
 
-static struct snd_kcontrol_new __devinit
-snd_ca0106_volume_spi_dac_ctl(struct snd_ca0106_details *details,
+static struct snd_kcontrol_new snd_ca0106_volume_spi_dac_ctl(struct snd_ca0106_details *details,
 			      int channel_id)
 {
 	struct snd_kcontrol_new spi_switch = {0};
@@ -735,7 +734,7 @@ snd_ca0106_volume_spi_dac_ctl(struct snd_ca0106_details *details,
 	return spi_switch;
 }
 
-static int __devinit remove_ctl(struct snd_card *card, const char *name)
+static int remove_ctl(struct snd_card *card, const char *name)
 {
 	struct snd_ctl_elem_id id;
 	memset(&id, 0, sizeof(id));
@@ -744,7 +743,7 @@ static int __devinit remove_ctl(struct snd_card *card, const char *name)
 	return snd_ctl_remove_id(card, &id);
 }
 
-static struct snd_kcontrol __devinit *ctl_find(struct snd_card *card, const char *name)
+static struct snd_kcontrol *ctl_find(struct snd_card *card, const char *name)
 {
 	struct snd_ctl_elem_id sid;
 	memset(&sid, 0, sizeof(sid));
@@ -754,7 +753,7 @@ static struct snd_kcontrol __devinit *ctl_find(struct snd_card *card, const char
 	return snd_ctl_find_id(card, &sid);
 }
 
-static int __devinit rename_ctl(struct snd_card *card, const char *src, const char *dst)
+static int rename_ctl(struct snd_card *card, const char *src, const char *dst)
 {
 	struct snd_kcontrol *kctl = ctl_find(card, src);
 	if (kctl) {
@@ -799,7 +798,7 @@ static char *slave_sws[] __devinitdata = {
 	NULL
 };
 
-static void __devinit add_slaves(struct snd_card *card,
+static void add_slaves(struct snd_card *card,
 				 struct snd_kcontrol *master, char **list)
 {
 	for (; *list; list++) {
@@ -809,7 +808,7 @@ static void __devinit add_slaves(struct snd_card *card,
 	}
 }
 
-int __devinit snd_ca0106_mixer(struct snd_ca0106 *emu)
+int snd_ca0106_mixer(struct snd_ca0106 *emu)
 {
 	int err;
         struct snd_card *card = emu->card;
diff --git a/sound/pci/ca0106/ca0106_proc.c b/sound/pci/ca0106/ca0106_proc.c
index c694464..9fa037d 100644
--- a/sound/pci/ca0106/ca0106_proc.c
+++ b/sound/pci/ca0106/ca0106_proc.c
@@ -424,7 +424,7 @@ static void snd_ca0106_proc_i2c_write(struct snd_info_entry *entry,
         }
 }
 
-int __devinit snd_ca0106_proc_init(struct snd_ca0106 * emu)
+int snd_ca0106_proc_init(struct snd_ca0106 * emu)
 {
 	struct snd_info_entry *entry;
 	
diff --git a/sound/pci/ca0106/ca_midi.c b/sound/pci/ca0106/ca_midi.c
index c788511..8bbdf26 100644
--- a/sound/pci/ca0106/ca_midi.c
+++ b/sound/pci/ca0106/ca_midi.c
@@ -286,7 +286,7 @@ static void ca_rmidi_free(struct snd_rawmidi *rmidi)
 	ca_midi_free(rmidi->private_data);
 }
 
-int __devinit ca_midi_init(void *dev_id, struct snd_ca_midi *midi, int device, char *name)
+int ca_midi_init(void *dev_id, struct snd_ca_midi *midi, int device, char *name)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 2a69cc3..86ca0ab 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -1897,7 +1897,7 @@ static struct snd_pcm_ops snd_cmipci_capture_spdif_ops = {
 /*
  */
 
-static int __devinit snd_cmipci_pcm_new(struct cmipci *cm, int device)
+static int snd_cmipci_pcm_new(struct cmipci *cm, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1920,7 +1920,7 @@ static int __devinit snd_cmipci_pcm_new(struct cmipci *cm, int device)
 	return 0;
 }
 
-static int __devinit snd_cmipci_pcm2_new(struct cmipci *cm, int device)
+static int snd_cmipci_pcm2_new(struct cmipci *cm, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1942,7 +1942,7 @@ static int __devinit snd_cmipci_pcm2_new(struct cmipci *cm, int device)
 	return 0;
 }
 
-static int __devinit snd_cmipci_pcm_spdif_new(struct cmipci *cm, int device)
+static int snd_cmipci_pcm_spdif_new(struct cmipci *cm, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -2663,7 +2663,7 @@ static struct snd_kcontrol_new snd_cmipci_modem_switch __devinitdata =
 DEFINE_CARD_SWITCH("Modem", modem);
 
 
-static int __devinit snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
+static int snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
 {
 	struct snd_card *card;
 	struct snd_kcontrol_new *sw;
@@ -2791,7 +2791,7 @@ static void snd_cmipci_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "\n");
 }
 
-static void __devinit snd_cmipci_proc_init(struct cmipci *cm)
+static void snd_cmipci_proc_init(struct cmipci *cm)
 {
 	struct snd_info_entry *entry;
 
@@ -2817,7 +2817,7 @@ static DEFINE_PCI_DEVICE_TABLE(snd_cmipci_ids) = {
  * check chip version and capabilities
  * driver name is modified according to the chip model
  */
-static void __devinit query_chip(struct cmipci *cm)
+static void query_chip(struct cmipci *cm)
 {
 	unsigned int detect;
 
@@ -2866,7 +2866,7 @@ static void __devinit query_chip(struct cmipci *cm)
 }
 
 #ifdef SUPPORT_JOYSTICK
-static int __devinit snd_cmipci_create_gameport(struct cmipci *cm, int dev)
+static int snd_cmipci_create_gameport(struct cmipci *cm, int dev)
 {
 	static int ports[] = { 0x201, 0x200, 0 }; /* FIXME: majority is 0x201? */
 	struct gameport *gp;
@@ -2959,7 +2959,7 @@ static int snd_cmipci_dev_free(struct snd_device *device)
 	return snd_cmipci_free(cm);
 }
 
-static int __devinit snd_cmipci_create_fm(struct cmipci *cm, long fm_port)
+static int snd_cmipci_create_fm(struct cmipci *cm, long fm_port)
 {
 	long iosynth;
 	unsigned int val;
@@ -3012,7 +3012,7 @@ static int __devinit snd_cmipci_create_fm(struct cmipci *cm, long fm_port)
 	return 0;
 }
 
-static int __devinit snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
+static int snd_cmipci_create(struct snd_card *card, struct pci_dev *pci,
 				       int dev, struct cmipci **rcmipci)
 {
 	struct cmipci *cm;
@@ -3265,7 +3265,7 @@ static int __devinit snd_cmipci_create(struct snd_card *card, struct pci_dev *pc
 
 MODULE_DEVICE_TABLE(pci, snd_cmipci_ids);
 
-static int __devinit snd_cmipci_probe(struct pci_dev *pci,
+static int snd_cmipci_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 0ecf782..5431c6d 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -969,7 +969,7 @@ static struct snd_pcm_ops snd_cs4281_capture_ops = {
 	.pointer =	snd_cs4281_pointer,
 };
 
-static int __devinit snd_cs4281_pcm(struct cs4281 * chip, int device,
+static int snd_cs4281_pcm(struct cs4281 * chip, int device,
 				    struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
@@ -1093,7 +1093,7 @@ static void snd_cs4281_mixer_free_ac97(struct snd_ac97 *ac97)
 		chip->ac97 = NULL;
 }
 
-static int __devinit snd_cs4281_mixer(struct cs4281 * chip)
+static int snd_cs4281_mixer(struct cs4281 * chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ac97_template ac97;
@@ -1171,7 +1171,7 @@ static struct snd_info_entry_ops snd_cs4281_proc_ops_BA1 = {
 	.read = snd_cs4281_BA1_read,
 };
 
-static void __devinit snd_cs4281_proc_init(struct cs4281 * chip)
+static void snd_cs4281_proc_init(struct cs4281 * chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1259,7 +1259,7 @@ static int snd_cs4281_gameport_open(struct gameport *gameport, int mode)
 	return 0;
 }
 
-static int __devinit snd_cs4281_create_gameport(struct cs4281 *chip)
+static int snd_cs4281_create_gameport(struct cs4281 *chip)
 {
 	struct gameport *gp;
 
@@ -1335,7 +1335,7 @@ static int snd_cs4281_dev_free(struct snd_device *device)
 
 static int snd_cs4281_chip_init(struct cs4281 *chip); /* defined below */
 
-static int __devinit snd_cs4281_create(struct snd_card *card,
+static int snd_cs4281_create(struct snd_card *card,
 				       struct pci_dev *pci,
 				       struct cs4281 ** rchip,
 				       int dual_codec)
@@ -1779,7 +1779,7 @@ static struct snd_rawmidi_ops snd_cs4281_midi_input =
 	.trigger =	snd_cs4281_midi_input_trigger,
 };
 
-static int __devinit snd_cs4281_midi(struct cs4281 * chip, int device,
+static int snd_cs4281_midi(struct cs4281 * chip, int device,
 				     struct snd_rawmidi **rrawmidi)
 {
 	struct snd_rawmidi *rmidi;
@@ -1901,7 +1901,7 @@ static void snd_cs4281_opl3_command(struct snd_opl3 *opl3, unsigned short cmd,
 	spin_unlock_irqrestore(&opl3->reg_lock, flags);
 }
 
-static int __devinit snd_cs4281_probe(struct pci_dev *pci,
+static int snd_cs4281_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index e47fb8b..74a43b0 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -73,7 +73,7 @@ static DEFINE_PCI_DEVICE_TABLE(snd_cs46xx_ids) = {
 
 MODULE_DEVICE_TABLE(pci, snd_cs46xx_ids);
 
-static int __devinit snd_card_cs46xx_probe(struct pci_dev *pci,
+static int snd_card_cs46xx_probe(struct pci_dev *pci,
 					   const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index a2bb8c9..c43feb0 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1590,7 +1590,7 @@ static struct snd_pcm_ops snd_cs46xx_capture_indirect_ops = {
 #define MAX_PLAYBACK_CHANNELS	1
 #endif
 
-int __devinit snd_cs46xx_pcm(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
+int snd_cs46xx_pcm(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1621,7 +1621,7 @@ int __devinit snd_cs46xx_pcm(struct snd_cs46xx *chip, int device, struct snd_pcm
 
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-int __devinit snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
+int snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1650,7 +1650,7 @@ int __devinit snd_cs46xx_pcm_rear(struct snd_cs46xx *chip, int device, struct sn
 	return 0;
 }
 
-int __devinit snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
+int snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1679,7 +1679,7 @@ int __devinit snd_cs46xx_pcm_center_lfe(struct snd_cs46xx *chip, int device, str
 	return 0;
 }
 
-int __devinit snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
+int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -2278,7 +2278,7 @@ static void snd_cs46xx_codec_reset (struct snd_ac97 * ac97)
 }
 #endif
 
-static int __devinit cs46xx_detect_codec(struct snd_cs46xx *chip, int codec)
+static int cs46xx_detect_codec(struct snd_cs46xx *chip, int codec)
 {
 	int idx, err;
 	struct snd_ac97_template ac97;
@@ -2311,7 +2311,7 @@ static int __devinit cs46xx_detect_codec(struct snd_cs46xx *chip, int codec)
 	return -ENXIO;
 }
 
-int __devinit snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
+int snd_cs46xx_mixer(struct snd_cs46xx *chip, int spdif_device)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id;
@@ -2531,7 +2531,7 @@ static struct snd_rawmidi_ops snd_cs46xx_midi_input =
 	.trigger =	snd_cs46xx_midi_input_trigger,
 };
 
-int __devinit snd_cs46xx_midi(struct snd_cs46xx *chip, int device, struct snd_rawmidi **rrawmidi)
+int snd_cs46xx_midi(struct snd_cs46xx *chip, int device, struct snd_rawmidi **rrawmidi)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
@@ -2613,7 +2613,7 @@ static int snd_cs46xx_gameport_open(struct gameport *gameport, int mode)
 	return 0;
 }
 
-int __devinit snd_cs46xx_gameport(struct snd_cs46xx *chip)
+int snd_cs46xx_gameport(struct snd_cs46xx *chip)
 {
 	struct gameport *gp;
 
@@ -2649,7 +2649,7 @@ static inline void snd_cs46xx_remove_gameport(struct snd_cs46xx *chip)
 	}
 }
 #else
-int __devinit snd_cs46xx_gameport(struct snd_cs46xx *chip) { return -ENOSYS; }
+int snd_cs46xx_gameport(struct snd_cs46xx *chip) { return -ENOSYS; }
 static inline void snd_cs46xx_remove_gameport(struct snd_cs46xx *chip) { }
 #endif /* CONFIG_GAMEPORT */
 
@@ -2674,7 +2674,7 @@ static struct snd_info_entry_ops snd_cs46xx_proc_io_ops = {
 	.read = snd_cs46xx_io_read,
 };
 
-static int __devinit snd_cs46xx_proc_init(struct snd_card *card, struct snd_cs46xx *chip)
+static int snd_cs46xx_proc_init(struct snd_card *card, struct snd_cs46xx *chip)
 {
 	struct snd_info_entry *entry;
 	int idx;
@@ -3061,7 +3061,7 @@ static void cs46xx_enable_stream_irqs(struct snd_cs46xx *chip)
 	snd_cs46xx_poke(chip, BA1_CIE, tmp);	/* capture interrupt enable */
 }
 
-int __devinit snd_cs46xx_start_dsp(struct snd_cs46xx *chip)
+int snd_cs46xx_start_dsp(struct snd_cs46xx *chip)
 {	
 	unsigned int tmp;
 	/*
@@ -3717,7 +3717,7 @@ SIMPLE_DEV_PM_OPS(snd_cs46xx_pm, snd_cs46xx_suspend, snd_cs46xx_resume);
 /*
  */
 
-int __devinit snd_cs46xx_create(struct snd_card *card,
+int snd_cs46xx_create(struct snd_card *card,
 		      struct pci_dev * pci,
 		      int external_amp, int thinkpad,
 		      struct snd_cs46xx ** rchip)
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index ed68917..94aee6e 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -94,7 +94,7 @@ static void __devexit snd_cs5530_remove(struct pci_dev *pci)
 	pci_set_drvdata(pci, NULL);
 }
 
-static u8 __devinit snd_cs5530_mixer_read(unsigned long io, u8 reg)
+static u8 snd_cs5530_mixer_read(unsigned long io, u8 reg)
 {
 	outb(reg, io + 4);
 	udelay(20);
@@ -103,7 +103,7 @@ static u8 __devinit snd_cs5530_mixer_read(unsigned long io, u8 reg)
 	return reg;
 }
 
-static int __devinit snd_cs5530_create(struct snd_card *card,
+static int snd_cs5530_create(struct snd_card *card,
 				       struct pci_dev *pci,
 				       struct snd_cs5530 **rchip)
 {
@@ -250,7 +250,7 @@ static int __devinit snd_cs5530_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit snd_cs5530_probe(struct pci_dev *pci,
+static int snd_cs5530_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index b3f25e4..fa953e2 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -144,7 +144,7 @@ static unsigned short snd_cs5535audio_ac97_codec_read(struct snd_ac97 *ac97,
 	return snd_cs5535audio_codec_read(cs5535au, reg);
 }
 
-static int __devinit snd_cs5535audio_mixer(struct cs5535audio *cs5535au)
+static int snd_cs5535audio_mixer(struct cs5535audio *cs5535au)
 {
 	struct snd_card *card = cs5535au->card;
 	struct snd_ac97_bus *pbus;
@@ -270,7 +270,7 @@ static int snd_cs5535audio_dev_free(struct snd_device *device)
 	return snd_cs5535audio_free(cs5535au);
 }
 
-static int __devinit snd_cs5535audio_create(struct snd_card *card,
+static int snd_cs5535audio_create(struct snd_card *card,
 					    struct pci_dev *pci,
 					    struct cs5535audio **rcs5535au)
 {
@@ -338,7 +338,7 @@ pcifail:
 	return err;
 }
 
-static int __devinit snd_cs5535audio_probe(struct pci_dev *pci,
+static int snd_cs5535audio_probe(struct pci_dev *pci,
 					   const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/cs5535audio/cs5535audio.h b/sound/pci/cs5535audio/cs5535audio.h
index bb3cc64..536a6bb 100644
--- a/sound/pci/cs5535audio/cs5535audio.h
+++ b/sound/pci/cs5535audio/cs5535audio.h
@@ -97,9 +97,9 @@ struct cs5535audio {
 extern const struct dev_pm_ops snd_cs5535audio_pm;
 
 #ifdef CONFIG_OLPC
-void __devinit olpc_prequirks(struct snd_card *card,
+void olpc_prequirks(struct snd_card *card,
 		struct snd_ac97_template *ac97);
-int __devinit olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97);
+int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97);
 void __devexit olpc_quirks_cleanup(void);
 void olpc_analog_input(struct snd_ac97 *ac97, int on);
 void olpc_mic_bias(struct snd_ac97 *ac97, int on);
@@ -133,7 +133,7 @@ static inline void olpc_capture_open(struct snd_ac97 *ac97) { }
 static inline void olpc_capture_close(struct snd_ac97 *ac97) { }
 #endif
 
-int __devinit snd_cs5535audio_pcm(struct cs5535audio *cs5535audio);
+int snd_cs5535audio_pcm(struct cs5535audio *cs5535audio);
 
 #endif /* __SOUND_CS5535AUDIO_H */
 
diff --git a/sound/pci/cs5535audio/cs5535audio_olpc.c b/sound/pci/cs5535audio/cs5535audio_olpc.c
index 50da49b..149e21e 100644
--- a/sound/pci/cs5535audio/cs5535audio_olpc.c
+++ b/sound/pci/cs5535audio/cs5535audio_olpc.c
@@ -133,7 +133,7 @@ static struct snd_kcontrol_new olpc_cs5535audio_ctls[] __devinitdata = {
 },
 };
 
-void __devinit olpc_prequirks(struct snd_card *card,
+void olpc_prequirks(struct snd_card *card,
 		struct snd_ac97_template *ac97)
 {
 	if (!machine_is_olpc())
@@ -144,7 +144,7 @@ void __devinit olpc_prequirks(struct snd_card *card,
 		ac97->scaps |= AC97_SCAP_INV_EAPD;
 }
 
-int __devinit olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
+int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
 {
 	struct snd_ctl_elem_id elem;
 	int i, err;
diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index dbf94b1..9ab01a7 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -422,7 +422,7 @@ static struct cs5535audio_dma_ops snd_cs5535audio_capture_dma_ops = {
         .read_dma_pntr = cs5535audio_capture_read_dma_pntr,
 };
 
-int __devinit snd_cs5535audio_pcm(struct cs5535audio *cs5535au)
+int snd_cs5535audio_pcm(struct cs5535audio *cs5535au)
 {
 	struct snd_pcm *pcm;
 	int err;
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index a2f997a..92054e7 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1249,7 +1249,7 @@ static int atc_dev_free(struct snd_device *dev)
 	return ct_atc_destroy(atc);
 }
 
-static int __devinit atc_identify_card(struct ct_atc *atc, unsigned int ssid)
+static int atc_identify_card(struct ct_atc *atc, unsigned int ssid)
 {
 	const struct snd_pci_quirk *p;
 	const struct snd_pci_quirk *list;
@@ -1296,7 +1296,7 @@ static int __devinit atc_identify_card(struct ct_atc *atc, unsigned int ssid)
 	return 0;
 }
 
-int __devinit ct_atc_create_alsa_devs(struct ct_atc *atc)
+int ct_atc_create_alsa_devs(struct ct_atc *atc)
 {
 	enum CTALSADEVS i;
 	int err;
@@ -1319,7 +1319,7 @@ int __devinit ct_atc_create_alsa_devs(struct ct_atc *atc)
 	return 0;
 }
 
-static int __devinit atc_create_hw_devs(struct ct_atc *atc)
+static int atc_create_hw_devs(struct ct_atc *atc)
 {
 	struct hw *hw;
 	struct card_conf info = {0};
@@ -1665,7 +1665,7 @@ static struct ct_atc atc_preset __devinitdata = {
  *  Returns 0 if succeeds, or negative error code if fails.
  */
 
-int __devinit ct_atc_create(struct snd_card *card, struct pci_dev *pci,
+int ct_atc_create(struct snd_card *card, struct pci_dev *pci,
 			    unsigned int rsr, unsigned int msr,
 			    int chip_type, unsigned int ssid,
 			    struct ct_atc **ratc)
diff --git a/sound/pci/ctxfi/ctatc.h b/sound/pci/ctxfi/ctatc.h
index 69b51f9..490206b 100644
--- a/sound/pci/ctxfi/ctatc.h
+++ b/sound/pci/ctxfi/ctatc.h
@@ -152,9 +152,9 @@ struct ct_atc {
 };
 
 
-int __devinit ct_atc_create(struct snd_card *card, struct pci_dev *pci,
+int ct_atc_create(struct snd_card *card, struct pci_dev *pci,
 			    unsigned int rsr, unsigned int msr, int chip_type,
 			    unsigned int subsysid, struct ct_atc **ratc);
-int __devinit ct_atc_create_alsa_devs(struct ct_atc *atc);
+int ct_atc_create_alsa_devs(struct ct_atc *atc);
 
 #endif /* CTATC_H */
diff --git a/sound/pci/ctxfi/cthardware.c b/sound/pci/ctxfi/cthardware.c
index 8e64f48..e1c854a 100644
--- a/sound/pci/ctxfi/cthardware.c
+++ b/sound/pci/ctxfi/cthardware.c
@@ -20,7 +20,7 @@
 #include "cthw20k2.h"
 #include <linux/bug.h>
 
-int __devinit create_hw_obj(struct pci_dev *pci, enum CHIPTYP chip_type,
+int create_hw_obj(struct pci_dev *pci, enum CHIPTYP chip_type,
 			    enum CTCARDS model, struct hw **rhw)
 {
 	int err;
diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 4507f70..65a0169 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -2275,7 +2275,7 @@ static struct hw ct20k1_preset __devinitdata = {
 	.get_wc = get_wc,
 };
 
-int __devinit create_20k1_hw_obj(struct hw **rhw)
+int create_20k1_hw_obj(struct hw **rhw)
 {
 	struct hw20k1 *hw20k1;
 
diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index b9c9349..3f2a3ad 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -2345,7 +2345,7 @@ static struct hw ct20k2_preset __devinitdata = {
 	.get_wc = get_wc,
 };
 
-int __devinit create_20k2_hw_obj(struct hw **rhw)
+int create_20k2_hw_obj(struct hw **rhw)
 {
 	struct hw20k2 *hw20k2;
 
diff --git a/sound/pci/ctxfi/xfi.c b/sound/pci/ctxfi/xfi.c
index f5a311c..8275ac3 100644
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -56,8 +56,7 @@ static DEFINE_PCI_DEVICE_TABLE(ct_pci_dev_ids) = {
 };
 MODULE_DEVICE_TABLE(pci, ct_pci_dev_ids);
 
-static int __devinit
-ct_card_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+static int ct_card_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index d9181bd..3ba1585 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -907,7 +907,7 @@ static int snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *dev)
 
 
 /*<--snd_echo_probe() */
-static int __devinit snd_echo_new_pcm(struct echoaudio *chip)
+static int snd_echo_new_pcm(struct echoaudio *chip)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1940,7 +1940,7 @@ static int snd_echo_dev_free(struct snd_device *device)
 
 
 /* <--snd_echo_probe() */
-static __devinit int snd_echo_create(struct snd_card *card,
+static int snd_echo_create(struct snd_card *card,
 				     struct pci_dev *pci,
 				     struct echoaudio **rchip)
 {
@@ -2040,7 +2040,7 @@ static __devinit int snd_echo_create(struct snd_card *card,
 
 
 /* constructor */
-static int __devinit snd_echo_probe(struct pci_dev *pci,
+static int snd_echo_probe(struct pci_dev *pci,
 				    const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/echoaudio/echoaudio.h b/sound/pci/echoaudio/echoaudio.h
index e158369..8e55b8e 100644
--- a/sound/pci/echoaudio/echoaudio.h
+++ b/sound/pci/echoaudio/echoaudio.h
@@ -475,7 +475,7 @@ static int enable_midi_input(struct echoaudio *chip, char enable);
 static void snd_echo_midi_output_trigger(
 			struct snd_rawmidi_substream *substream, int up);
 static int midi_service_irq(struct echoaudio *chip);
-static int __devinit snd_echo_midi_create(struct snd_card *card,
+static int snd_echo_midi_create(struct snd_card *card,
 					  struct echoaudio *chip);
 #endif
 
diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index a953d14..e87265f 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -307,7 +307,7 @@ static struct snd_rawmidi_ops snd_echo_midi_output = {
 
 
 /* <--snd_echo_probe() */
-static int __devinit snd_echo_midi_create(struct snd_card *card,
+static int snd_echo_midi_create(struct snd_card *card,
 					  struct echoaudio *chip)
 {
 	int err;
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 6e3cbb3..77b316d 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -99,7 +99,7 @@ static DEFINE_PCI_DEVICE_TABLE(snd_emu10k1_ids) = {
 
 MODULE_DEVICE_TABLE(pci, snd_emu10k1_ids);
 
-static int __devinit snd_card_emu10k1_probe(struct pci_dev *pci,
+static int snd_card_emu10k1_probe(struct pci_dev *pci,
 					    const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index c21adb6..09dcc1f 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1738,7 +1738,7 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	{ } /* terminator */
 };
 
-int __devinit snd_emu10k1_create(struct snd_card *card,
+int snd_emu10k1_create(struct snd_card *card,
 		       struct pci_dev *pci,
 		       unsigned short extin_mask,
 		       unsigned short extout_mask,
@@ -2025,7 +2025,7 @@ static unsigned char saved_regs_audigy[] = {
 	0xff /* end */
 };
 
-static int __devinit alloc_pm_buffer(struct snd_emu10k1 *emu)
+static int alloc_pm_buffer(struct snd_emu10k1 *emu)
 {
 	int size;
 
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index f2c0620..45c7acb 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -842,7 +842,7 @@ static const struct snd_pcm_chmap_elem clfe_map[] = {
 	{ }
 };
 
-static int __devinit snd_emu10k1x_pcm(struct emu10k1x *emu, int device, struct snd_pcm **rpcm)
+static int snd_emu10k1x_pcm(struct emu10k1x *emu, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	const struct snd_pcm_chmap_elem *map = NULL;
@@ -902,7 +902,7 @@ static int __devinit snd_emu10k1x_pcm(struct emu10k1x *emu, int device, struct s
 	return 0;
 }
 
-static int __devinit snd_emu10k1x_create(struct snd_card *card,
+static int snd_emu10k1x_create(struct snd_card *card,
 					 struct pci_dev *pci,
 					 struct emu10k1x **rchip)
 {
@@ -1066,7 +1066,7 @@ static void snd_emu10k1x_proc_reg_write(struct snd_info_entry *entry,
 	}
 }
 
-static int __devinit snd_emu10k1x_proc_init(struct emu10k1x * emu)
+static int snd_emu10k1x_proc_init(struct emu10k1x * emu)
 {
 	struct snd_info_entry *entry;
 	
@@ -1194,7 +1194,7 @@ static struct snd_kcontrol_new snd_emu10k1x_spdif_control =
 	.put =          snd_emu10k1x_spdif_put
 };
 
-static int __devinit snd_emu10k1x_mixer(struct emu10k1x *emu)
+static int snd_emu10k1x_mixer(struct emu10k1x *emu)
 {
 	int err;
 	struct snd_kcontrol *kctl;
@@ -1507,7 +1507,7 @@ static void snd_emu10k1x_midi_free(struct snd_rawmidi *rmidi)
 	midi->rmidi = NULL;
 }
 
-static int __devinit emu10k1x_midi_init(struct emu10k1x *emu,
+static int emu10k1x_midi_init(struct emu10k1x *emu,
 					struct emu10k1x_midi *midi, int device, char *name)
 {
 	struct snd_rawmidi *rmidi;
@@ -1531,7 +1531,7 @@ static int __devinit emu10k1x_midi_init(struct emu10k1x *emu,
 	return 0;
 }
 
-static int __devinit snd_emu10k1x_midi(struct emu10k1x *emu)
+static int snd_emu10k1x_midi(struct emu10k1x *emu)
 {
 	struct emu10k1x_midi *midi = &emu->midi;
 	int err;
@@ -1548,7 +1548,7 @@ static int __devinit snd_emu10k1x_midi(struct emu10k1x *emu)
 	return 0;
 }
 
-static int __devinit snd_emu10k1x_probe(struct pci_dev *pci,
+static int snd_emu10k1x_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 5241995..a9ad7fb 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1073,8 +1073,7 @@ static int snd_emu10k1_ipcm_peek(struct snd_emu10k1 *emu,
 #define SND_EMU10K1_PLAYBACK_CHANNELS	8
 #define SND_EMU10K1_CAPTURE_CHANNELS	4
 
-static void __devinit
-snd_emu10k1_init_mono_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
+static void snd_emu10k1_init_mono_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 			      const char *name, int gpr, int defval)
 {
 	ctl->id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -1094,8 +1093,7 @@ snd_emu10k1_init_mono_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 	}
 }
 
-static void __devinit
-snd_emu10k1_init_stereo_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
+static void snd_emu10k1_init_stereo_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 				const char *name, int gpr, int defval)
 {
 	ctl->id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -1116,8 +1114,7 @@ snd_emu10k1_init_stereo_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 	}
 }
 
-static void __devinit
-snd_emu10k1_init_mono_onoff_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
+static void snd_emu10k1_init_mono_onoff_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 				    const char *name, int gpr, int defval)
 {
 	ctl->id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -1129,8 +1126,7 @@ snd_emu10k1_init_mono_onoff_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 	ctl->translation = EMU10K1_GPR_TRANSLATION_ONOFF;
 }
 
-static void __devinit
-snd_emu10k1_init_stereo_onoff_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
+static void snd_emu10k1_init_stereo_onoff_control(struct snd_emu10k1_fx8010_control_gpr *ctl,
 				      const char *name, int gpr, int defval)
 {
 	ctl->id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -1168,7 +1164,7 @@ static int snd_emu10k1_audigy_dsp_convert_32_to_2x16(
  * initial DSP configuration for Audigy
  */
 
-static int __devinit _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
+static int _snd_emu10k1_audigy_init_efx(struct snd_emu10k1 *emu)
 {
 	int err, i, z, gpr, nctl;
 	int bit_shifter16;
@@ -1757,14 +1753,14 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 
 /* when volume = max, then copy only to avoid volume modification */
 /* with iMAC0 (negative values) */
-static void __devinit _volume(struct snd_emu10k1_fx8010_code *icode, u32 *ptr, u32 dst, u32 src, u32 vol)
+static void _volume(struct snd_emu10k1_fx8010_code *icode, u32 *ptr, u32 dst, u32 src, u32 vol)
 {
 	OP(icode, ptr, iMAC0, dst, C_00000000, src, vol);
 	OP(icode, ptr, iANDXOR, C_00000000, vol, C_ffffffff, C_7fffffff);
 	OP(icode, ptr, iSKIP, GPR_COND, GPR_COND, CC_REG_NONZERO, C_00000001);
 	OP(icode, ptr, iACC3, dst, src, C_00000000, C_00000000);
 }
-static void __devinit _volume_add(struct snd_emu10k1_fx8010_code *icode, u32 *ptr, u32 dst, u32 src, u32 vol)
+static void _volume_add(struct snd_emu10k1_fx8010_code *icode, u32 *ptr, u32 dst, u32 src, u32 vol)
 {
 	OP(icode, ptr, iANDXOR, C_00000000, vol, C_ffffffff, C_7fffffff);
 	OP(icode, ptr, iSKIP, GPR_COND, GPR_COND, CC_REG_NONZERO, C_00000002);
@@ -1772,7 +1768,7 @@ static void __devinit _volume_add(struct snd_emu10k1_fx8010_code *icode, u32 *pt
 	OP(icode, ptr, iSKIP, C_00000000, C_7fffffff, C_7fffffff, C_00000001);
 	OP(icode, ptr, iMAC0, dst, dst, src, vol);
 }
-static void __devinit _volume_out(struct snd_emu10k1_fx8010_code *icode, u32 *ptr, u32 dst, u32 src, u32 vol)
+static void _volume_out(struct snd_emu10k1_fx8010_code *icode, u32 *ptr, u32 dst, u32 src, u32 vol)
 {
 	OP(icode, ptr, iANDXOR, C_00000000, vol, C_ffffffff, C_7fffffff);
 	OP(icode, ptr, iSKIP, GPR_COND, GPR_COND, CC_REG_NONZERO, C_00000002);
@@ -1803,7 +1799,7 @@ static void __devinit _volume_out(struct snd_emu10k1_fx8010_code *icode, u32 *pt
 		_SWITCH_NEG(icode, ptr, GPR(dst), GPR(src))
 
 
-static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
+static int _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 {
 	int err, i, z, gpr, tmp, playback, capture;
 	u32 ptr;
@@ -2373,7 +2369,7 @@ static int __devinit _snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 	return err;
 }
 
-int __devinit snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
+int snd_emu10k1_init_efx(struct snd_emu10k1 *emu)
 {
 	spin_lock_init(&emu->fx8010.irq_lock);
 	INIT_LIST_HEAD(&emu->fx8010.gpr_ctl);
@@ -2626,7 +2622,7 @@ static int snd_emu10k1_fx8010_release(struct snd_hwdep * hw, struct file *file)
 	return 0;
 }
 
-int __devinit snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device, struct snd_hwdep ** rhwdep)
+int snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device, struct snd_hwdep ** rhwdep)
 {
 	struct snd_hwdep *hw;
 	int err;
@@ -2647,7 +2643,7 @@ int __devinit snd_emu10k1_fx8010_new(struct snd_emu10k1 *emu, int device, struct
 }
 
 #ifdef CONFIG_PM_SLEEP
-int __devinit snd_emu10k1_efx_alloc_pm_buffer(struct snd_emu10k1 *emu)
+int snd_emu10k1_efx_alloc_pm_buffer(struct snd_emu10k1 *emu)
 {
 	int len;
 
diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 9d890a5..00ff418 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -1716,7 +1716,7 @@ static int rename_ctl(struct snd_card *card, const char *src, const char *dst)
 	return -ENOENT;
 }
 
-int __devinit snd_emu10k1_mixer(struct snd_emu10k1 *emu,
+int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 				int pcm_device, int multi_device)
 {
 	int err, pcm;
diff --git a/sound/pci/emu10k1/emumpu401.c b/sound/pci/emu10k1/emumpu401.c
index bab5648..1ec9124 100644
--- a/sound/pci/emu10k1/emumpu401.c
+++ b/sound/pci/emu10k1/emumpu401.c
@@ -326,7 +326,7 @@ static void snd_emu10k1_midi_free(struct snd_rawmidi *rmidi)
 	midi->rmidi = NULL;
 }
 
-static int __devinit emu10k1_midi_init(struct snd_emu10k1 *emu, struct snd_emu10k1_midi *midi, int device, char *name)
+static int emu10k1_midi_init(struct snd_emu10k1 *emu, struct snd_emu10k1_midi *midi, int device, char *name)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
@@ -349,7 +349,7 @@ static int __devinit emu10k1_midi_init(struct snd_emu10k1 *emu, struct snd_emu10
 	return 0;
 }
 
-int __devinit snd_emu10k1_midi(struct snd_emu10k1 *emu)
+int snd_emu10k1_midi(struct snd_emu10k1 *emu)
 {
 	struct snd_emu10k1_midi *midi = &emu->midi;
 	int err;
@@ -366,7 +366,7 @@ int __devinit snd_emu10k1_midi(struct snd_emu10k1 *emu)
 	return 0;
 }
 
-int __devinit snd_emu10k1_audigy_midi(struct snd_emu10k1 *emu)
+int snd_emu10k1_audigy_midi(struct snd_emu10k1 *emu)
 {
 	struct snd_emu10k1_midi *midi;
 	int err;
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 0e6664f..febfa3b 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1391,7 +1391,7 @@ static struct snd_pcm_ops snd_emu10k1_efx_playback_ops = {
 	.page =			snd_pcm_sgbuf_ops_page,
 };
 
-int __devinit snd_emu10k1_pcm(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
+int snd_emu10k1_pcm(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
@@ -1426,7 +1426,7 @@ int __devinit snd_emu10k1_pcm(struct snd_emu10k1 * emu, int device, struct snd_p
 	return 0;
 }
 
-int __devinit snd_emu10k1_pcm_multi(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
+int snd_emu10k1_pcm_multi(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
@@ -1469,7 +1469,7 @@ static struct snd_pcm_ops snd_emu10k1_capture_mic_ops = {
 	.pointer =		snd_emu10k1_capture_pointer,
 };
 
-int __devinit snd_emu10k1_pcm_mic(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
+int snd_emu10k1_pcm_mic(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1810,7 +1810,7 @@ static struct snd_pcm_ops snd_emu10k1_fx8010_playback_ops = {
 	.ack =			snd_emu10k1_fx8010_playback_transfer,
 };
 
-int __devinit snd_emu10k1_pcm_efx(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
+int snd_emu10k1_pcm_efx(struct snd_emu10k1 * emu, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	struct snd_kcontrol *kctl;
diff --git a/sound/pci/emu10k1/emuproc.c b/sound/pci/emu10k1/emuproc.c
index bc38dd4..b51d248 100644
--- a/sound/pci/emu10k1/emuproc.c
+++ b/sound/pci/emu10k1/emuproc.c
@@ -577,7 +577,7 @@ static struct snd_info_entry_ops snd_emu10k1_proc_ops_fx8010 = {
 	.read = snd_emu10k1_fx8010_read,
 };
 
-int __devinit snd_emu10k1_proc_init(struct snd_emu10k1 * emu)
+int snd_emu10k1_proc_init(struct snd_emu10k1 * emu)
 {
 	struct snd_info_entry *entry;
 #ifdef CONFIG_SND_DEBUG
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 88cec6b..3f08dd7 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -637,7 +637,7 @@ int snd_p16v_free(struct snd_emu10k1 *chip)
 	return 0;
 }
 
-int __devinit snd_p16v_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm **rpcm)
+int snd_p16v_pcm(struct snd_emu10k1 *emu, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *substream;
@@ -880,7 +880,7 @@ static struct snd_kcontrol_new p16v_mixer_controls[] __devinitdata = {
 };
 
 
-int __devinit snd_p16v_mixer(struct snd_emu10k1 *emu)
+int snd_p16v_mixer(struct snd_emu10k1 *emu)
 {
 	int i, err;
         struct snd_card *card = emu->card;
@@ -897,7 +897,7 @@ int __devinit snd_p16v_mixer(struct snd_emu10k1 *emu)
 
 #define NUM_CHS	1	/* up to 4, but only first channel is used */
 
-int __devinit snd_p16v_alloc_pm_buffer(struct snd_emu10k1 *emu)
+int snd_p16v_alloc_pm_buffer(struct snd_emu10k1 *emu)
 {
 	emu->p16v_saved = vmalloc(NUM_CHS * 4 * 0x80);
 	if (! emu->p16v_saved)
diff --git a/sound/pci/emu10k1/timer.c b/sound/pci/emu10k1/timer.c
index 72321e9..b69a7f8 100644
--- a/sound/pci/emu10k1/timer.c
+++ b/sound/pci/emu10k1/timer.c
@@ -75,7 +75,7 @@ static struct snd_timer_hardware snd_emu10k1_timer_hw = {
 	.precise_resolution = snd_emu10k1_timer_precise_resolution,
 };
 
-int __devinit snd_emu10k1_timer(struct snd_emu10k1 *emu, int device)
+int snd_emu10k1_timer(struct snd_emu10k1 *emu, int device)
 {
 	struct snd_timer *timer = NULL;
 	struct snd_timer_id tid;
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index f631705..5ed22dc 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1268,7 +1268,7 @@ static const struct snd_pcm_chmap_elem surround_map[] = {
 	{ }
 };
 
-static int __devinit snd_ensoniq_pcm(struct ensoniq * ensoniq, int device,
+static int snd_ensoniq_pcm(struct ensoniq * ensoniq, int device,
 				     struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
@@ -1310,7 +1310,7 @@ static int __devinit snd_ensoniq_pcm(struct ensoniq * ensoniq, int device,
 	return 0;
 }
 
-static int __devinit snd_ensoniq_pcm2(struct ensoniq * ensoniq, int device,
+static int snd_ensoniq_pcm2(struct ensoniq * ensoniq, int device,
 				      struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
@@ -1640,7 +1640,7 @@ static struct snd_pci_quirk ens1373_line_quirk[] __devinitdata = {
 	{ } /* end */
 };
 
-static int __devinit snd_ensoniq_1371_mixer(struct ensoniq *ensoniq,
+static int snd_ensoniq_1371_mixer(struct ensoniq *ensoniq,
 					    int has_spdif, int has_line)
 {
 	struct snd_card *card = ensoniq->card;
@@ -1762,7 +1762,7 @@ static void snd_ensoniq_mixer_free_ak4531(struct snd_ak4531 *ak4531)
 	ensoniq->u.es1370.ak4531 = NULL;
 }
 
-static int __devinit snd_ensoniq_1370_mixer(struct ensoniq * ensoniq)
+static int snd_ensoniq_1370_mixer(struct ensoniq * ensoniq)
 {
 	struct snd_card *card = ensoniq->card;
 	struct snd_ak4531 ak4531;
@@ -1796,7 +1796,7 @@ static int __devinit snd_ensoniq_1370_mixer(struct ensoniq * ensoniq)
 #ifdef SUPPORT_JOYSTICK
 
 #ifdef CHIP1371
-static int __devinit snd_ensoniq_get_joystick_port(int dev)
+static int snd_ensoniq_get_joystick_port(int dev)
 {
 	switch (joystick_port[dev]) {
 	case 0: /* disabled */
@@ -1819,7 +1819,7 @@ static inline int snd_ensoniq_get_joystick_port(int dev)
 }
 #endif
 
-static int __devinit snd_ensoniq_create_gameport(struct ensoniq *ensoniq, int dev)
+static int snd_ensoniq_create_gameport(struct ensoniq *ensoniq, int dev)
 {
 	struct gameport *gp;
 	int io_port;
@@ -1913,7 +1913,7 @@ static void snd_ensoniq_proc_read(struct snd_info_entry *entry,
 #endif
 }
 
-static void __devinit snd_ensoniq_proc_init(struct ensoniq * ensoniq)
+static void snd_ensoniq_proc_init(struct ensoniq * ensoniq)
 {
 	struct snd_info_entry *entry;
 
@@ -2106,7 +2106,7 @@ static SIMPLE_DEV_PM_OPS(snd_ensoniq_pm, snd_ensoniq_suspend, snd_ensoniq_resume
 #define SND_ENSONIQ_PM_OPS	NULL
 #endif /* CONFIG_PM_SLEEP */
 
-static int __devinit snd_ensoniq_create(struct snd_card *card,
+static int snd_ensoniq_create(struct snd_card *card,
 				     struct pci_dev *pci,
 				     struct ensoniq ** rensoniq)
 {
@@ -2361,7 +2361,7 @@ static struct snd_rawmidi_ops snd_ensoniq_midi_input =
 	.trigger =	snd_ensoniq_midi_input_trigger,
 };
 
-static int __devinit snd_ensoniq_midi(struct ensoniq * ensoniq, int device,
+static int snd_ensoniq_midi(struct ensoniq * ensoniq, int device,
 				      struct snd_rawmidi **rrawmidi)
 {
 	struct snd_rawmidi *rmidi;
@@ -2422,7 +2422,7 @@ static irqreturn_t snd_audiopci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit snd_audiopci_probe(struct pci_dev *pci,
+static int snd_audiopci_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 83b889f..5441377 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1027,7 +1027,7 @@ static struct snd_pcm_ops snd_es1938_capture_ops = {
 	.copy =		snd_es1938_capture_copy,
 };
 
-static int __devinit snd_es1938_new_pcm(struct es1938 *chip, int device)
+static int snd_es1938_new_pcm(struct es1938 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1539,7 +1539,7 @@ static SIMPLE_DEV_PM_OPS(es1938_pm, es1938_suspend, es1938_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef SUPPORT_JOYSTICK
-static int __devinit snd_es1938_create_gameport(struct es1938 *chip)
+static int snd_es1938_create_gameport(struct es1938 *chip)
 {
 	struct gameport *gp;
 
@@ -1594,7 +1594,7 @@ static int snd_es1938_dev_free(struct snd_device *device)
 	return snd_es1938_free(chip);
 }
 
-static int __devinit snd_es1938_create(struct snd_card *card,
+static int snd_es1938_create(struct snd_card *card,
 				    struct pci_dev * pci,
 				    struct es1938 ** rchip)
 {
@@ -1754,7 +1754,7 @@ static irqreturn_t snd_es1938_interrupt(int irq, void *dev_id)
 
 #define ES1938_DMA_SIZE 64
 
-static int __devinit snd_es1938_mixer(struct es1938 *chip)
+static int snd_es1938_mixer(struct es1938 *chip)
 {
 	struct snd_card *card;
 	unsigned int idx;
@@ -1792,7 +1792,7 @@ static int __devinit snd_es1938_mixer(struct es1938 *chip)
 }
        
 
-static int __devinit snd_es1938_probe(struct pci_dev *pci,
+static int snd_es1938_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 90e29c5..076e461 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1429,8 +1429,7 @@ static void snd_es1968_free_dmabuf(struct es1968 *chip)
 	}
 }
 
-static int __devinit
-snd_es1968_init_dmabuf(struct es1968 *chip)
+static int snd_es1968_init_dmabuf(struct es1968 *chip)
 {
 	int err;
 	struct esm_memory *chunk;
@@ -1704,7 +1703,7 @@ static struct snd_pcm_ops snd_es1968_capture_ops = {
  */
 #define CLOCK_MEASURE_BUFSIZE	16768	/* enough large for a single shot */
 
-static void __devinit es1968_measure_clock(struct es1968 *chip)
+static void es1968_measure_clock(struct es1968 *chip)
 {
 	int i, apu;
 	unsigned int pa, offset, t;
@@ -1806,8 +1805,7 @@ static void snd_es1968_pcm_free(struct snd_pcm *pcm)
 	esm->pcm = NULL;
 }
 
-static int __devinit
-snd_es1968_pcm(struct es1968 *chip, int device)
+static int snd_es1968_pcm(struct es1968 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -2016,8 +2014,7 @@ static irqreturn_t snd_es1968_interrupt(int irq, void *dev_id)
  *  Mixer stuff
  */
 
-static int __devinit
-snd_es1968_mixer(struct es1968 *chip)
+static int snd_es1968_mixer(struct es1968 *chip)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
@@ -2465,7 +2462,7 @@ static SIMPLE_DEV_PM_OPS(es1968_pm, es1968_suspend, es1968_resume);
 
 #ifdef SUPPORT_JOYSTICK
 #define JOYSTICK_ADDR	0x200
-static int __devinit snd_es1968_create_gameport(struct es1968 *chip, int dev)
+static int snd_es1968_create_gameport(struct es1968 *chip, int dev)
 {
 	struct gameport *gp;
 	struct resource *r;
@@ -2516,7 +2513,7 @@ static inline void snd_es1968_free_gameport(struct es1968 *chip) { }
 #endif
 
 #ifdef CONFIG_SND_ES1968_INPUT
-static int __devinit snd_es1968_input_register(struct es1968 *chip)
+static int snd_es1968_input_register(struct es1968 *chip)
 {
 	struct input_dev *input_dev;
 	int err;
@@ -2668,7 +2665,7 @@ static struct ess_device_list mpu_blacklist[] __devinitdata = {
 	{ TYPE_MAESTRO2, 0x125d },
 };
 
-static int __devinit snd_es1968_create(struct snd_card *card,
+static int snd_es1968_create(struct snd_card *card,
 				       struct pci_dev *pci,
 				       int total_bufsize,
 				       int play_streams,
@@ -2795,7 +2792,7 @@ static int __devinit snd_es1968_create(struct snd_card *card,
 
 /*
  */
-static int __devinit snd_es1968_probe(struct pci_dev *pci,
+static int snd_es1968_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 8ec35dd..aa18b03 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -689,7 +689,7 @@ static struct snd_pcm_ops snd_fm801_capture_ops = {
 	.pointer =	snd_fm801_capture_pointer,
 };
 
-static int __devinit snd_fm801_pcm(struct fm801 *chip, int device, struct snd_pcm ** rpcm)
+static int snd_fm801_pcm(struct fm801 *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1030,7 +1030,7 @@ static void snd_fm801_mixer_free_ac97(struct snd_ac97 *ac97)
 	}
 }
 
-static int __devinit snd_fm801_mixer(struct fm801 *chip)
+static int snd_fm801_mixer(struct fm801 *chip)
 {
 	struct snd_ac97_template ac97;
 	unsigned int i;
@@ -1191,7 +1191,7 @@ static int snd_fm801_dev_free(struct snd_device *device)
 	return snd_fm801_free(chip);
 }
 
-static int __devinit snd_fm801_create(struct snd_card *card,
+static int snd_fm801_create(struct snd_card *card,
 				      struct pci_dev * pci,
 				      int tea575x_tuner,
 				      int radio_nr,
@@ -1296,7 +1296,7 @@ static int __devinit snd_fm801_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit snd_card_fm801_probe(struct pci_dev *pci,
+static int snd_card_fm801_probe(struct pci_dev *pci,
 					  const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bad2ba0..716d233 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -599,7 +599,7 @@ enum {
 #define DELAYED_INIT_MARK
 #define DELAYED_INITDATA_MARK
 #else
-#define DELAYED_INIT_MARK	__devinit
+#define DELAYED_INIT_MARK
 #define DELAYED_INITDATA_MARK	__devinitdata
 #endif
 
@@ -1708,7 +1708,7 @@ static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *mode
 }
 
 /* configure each codec instance */
-static int __devinit azx_codec_configure(struct azx *chip)
+static int azx_codec_configure(struct azx *chip)
 {
 	struct hda_codec *codec;
 	list_for_each_entry(codec, &chip->bus->codec_list, list) {
@@ -2479,7 +2479,7 @@ azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 /*
  * mixer creation - all stuff is implemented in hda module
  */
-static int __devinit azx_mixer_create(struct azx *chip)
+static int azx_mixer_create(struct azx *chip)
 {
 	return snd_hda_build_controls(chip->bus);
 }
@@ -2488,7 +2488,7 @@ static int __devinit azx_mixer_create(struct azx *chip)
 /*
  * initialize SD streams
  */
-static int __devinit azx_init_stream(struct azx *chip)
+static int azx_init_stream(struct azx *chip)
 {
 	int i;
 
@@ -2726,7 +2726,7 @@ static int DELAYED_INIT_MARK azx_first_init(struct azx *chip);
 static int DELAYED_INIT_MARK azx_probe_continue(struct azx *chip);
 
 #ifdef SUPPORT_VGA_SWITCHEROO
-static struct pci_dev __devinit *get_bound_vga(struct pci_dev *pci);
+static struct pci_dev *get_bound_vga(struct pci_dev *pci);
 
 static void azx_vs_set_state(struct pci_dev *pci,
 			     enum vga_switcheroo_state state)
@@ -2790,7 +2790,7 @@ static bool azx_vs_can_switch(struct pci_dev *pci)
 	return true;
 }
 
-static void __devinit init_vga_switcheroo(struct azx *chip)
+static void init_vga_switcheroo(struct azx *chip)
 {
 	struct pci_dev *p = get_bound_vga(chip->pci);
 	if (p) {
@@ -2807,7 +2807,7 @@ static const struct vga_switcheroo_client_ops azx_vs_ops = {
 	.can_switch = azx_vs_can_switch,
 };
 
-static int __devinit register_vga_switcheroo(struct azx *chip)
+static int register_vga_switcheroo(struct azx *chip)
 {
 	int err;
 
@@ -2899,7 +2899,7 @@ static int azx_dev_free(struct snd_device *device)
 /*
  * Check of disabled HDMI controller by vga-switcheroo
  */
-static struct pci_dev __devinit *get_bound_vga(struct pci_dev *pci)
+static struct pci_dev *get_bound_vga(struct pci_dev *pci)
 {
 	struct pci_dev *p;
 
@@ -2922,7 +2922,7 @@ static struct pci_dev __devinit *get_bound_vga(struct pci_dev *pci)
 	return NULL;
 }
 
-static bool __devinit check_hdmi_disabled(struct pci_dev *pci)
+static bool check_hdmi_disabled(struct pci_dev *pci)
 {
 	bool vga_inactive = false;
 	struct pci_dev *p = get_bound_vga(pci);
@@ -2957,7 +2957,7 @@ static struct snd_pci_quirk position_fix_list[] __devinitdata = {
 	{}
 };
 
-static int __devinit check_position_fix(struct azx *chip, int fix)
+static int check_position_fix(struct azx *chip, int fix)
 {
 	const struct snd_pci_quirk *q;
 
@@ -3015,7 +3015,7 @@ static struct snd_pci_quirk probe_mask_list[] __devinitdata = {
 
 #define AZX_FORCE_CODEC_MASK	0x100
 
-static void __devinit check_probe_mask(struct azx *chip, int dev)
+static void check_probe_mask(struct azx *chip, int dev)
 {
 	const struct snd_pci_quirk *q;
 
@@ -3052,7 +3052,7 @@ static struct snd_pci_quirk msi_black_list[] __devinitdata = {
 	{}
 };
 
-static void __devinit check_msi(struct azx *chip)
+static void check_msi(struct azx *chip)
 {
 	const struct snd_pci_quirk *q;
 
@@ -3078,7 +3078,7 @@ static void __devinit check_msi(struct azx *chip)
 }
 
 /* check the snoop mode availability */
-static void __devinit azx_check_snoop_available(struct azx *chip)
+static void azx_check_snoop_available(struct azx *chip)
 {
 	bool snoop = chip->snoop;
 
@@ -3110,7 +3110,7 @@ static void __devinit azx_check_snoop_available(struct azx *chip)
 /*
  * constructor
  */
-static int __devinit azx_create(struct snd_card *card, struct pci_dev *pci,
+static int azx_create(struct snd_card *card, struct pci_dev *pci,
 				int dev, unsigned int driver_caps,
 				struct azx **rchip)
 {
@@ -3409,7 +3409,7 @@ static void azx_firmware_cb(const struct firmware *fw, void *context)
 }
 #endif
 
-static int __devinit azx_probe(struct pci_dev *pci,
+static int azx_probe(struct pci_dev *pci,
 			       const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/ice1712/amp.c b/sound/pci/ice1712/amp.c
index d9bd27b..943cf4b 100644
--- a/sound/pci/ice1712/amp.c
+++ b/sound/pci/ice1712/amp.c
@@ -37,7 +37,7 @@ static void wm_put(struct snd_ice1712 *ice, int reg, unsigned short val)
 	snd_vt1724_write_i2c(ice, WM_DEV, cval >> 8, cval & 0xff);
 }
 
-static int __devinit snd_vt1724_amp_init(struct snd_ice1712 *ice)
+static int snd_vt1724_amp_init(struct snd_ice1712 *ice)
 {
 	static const unsigned short wm_inits[] = {
 		WM_ATTEN_L,	0x0000,	/* 0 db */
@@ -65,7 +65,7 @@ static int __devinit snd_vt1724_amp_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __devinit snd_vt1724_amp_add_controls(struct snd_ice1712 *ice)
+static int snd_vt1724_amp_add_controls(struct snd_ice1712 *ice)
 {
 	if (ice->ac97)
 		/* we use pins 39 and 41 of the VT1616 for left and right
diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index ce9941c..8d16da9 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1896,7 +1896,7 @@ static struct snd_kcontrol_new cs8415_controls[] __devinitdata = {
 	}
 };
 
-static int __devinit aureon_add_controls(struct snd_ice1712 *ice)
+static int aureon_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i, counts;
 	int err;
@@ -2124,7 +2124,7 @@ static int aureon_resume(struct snd_ice1712 *ice)
 /*
  * initialize the chip
  */
-static int __devinit aureon_init(struct snd_ice1712 *ice)
+static int aureon_init(struct snd_ice1712 *ice)
 {
 	struct aureon_spec *spec;
 	int i, err;
diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index bbef99b..1e8e5cf 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -575,7 +575,7 @@ static struct snd_ak4xxx_private akm_vx442_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static int __devinit snd_ice1712_delta_init(struct snd_ice1712 *ice)
+static int snd_ice1712_delta_init(struct snd_ice1712 *ice)
 {
 	int err;
 	struct snd_akm4xxx *ak;
@@ -725,7 +725,7 @@ static struct snd_kcontrol_new snd_ice1712_delta_spdif_in_status __devinitdata =
 ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Delta IEC958 Input Status", 0, ICE1712_DELTA_SPDIF_IN_STAT, 1, SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE);
 
 
-static int __devinit snd_ice1712_delta_add_controls(struct snd_ice1712 *ice)
+static int snd_ice1712_delta_add_controls(struct snd_ice1712 *ice)
 {
 	int err;
 
diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index bf289f0..65eaf99 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -419,7 +419,7 @@ static struct snd_ak4xxx_private akm_6fire_priv __devinitdata = {
 
 static int snd_ice1712_6fire_write_pca(struct snd_ice1712 *ice, unsigned char reg, unsigned char data);
 
-static int __devinit snd_ice1712_ews_init(struct snd_ice1712 *ice)
+static int snd_ice1712_ews_init(struct snd_ice1712 *ice)
 {
 	int err;
 	struct snd_akm4xxx *ak;
@@ -963,7 +963,7 @@ static struct snd_kcontrol_new snd_ice1712_6fire_controls[] __devinitdata = {
 };
 
 
-static int __devinit snd_ice1712_ews_add_controls(struct snd_ice1712 *ice)
+static int snd_ice1712_ews_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int idx;
 	int err;
diff --git a/sound/pci/ice1712/hoontech.c b/sound/pci/ice1712/hoontech.c
index 3d84d21..db1e852 100644
--- a/sound/pci/ice1712/hoontech.c
+++ b/sound/pci/ice1712/hoontech.c
@@ -39,7 +39,7 @@ struct hoontech_spec {
 	unsigned short boxconfig[4];
 };
 
-static void __devinit snd_ice1712_stdsp24_gpio_write(struct snd_ice1712 *ice, unsigned char byte)
+static void snd_ice1712_stdsp24_gpio_write(struct snd_ice1712 *ice, unsigned char byte)
 {
 	byte |= ICE1712_STDSP24_CLOCK_BIT;
 	udelay(100);
@@ -52,7 +52,7 @@ static void __devinit snd_ice1712_stdsp24_gpio_write(struct snd_ice1712 *ice, un
 	snd_ice1712_write(ice, ICE1712_IREG_GPIO_DATA, byte);
 }
 
-static void __devinit snd_ice1712_stdsp24_darear(struct snd_ice1712 *ice, int activate)
+static void snd_ice1712_stdsp24_darear(struct snd_ice1712 *ice, int activate)
 {
 	struct hoontech_spec *spec = ice->spec;
 	mutex_lock(&ice->gpio_mutex);
@@ -61,7 +61,7 @@ static void __devinit snd_ice1712_stdsp24_darear(struct snd_ice1712 *ice, int ac
 	mutex_unlock(&ice->gpio_mutex);
 }
 
-static void __devinit snd_ice1712_stdsp24_mute(struct snd_ice1712 *ice, int activate)
+static void snd_ice1712_stdsp24_mute(struct snd_ice1712 *ice, int activate)
 {
 	struct hoontech_spec *spec = ice->spec;
 	mutex_lock(&ice->gpio_mutex);
@@ -70,7 +70,7 @@ static void __devinit snd_ice1712_stdsp24_mute(struct snd_ice1712 *ice, int acti
 	mutex_unlock(&ice->gpio_mutex);
 }
 
-static void __devinit snd_ice1712_stdsp24_insel(struct snd_ice1712 *ice, int activate)
+static void snd_ice1712_stdsp24_insel(struct snd_ice1712 *ice, int activate)
 {
 	struct hoontech_spec *spec = ice->spec;
 	mutex_lock(&ice->gpio_mutex);
@@ -79,7 +79,7 @@ static void __devinit snd_ice1712_stdsp24_insel(struct snd_ice1712 *ice, int act
 	mutex_unlock(&ice->gpio_mutex);
 }
 
-static void __devinit snd_ice1712_stdsp24_box_channel(struct snd_ice1712 *ice, int box, int chn, int activate)
+static void snd_ice1712_stdsp24_box_channel(struct snd_ice1712 *ice, int box, int chn, int activate)
 {
 	struct hoontech_spec *spec = ice->spec;
 
@@ -129,7 +129,7 @@ static void __devinit snd_ice1712_stdsp24_box_channel(struct snd_ice1712 *ice, i
 	mutex_unlock(&ice->gpio_mutex);
 }
 
-static void __devinit snd_ice1712_stdsp24_box_midi(struct snd_ice1712 *ice, int box, int master)
+static void snd_ice1712_stdsp24_box_midi(struct snd_ice1712 *ice, int box, int master)
 {
 	struct hoontech_spec *spec = ice->spec;
 
@@ -157,7 +157,7 @@ static void __devinit snd_ice1712_stdsp24_box_midi(struct snd_ice1712 *ice, int
 	mutex_unlock(&ice->gpio_mutex);
 }
 
-static void __devinit snd_ice1712_stdsp24_midi2(struct snd_ice1712 *ice, int activate)
+static void snd_ice1712_stdsp24_midi2(struct snd_ice1712 *ice, int activate)
 {
 	struct hoontech_spec *spec = ice->spec;
 	mutex_lock(&ice->gpio_mutex);
@@ -166,7 +166,7 @@ static void __devinit snd_ice1712_stdsp24_midi2(struct snd_ice1712 *ice, int act
 	mutex_unlock(&ice->gpio_mutex);
 }
 
-static int __devinit snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
+static int snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
 {
 	struct hoontech_spec *spec;
 	int box, chn;
@@ -266,7 +266,7 @@ static void stdsp24_ak4524_lock(struct snd_akm4xxx *ak, int chip)
 	snd_ice1712_write(ice, ICE1712_IREG_GPIO_WRITE_MASK, ~tmp);
 }
 
-static int __devinit snd_ice1712_value_init(struct snd_ice1712 *ice)
+static int snd_ice1712_value_init(struct snd_ice1712 *ice)
 {
 	/* Hoontech STDSP24 with modified hardware */
 	static struct snd_akm4xxx akm_stdsp24_mv __devinitdata = {
@@ -316,7 +316,7 @@ static int __devinit snd_ice1712_value_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __devinit snd_ice1712_ez8_init(struct snd_ice1712 *ice)
+static int snd_ice1712_ez8_init(struct snd_ice1712 *ice)
 {
 	ice->gpio.write_mask = ice->eeprom.gpiomask;
 	ice->gpio.direction = ice->eeprom.gpiodir;
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 80b3409..31719d0 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -387,7 +387,7 @@ static void setup_cs8427(struct snd_ice1712 *ice, int rate)
 /*
  * create and initialize callbacks for cs8427 interface
  */
-int __devinit snd_ice1712_init_cs8427(struct snd_ice1712 *ice, int addr)
+int snd_ice1712_init_cs8427(struct snd_ice1712 *ice, int addr)
 {
 	int err;
 
@@ -878,7 +878,7 @@ static struct snd_pcm_ops snd_ice1712_capture_ops = {
 	.pointer =	snd_ice1712_capture_pointer,
 };
 
-static int __devinit snd_ice1712_pcm(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
+static int snd_ice1712_pcm(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -908,7 +908,7 @@ static int __devinit snd_ice1712_pcm(struct snd_ice1712 *ice, int device, struct
 	return 0;
 }
 
-static int __devinit snd_ice1712_pcm_ds(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
+static int snd_ice1712_pcm_ds(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1253,7 +1253,7 @@ static struct snd_pcm_ops snd_ice1712_capture_pro_ops = {
 	.pointer =	snd_ice1712_capture_pro_pointer,
 };
 
-static int __devinit snd_ice1712_pcm_profi(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
+static int snd_ice1712_pcm_profi(struct snd_ice1712 *ice, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1452,7 +1452,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_volume __devinitd
 	.count = 2,
 };
 
-static int __devinit snd_ice1712_build_pro_mixer(struct snd_ice1712 *ice)
+static int snd_ice1712_build_pro_mixer(struct snd_ice1712 *ice)
 {
 	struct snd_card *card = ice->card;
 	unsigned int idx;
@@ -1511,7 +1511,7 @@ static void snd_ice1712_mixer_free_ac97(struct snd_ac97 *ac97)
 	ice->ac97 = NULL;
 }
 
-static int __devinit snd_ice1712_ac97_mixer(struct snd_ice1712 *ice)
+static int snd_ice1712_ac97_mixer(struct snd_ice1712 *ice)
 {
 	int err, bus_num = 0;
 	struct snd_ac97_template ac97;
@@ -1610,7 +1610,7 @@ static void snd_ice1712_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "  GPIO_DIRECTION   : 0x%02x\n", (unsigned)snd_ice1712_read(ice, ICE1712_IREG_GPIO_DIRECTION));
 }
 
-static void __devinit snd_ice1712_proc_init(struct snd_ice1712 *ice)
+static void snd_ice1712_proc_init(struct snd_ice1712 *ice)
 {
 	struct snd_info_entry *entry;
 
@@ -2298,7 +2298,7 @@ static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
 	NULL,
 };
 
-static unsigned char __devinit snd_ice1712_read_i2c(struct snd_ice1712 *ice,
+static unsigned char snd_ice1712_read_i2c(struct snd_ice1712 *ice,
 						 unsigned char dev,
 						 unsigned char addr)
 {
@@ -2310,7 +2310,7 @@ static unsigned char __devinit snd_ice1712_read_i2c(struct snd_ice1712 *ice,
 	return inb(ICEREG(ice, I2C_DATA));
 }
 
-static int __devinit snd_ice1712_read_eeprom(struct snd_ice1712 *ice,
+static int snd_ice1712_read_eeprom(struct snd_ice1712 *ice,
 					     const char *modelname)
 {
 	int dev = 0xa0;		/* EEPROM device address */
@@ -2385,7 +2385,7 @@ static int __devinit snd_ice1712_read_eeprom(struct snd_ice1712 *ice,
 
 
 
-static int __devinit snd_ice1712_chip_init(struct snd_ice1712 *ice)
+static int snd_ice1712_chip_init(struct snd_ice1712 *ice)
 {
 	outb(ICE1712_RESET | ICE1712_NATIVE, ICEREG(ice, CONTROL));
 	udelay(200);
@@ -2432,7 +2432,7 @@ static int __devinit snd_ice1712_chip_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
-int __devinit snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice)
+int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice)
 {
 	int err;
 	struct snd_kcontrol *kctl;
@@ -2460,7 +2460,7 @@ int __devinit snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice)
 }
 
 
-static int __devinit snd_ice1712_build_controls(struct snd_ice1712 *ice)
+static int snd_ice1712_build_controls(struct snd_ice1712 *ice)
 {
 	int err;
 
@@ -2530,7 +2530,7 @@ static int snd_ice1712_dev_free(struct snd_device *device)
 	return snd_ice1712_free(ice);
 }
 
-static int __devinit snd_ice1712_create(struct snd_card *card,
+static int snd_ice1712_create(struct snd_card *card,
 					struct pci_dev *pci,
 					const char *modelname,
 					int omni,
@@ -2652,7 +2652,7 @@ static int __devinit snd_ice1712_create(struct snd_card *card,
 
 static struct snd_ice1712_card_info no_matched __devinitdata;
 
-static int __devinit snd_ice1712_probe(struct pci_dev *pci,
+static int snd_ice1712_probe(struct pci_dev *pci,
 				       const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index cf872ae..30b5935 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1135,7 +1135,7 @@ static struct snd_pcm_ops snd_vt1724_capture_pro_ops = {
 	.pointer =	snd_vt1724_pcm_pointer,
 };
 
-static int __devinit snd_vt1724_pcm_profi(struct snd_ice1712 *ice, int device)
+static int snd_vt1724_pcm_profi(struct snd_ice1712 *ice, int device)
 {
 	struct snd_pcm *pcm;
 	int capt, err;
@@ -1315,7 +1315,7 @@ static struct snd_pcm_ops snd_vt1724_capture_spdif_ops = {
 };
 
 
-static int __devinit snd_vt1724_pcm_spdif(struct snd_ice1712 *ice, int device)
+static int snd_vt1724_pcm_spdif(struct snd_ice1712 *ice, int device)
 {
 	char *name;
 	struct snd_pcm *pcm;
@@ -1449,7 +1449,7 @@ static struct snd_pcm_ops snd_vt1724_playback_indep_ops = {
 };
 
 
-static int __devinit snd_vt1724_pcm_indep(struct snd_ice1712 *ice, int device)
+static int snd_vt1724_pcm_indep(struct snd_ice1712 *ice, int device)
 {
 	struct snd_pcm *pcm;
 	int play;
@@ -1484,7 +1484,7 @@ static int __devinit snd_vt1724_pcm_indep(struct snd_ice1712 *ice, int device)
  *  Mixer section
  */
 
-static int __devinit snd_vt1724_ac97_mixer(struct snd_ice1712 *ice)
+static int snd_vt1724_ac97_mixer(struct snd_ice1712 *ice)
 {
 	int err;
 
@@ -1570,7 +1570,7 @@ static void snd_vt1724_proc_read(struct snd_info_entry *entry,
 			    idx, inb(ice->profi_port+idx));
 }
 
-static void __devinit snd_vt1724_proc_init(struct snd_ice1712 *ice)
+static void snd_vt1724_proc_init(struct snd_ice1712 *ice)
 {
 	struct snd_info_entry *entry;
 
@@ -2307,7 +2307,7 @@ void snd_vt1724_write_i2c(struct snd_ice1712 *ice,
 	mutex_unlock(&ice->i2c_mutex);
 }
 
-static int __devinit snd_vt1724_read_eeprom(struct snd_ice1712 *ice,
+static int snd_vt1724_read_eeprom(struct snd_ice1712 *ice,
 					    const char *modelname)
 {
 	const int dev = 0xa0;		/* EEPROM device address */
@@ -2430,7 +2430,7 @@ static int snd_vt1724_chip_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __devinit snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
+static int snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
 {
 	int err;
 	struct snd_kcontrol *kctl;
@@ -2472,7 +2472,7 @@ static int __devinit snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
 }
 
 
-static int __devinit snd_vt1724_build_controls(struct snd_ice1712 *ice)
+static int snd_vt1724_build_controls(struct snd_ice1712 *ice)
 {
 	int err;
 
@@ -2532,7 +2532,7 @@ static int snd_vt1724_dev_free(struct snd_device *device)
 	return snd_vt1724_free(ice);
 }
 
-static int __devinit snd_vt1724_create(struct snd_card *card,
+static int snd_vt1724_create(struct snd_card *card,
 				       struct pci_dev *pci,
 				       const char *modelname,
 				       struct snd_ice1712 **r_ice1712)
@@ -2622,7 +2622,7 @@ static int __devinit snd_vt1724_create(struct snd_card *card,
  *
  */
 
-static int __devinit snd_vt1724_probe(struct pci_dev *pci,
+static int snd_vt1724_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index a6b23b4..0585e9c 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -422,7 +422,7 @@ static char *slave_vols[] __devinitdata = {
 static __devinitdata
 DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, 1);
 
-static struct snd_kcontrol __devinit *ctl_find(struct snd_card *card,
+static struct snd_kcontrol *ctl_find(struct snd_card *card,
 		const char *name)
 {
 	struct snd_ctl_elem_id sid;
@@ -433,7 +433,7 @@ static struct snd_kcontrol __devinit *ctl_find(struct snd_card *card,
 	return snd_ctl_find_id(card, &sid);
 }
 
-static void __devinit add_slaves(struct snd_card *card,
+static void add_slaves(struct snd_card *card,
 				 struct snd_kcontrol *master,
 				 char * const *list)
 {
@@ -447,7 +447,7 @@ static void __devinit add_slaves(struct snd_card *card,
 	}
 }
 
-static int __devinit juli_add_controls(struct snd_ice1712 *ice)
+static int juli_add_controls(struct snd_ice1712 *ice)
 {
 	struct juli_spec *spec = ice->spec;
 	int err;
@@ -579,7 +579,7 @@ static void juli_ak4114_change(struct ak4114 *ak4114, unsigned char c0,
 	}
 }
 
-static int __devinit juli_init(struct snd_ice1712 *ice)
+static int juli_init(struct snd_ice1712 *ice)
 {
 	static const unsigned char ak4114_init_vals[] = {
 		/* AK4117_REG_PWRDN */	AK4114_RST | AK4114_PWN |
diff --git a/sound/pci/ice1712/maya44.c b/sound/pci/ice1712/maya44.c
index d8d749e..9292ca1 100644
--- a/sound/pci/ice1712/maya44.c
+++ b/sound/pci/ice1712/maya44.c
@@ -544,7 +544,7 @@ static struct snd_kcontrol_new maya_controls[] __devinitdata = {
 	},
 };
 
-static int __devinit maya44_add_controls(struct snd_ice1712 *ice)
+static int maya44_add_controls(struct snd_ice1712 *ice)
 {
 	int err, i;
 
@@ -561,7 +561,7 @@ static int __devinit maya44_add_controls(struct snd_ice1712 *ice)
 /*
  * initialize a wm8776 chip
  */
-static void __devinit wm8776_init(struct snd_ice1712 *ice,
+static void wm8776_init(struct snd_ice1712 *ice,
 				  struct snd_wm8776 *wm, unsigned int addr)
 {
 	static const unsigned short inits_wm8776[] = {
@@ -699,7 +699,7 @@ static unsigned char wm8776_addr[2] __devinitdata = {
 /*
  * initialize the chip
  */
-static int __devinit maya44_init(struct snd_ice1712 *ice)
+static int maya44_init(struct snd_ice1712 *ice)
 {
 	int i;
 	struct snd_maya44 *chip;
diff --git a/sound/pci/ice1712/phase.c b/sound/pci/ice1712/phase.c
index c9be75a..a9dbdd8 100644
--- a/sound/pci/ice1712/phase.c
+++ b/sound/pci/ice1712/phase.c
@@ -120,7 +120,7 @@ static struct snd_ak4xxx_private akm_phase22_priv __devinitdata = {
 	.mask_flags =	0,
 };
 
-static int __devinit phase22_init(struct snd_ice1712 *ice)
+static int phase22_init(struct snd_ice1712 *ice)
 {
 	struct snd_akm4xxx *ak;
 	int err;
@@ -157,7 +157,7 @@ static int __devinit phase22_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __devinit phase22_add_controls(struct snd_ice1712 *ice)
+static int phase22_add_controls(struct snd_ice1712 *ice)
 {
 	int err = 0;
 
@@ -378,7 +378,7 @@ static int wm_master_vol_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static int __devinit phase28_init(struct snd_ice1712 *ice)
+static int phase28_init(struct snd_ice1712 *ice)
 {
 	static const unsigned short wm_inits_phase28[] = {
 		/* These come first to reduce init pop noise */
@@ -918,7 +918,7 @@ static struct snd_kcontrol_new wm_controls[] __devinitdata = {
 	}
 };
 
-static int __devinit phase28_add_controls(struct snd_ice1712 *ice)
+static int phase28_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i, counts;
 	int err;
diff --git a/sound/pci/ice1712/pontis.c b/sound/pci/ice1712/pontis.c
index 3ce1289..8676d2f 100644
--- a/sound/pci/ice1712/pontis.c
+++ b/sound/pci/ice1712/pontis.c
@@ -696,7 +696,7 @@ static void cs_proc_init(struct snd_ice1712 *ice)
 }
 
 
-static int __devinit pontis_add_controls(struct snd_ice1712 *ice)
+static int pontis_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i;
 	int err;
@@ -717,7 +717,7 @@ static int __devinit pontis_add_controls(struct snd_ice1712 *ice)
 /*
  * initialize the chip
  */
-static int __devinit pontis_init(struct snd_ice1712 *ice)
+static int pontis_init(struct snd_ice1712 *ice)
 {
 	static const unsigned short wm_inits[] = {
 		/* These come first to reduce init pop noise */
diff --git a/sound/pci/ice1712/prodigy192.c b/sound/pci/ice1712/prodigy192.c
index 3fcf581..3426acc 100644
--- a/sound/pci/ice1712/prodigy192.c
+++ b/sound/pci/ice1712/prodigy192.c
@@ -671,7 +671,7 @@ static void stac9460_proc_init(struct snd_ice1712 *ice)
 }
 
 
-static int __devinit prodigy192_add_controls(struct snd_ice1712 *ice)
+static int prodigy192_add_controls(struct snd_ice1712 *ice)
 {
 	struct prodigy192_spec *spec = ice->spec;
 	unsigned int i;
@@ -727,7 +727,7 @@ static int prodigy192_miodio_exists(struct snd_ice1712 *ice)
 /*
  * initialize the chip
  */
-static int __devinit prodigy192_init(struct snd_ice1712 *ice)
+static int prodigy192_init(struct snd_ice1712 *ice)
 {
 	static const unsigned short stac_inits_prodigy[] = {
 		STAC946X_RESET, 0,
diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 4fea87f..931eb08 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -938,7 +938,7 @@ static void wm_proc_init(struct snd_ice1712 *ice)
 	}
 }
 
-static int __devinit prodigy_hifi_add_controls(struct snd_ice1712 *ice)
+static int prodigy_hifi_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i;
 	int err;
@@ -955,7 +955,7 @@ static int __devinit prodigy_hifi_add_controls(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __devinit prodigy_hd2_add_controls(struct snd_ice1712 *ice)
+static int prodigy_hd2_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i;
 	int err;
@@ -976,7 +976,7 @@ static int __devinit prodigy_hd2_add_controls(struct snd_ice1712 *ice)
 /*
  * initialize the chip
  */
-static int __devinit prodigy_hifi_init(struct snd_ice1712 *ice)
+static int prodigy_hifi_init(struct snd_ice1712 *ice)
 {
 	static unsigned short wm_inits[] = {
 		/* These come first to reduce init pop noise */
@@ -1114,7 +1114,7 @@ static int prodigy_hd2_resume(struct snd_ice1712 *ice)
 }
 #endif
 
-static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
+static int prodigy_hd2_init(struct snd_ice1712 *ice)
 {
 	struct prodigy_hifi_spec *spec;
 
diff --git a/sound/pci/ice1712/psc724.c b/sound/pci/ice1712/psc724.c
index 0b6c4e6..1c15552 100644
--- a/sound/pci/ice1712/psc724.c
+++ b/sound/pci/ice1712/psc724.c
@@ -316,7 +316,7 @@ static const char *clfe_deemph	= "CLFE Deemphasis Playback Switch";
 static const char *rear_clfe_izd = "Rear Infinite Zero Detect Playback Switch";
 static const char *rear_clfe_zc	= "Rear Zero Cross Detect Playback Switch";
 
-static int __devinit psc724_add_controls(struct snd_ice1712 *ice)
+static int psc724_add_controls(struct snd_ice1712 *ice)
 {
 	struct snd_kcontrol_new cont;
 	struct snd_kcontrol *ctl;
@@ -396,7 +396,7 @@ static int psc724_resume(struct snd_ice1712 *ice)
 
 /* init */
 
-static int __devinit psc724_init(struct snd_ice1712 *ice)
+static int psc724_init(struct snd_ice1712 *ice)
 {
 	struct psc724_spec *spec;
 
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index c85b2ff..1f02d0d 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -804,7 +804,7 @@ static char *slave_vols[] __devinitdata = {
 static __devinitdata
 DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, 1);
 
-static struct snd_kcontrol __devinit *ctl_find(struct snd_card *card,
+static struct snd_kcontrol *ctl_find(struct snd_card *card,
 		const char *name)
 {
 	struct snd_ctl_elem_id sid;
@@ -815,7 +815,7 @@ static struct snd_kcontrol __devinit *ctl_find(struct snd_card *card,
 	return snd_ctl_find_id(card, &sid);
 }
 
-static void __devinit add_slaves(struct snd_card *card,
+static void add_slaves(struct snd_card *card,
 		struct snd_kcontrol *master, char * const *list)
 {
 	for (; *list; list++) {
@@ -825,7 +825,7 @@ static void __devinit add_slaves(struct snd_card *card,
 	}
 }
 
-static int __devinit qtet_add_controls(struct snd_ice1712 *ice)
+static int qtet_add_controls(struct snd_ice1712 *ice)
 {
 	struct qtet_spec *spec = ice->spec;
 	int err, i;
@@ -1007,7 +1007,7 @@ static void qtet_spdif_in_open(struct snd_ice1712 *ice,
 /*
  * initialize the chip
  */
-static int __devinit qtet_init(struct snd_ice1712 *ice)
+static int qtet_init(struct snd_ice1712 *ice)
 {
 	static const unsigned char ak4113_init_vals[] = {
 		/* AK4113_REG_PWRDN */	AK4113_RST | AK4113_PWN |
diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index a1b7975..f37d403 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -467,7 +467,7 @@ static unsigned char ap192_ak4114_read(void *private_data, unsigned char addr)
 	return data;
 }
 
-static int __devinit ap192_ak4114_init(struct snd_ice1712 *ice)
+static int ap192_ak4114_init(struct snd_ice1712 *ice)
 {
 	static const unsigned char ak4114_init_vals[] = {
 		AK4114_RST | AK4114_PWN | AK4114_OCKS0 | AK4114_OCKS1,
@@ -495,7 +495,7 @@ static int __devinit ap192_ak4114_init(struct snd_ice1712 *ice)
 	return 0; /* error ignored; it's no fatal error */
 }
 
-static int __devinit revo_init(struct snd_ice1712 *ice)
+static int revo_init(struct snd_ice1712 *ice)
 {
 	struct snd_akm4xxx *ak;
 	int err;
@@ -573,7 +573,7 @@ static int __devinit revo_init(struct snd_ice1712 *ice)
 }
 
 
-static int __devinit revo_add_controls(struct snd_ice1712 *ice)
+static int revo_add_controls(struct snd_ice1712 *ice)
 {
 	struct revo51_spec *spec;
 	int err;
diff --git a/sound/pci/ice1712/se.c b/sound/pci/ice1712/se.c
index 53b555f..adff671 100644
--- a/sound/pci/ice1712/se.c
+++ b/sound/pci/ice1712/se.c
@@ -113,7 +113,7 @@ struct se_spec {
 /*  WM8740 interface                                                        */
 /****************************************************************************/
 
-static void __devinit se200pci_WM8740_init(struct snd_ice1712 *ice)
+static void se200pci_WM8740_init(struct snd_ice1712 *ice)
 {
 	/* nothing to do */
 }
@@ -195,7 +195,7 @@ static void se200pci_WM8766_set_volume(struct snd_ice1712 *ice, int ch,
 	}
 }
 
-static void __devinit se200pci_WM8766_init(struct snd_ice1712 *ice)
+static void se200pci_WM8766_init(struct snd_ice1712 *ice)
 {
 	se200pci_WM8766_write(ice, 0x1f, 0x000); /* RESET ALL */
 	udelay(10);
@@ -299,7 +299,7 @@ static void se200pci_WM8776_set_agc(struct snd_ice1712 *ice, unsigned int agc)
 	}
 }
 
-static void __devinit se200pci_WM8776_init(struct snd_ice1712 *ice)
+static void se200pci_WM8776_init(struct snd_ice1712 *ice)
 {
 	int i;
 	static unsigned short __devinitdata default_values[] = {
@@ -599,7 +599,7 @@ static int se200pci_cont_enum_put(struct snd_kcontrol *kc,
 static const DECLARE_TLV_DB_SCALE(db_scale_gain1, -12750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(db_scale_gain2, -10350, 50, 1);
 
-static int __devinit se200pci_add_controls(struct snd_ice1712 *ice)
+static int se200pci_add_controls(struct snd_ice1712 *ice)
 {
 	int i;
 	struct snd_kcontrol_new cont;
@@ -677,7 +677,7 @@ static int __devinit se200pci_add_controls(struct snd_ice1712 *ice)
 /*  probe/initialize/setup                                                  */
 /****************************************************************************/
 
-static int __devinit se_init(struct snd_ice1712 *ice)
+static int se_init(struct snd_ice1712 *ice)
 {
 	struct se_spec *spec;
 
@@ -705,7 +705,7 @@ static int __devinit se_init(struct snd_ice1712 *ice)
 	return -ENOENT;
 }
 
-static int __devinit se_add_controls(struct snd_ice1712 *ice)
+static int se_add_controls(struct snd_ice1712 *ice)
 {
 	int err;
 
diff --git a/sound/pci/ice1712/vt1720_mobo.c b/sound/pci/ice1712/vt1720_mobo.c
index 8a0a839..87dfe9c 100644
--- a/sound/pci/ice1712/vt1720_mobo.c
+++ b/sound/pci/ice1712/vt1720_mobo.c
@@ -31,7 +31,7 @@
 #include "vt1720_mobo.h"
 
 
-static int __devinit k8x800_init(struct snd_ice1712 *ice)
+static int k8x800_init(struct snd_ice1712 *ice)
 {
 	ice->vt1720 = 1;
 
@@ -45,7 +45,7 @@ static int __devinit k8x800_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __devinit k8x800_add_controls(struct snd_ice1712 *ice)
+static int k8x800_add_controls(struct snd_ice1712 *ice)
 {
 	/* FIXME: needs some quirks for VT1616? */
 	return 0;
diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index 184163b..967bd41 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -447,7 +447,7 @@ static struct snd_kcontrol_new stac9640_controls[] __devinitdata = {
 
 
 /*INIT*/
-static int __devinit wtm_add_controls(struct snd_ice1712 *ice)
+static int wtm_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i;
 	int err;
@@ -461,7 +461,7 @@ static int __devinit wtm_add_controls(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static int __devinit wtm_init(struct snd_ice1712 *ice)
+static int wtm_init(struct snd_ice1712 *ice)
 {
 	static unsigned short stac_inits_prodigy[] = {
 		STAC946X_RESET, 0,
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index a3ab153..b6a5cfc 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -592,7 +592,7 @@ static unsigned short snd_intel8x0_codec_read(struct snd_ac97 *ac97,
 	return res;
 }
 
-static void __devinit snd_intel8x0_codec_read_test(struct intel8x0 *chip,
+static void snd_intel8x0_codec_read_test(struct intel8x0 *chip,
 						   unsigned int codec)
 {
 	unsigned int tmp;
@@ -1507,7 +1507,7 @@ struct ich_pcm_table {
 	int ac97_idx;
 };
 
-static int __devinit snd_intel8x0_pcm1(struct intel8x0 *chip, int device,
+static int snd_intel8x0_pcm1(struct intel8x0 *chip, int device,
 				       struct ich_pcm_table *rec)
 {
 	struct snd_pcm *pcm;
@@ -1656,7 +1656,7 @@ static struct ich_pcm_table ali_pcms[] __devinitdata = {
 #endif
 };
 
-static int __devinit snd_intel8x0_pcm(struct intel8x0 *chip)
+static int snd_intel8x0_pcm(struct intel8x0 *chip)
 {
 	int i, tblsize, device, err;
 	struct ich_pcm_table *tbl, *rec;
@@ -2196,7 +2196,7 @@ static struct ac97_quirk ac97_quirks[] __devinitdata = {
 	{ } /* terminator */
 };
 
-static int __devinit snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
+static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 					const char *quirk_override)
 {
 	struct snd_ac97_bus *pbus;
@@ -2765,7 +2765,7 @@ static SIMPLE_DEV_PM_OPS(intel8x0_pm, intel8x0_suspend, intel8x0_resume);
 
 #define INTEL8X0_TESTBUF_SIZE	32768	/* enough large for one shot */
 
-static void __devinit intel8x0_measure_ac97_clock(struct intel8x0 *chip)
+static void intel8x0_measure_ac97_clock(struct intel8x0 *chip)
 {
 	struct snd_pcm_substream *subs;
 	struct ichdev *ichdev;
@@ -2892,7 +2892,7 @@ static struct snd_pci_quirk intel8x0_clock_list[] __devinitdata = {
 	{ }	/* terminator */
 };
 
-static int __devinit intel8x0_in_clock_list(struct intel8x0 *chip)
+static int intel8x0_in_clock_list(struct intel8x0 *chip)
 {
 	struct pci_dev *pci = chip->pci;
 	const struct snd_pci_quirk *wl;
@@ -2941,7 +2941,7 @@ static void snd_intel8x0_proc_read(struct snd_info_entry * entry,
 			chip->ac97_sdin[2]);
 }
 
-static void __devinit snd_intel8x0_proc_init(struct intel8x0 * chip)
+static void snd_intel8x0_proc_init(struct intel8x0 * chip)
 {
 	struct snd_info_entry *entry;
 
@@ -2970,7 +2970,7 @@ static unsigned int sis_codec_bits[3] = {
 	ICH_PCR, ICH_SCR, ICH_SIS_TCR
 };
 
-static int __devinit snd_intel8x0_inside_vm(struct pci_dev *pci)
+static int snd_intel8x0_inside_vm(struct pci_dev *pci)
 {
 	int result  = inside_vm;
 	char *msg   = NULL;
@@ -3009,7 +3009,7 @@ fini:
 	return result;
 }
 
-static int __devinit snd_intel8x0_create(struct snd_card *card,
+static int snd_intel8x0_create(struct snd_card *card,
 					 struct pci_dev *pci,
 					 unsigned long device_type,
 					 struct intel8x0 ** r_intel8x0)
@@ -3259,7 +3259,7 @@ static struct snd_pci_quirk spdif_aclink_defaults[] __devinitdata = {
 };
 
 /* look up white/black list for SPDIF over ac-link */
-static int __devinit check_default_spdif_aclink(struct pci_dev *pci)
+static int check_default_spdif_aclink(struct pci_dev *pci)
 {
 	const struct snd_pci_quirk *w;
 
@@ -3276,7 +3276,7 @@ static int __devinit check_default_spdif_aclink(struct pci_dev *pci)
 	return 0;
 }
 
-static int __devinit snd_intel8x0_probe(struct pci_dev *pci,
+static int snd_intel8x0_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index cb51181..32233ff 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -710,7 +710,7 @@ struct ich_pcm_table {
 	int ac97_idx;
 };
 
-static int __devinit snd_intel8x0m_pcm1(struct intel8x0m *chip, int device,
+static int snd_intel8x0m_pcm1(struct intel8x0m *chip, int device,
 				       struct ich_pcm_table *rec)
 {
 	struct snd_pcm *pcm;
@@ -759,7 +759,7 @@ static struct ich_pcm_table intel_pcms[] __devinitdata = {
 	},
 };
 
-static int __devinit snd_intel8x0m_pcm(struct intel8x0m *chip)
+static int snd_intel8x0m_pcm(struct intel8x0m *chip)
 {
 	int i, tblsize, device, err;
 	struct ich_pcm_table *tbl, *rec;
@@ -819,7 +819,7 @@ static void snd_intel8x0m_mixer_free_ac97(struct snd_ac97 *ac97)
 }
 
 
-static int __devinit snd_intel8x0m_mixer(struct intel8x0m *chip, int ac97_clock)
+static int snd_intel8x0m_mixer(struct intel8x0m *chip, int ac97_clock)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
@@ -1090,7 +1090,7 @@ static void snd_intel8x0m_proc_read(struct snd_info_entry * entry,
 			(tmp & (ICH_PCR | ICH_SCR | ICH_TCR)) == 0 ? " none" : "");
 }
 
-static void __devinit snd_intel8x0m_proc_init(struct intel8x0m * chip)
+static void snd_intel8x0m_proc_init(struct intel8x0m * chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1113,7 +1113,7 @@ struct ich_reg_info {
 	unsigned int offset;
 };
 
-static int __devinit snd_intel8x0m_create(struct snd_card *card,
+static int snd_intel8x0m_create(struct snd_card *card,
 					 struct pci_dev *pci,
 					 unsigned long device_type,
 					 struct intel8x0m **r_intel8x0m)
@@ -1275,7 +1275,7 @@ static struct shortname_table {
 	{ 0 },
 };
 
-static int __devinit snd_intel8x0m_probe(struct pci_dev *pci,
+static int snd_intel8x0m_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 1deabc6..3398453 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2083,7 +2083,7 @@ static void snd_korg1212_proc_read(struct snd_info_entry *entry,
         snd_iprintf(buffer, "    Error count: %ld\n", korg1212->totalerrorcnt);
 }
 
-static void __devinit snd_korg1212_proc_init(struct snd_korg1212 *korg1212)
+static void snd_korg1212_proc_init(struct snd_korg1212 *korg1212)
 {
 	struct snd_info_entry *entry;
 
@@ -2154,7 +2154,7 @@ static int snd_korg1212_dev_free(struct snd_device *device)
 	return snd_korg1212_free(korg1212);
 }
 
-static int __devinit snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
+static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
                                          struct snd_korg1212 ** rchip)
 
 {
@@ -2429,8 +2429,7 @@ static int __devinit snd_korg1212_create(struct snd_card *card, struct pci_dev *
  * Card initialisation
  */
 
-static int __devinit
-snd_korg1212_probe(struct pci_dev *pci,
+static int snd_korg1212_probe(struct pci_dev *pci,
 		const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index a72cca9..7be3dad 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -445,7 +445,7 @@ static void lola_reset_setups(struct lola *chip)
 	lola_setup_all_analog_gains(chip, PLAY, false); /* output, update */
 }
 
-static int __devinit lola_parse_tree(struct lola *chip)
+static int lola_parse_tree(struct lola *chip)
 {
 	unsigned int val;
 	int nid, err;
@@ -568,7 +568,7 @@ static int lola_dev_free(struct snd_device *device)
 	return 0;
 }
 
-static int __devinit lola_create(struct snd_card *card, struct pci_dev *pci,
+static int lola_create(struct snd_card *card, struct pci_dev *pci,
 				 int dev, struct lola **rchip)
 {
 	struct lola *chip;
@@ -702,7 +702,7 @@ static int __devinit lola_create(struct snd_card *card, struct pci_dev *pci,
 	return err;
 }
 
-static int __devinit lola_probe(struct pci_dev *pci,
+static int lola_probe(struct pci_dev *pci,
 				const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/lola/lola_clock.c b/sound/pci/lola/lola_clock.c
index 72f8ef0..eb1d6b9 100644
--- a/sound/pci/lola/lola_clock.c
+++ b/sound/pci/lola/lola_clock.c
@@ -120,7 +120,7 @@ int lola_set_granularity(struct lola *chip, unsigned int val, bool force)
  * Clock widget handling
  */
 
-int __devinit lola_init_clock_widget(struct lola *chip, int nid)
+int lola_init_clock_widget(struct lola *chip, int nid)
 {
 	unsigned int val;
 	int i, j, nitems, nb_verbs, idx, idx_list;
diff --git a/sound/pci/lola/lola_mixer.c b/sound/pci/lola/lola_mixer.c
index 6b8d648..2191935 100644
--- a/sound/pci/lola/lola_mixer.c
+++ b/sound/pci/lola/lola_mixer.c
@@ -28,7 +28,7 @@
 #include <sound/tlv.h>
 #include "lola.h"
 
-static int __devinit lola_init_pin(struct lola *chip, struct lola_pin *pin,
+static int lola_init_pin(struct lola *chip, struct lola_pin *pin,
 				   int dir, int nid)
 {
 	unsigned int val;
@@ -91,7 +91,7 @@ static int __devinit lola_init_pin(struct lola *chip, struct lola_pin *pin,
 	return 0;
 }
 
-int __devinit lola_init_pins(struct lola *chip, int dir, int *nidp)
+int lola_init_pins(struct lola *chip, int dir, int *nidp)
 {
 	int i, err, nid;
 	nid = *nidp;
@@ -112,7 +112,7 @@ void lola_free_mixer(struct lola *chip)
 		vfree(chip->mixer.array_saved);
 }
 
-int __devinit lola_init_mixer_widget(struct lola *chip, int nid)
+int lola_init_mixer_widget(struct lola *chip, int nid)
 {
 	unsigned int val;
 	int err;
@@ -590,7 +590,7 @@ static struct snd_kcontrol_new lola_analog_mixer __devinitdata = {
 	.tlv.c = lola_analog_vol_tlv,
 };
 
-static int __devinit create_analog_mixer(struct lola *chip, int dir, char *name)
+static int create_analog_mixer(struct lola *chip, int dir, char *name)
 {
 	if (!chip->pin[dir].num_pins)
 		return 0;
@@ -656,7 +656,7 @@ static struct snd_kcontrol_new lola_input_src_mixer __devinitdata = {
  * Lola16161 or Lola881 can have Hardware sample rate converters
  * on its digital input pins
  */
-static int __devinit create_input_src_mixer(struct lola *chip)
+static int create_input_src_mixer(struct lola *chip)
 {
 	if (!chip->input_src_caps_mask)
 		return 0;
@@ -736,7 +736,7 @@ static struct snd_kcontrol_new lola_src_gain_mixer __devinitdata = {
 	.tlv.p = lola_src_gain_tlv,
 };
 
-static int __devinit create_src_gain_mixer(struct lola *chip,
+static int create_src_gain_mixer(struct lola *chip,
 					   int num, int ofs, char *name)
 {
 	lola_src_gain_mixer.name = name;
@@ -823,7 +823,7 @@ static struct snd_kcontrol_new lola_dest_gain_mixer __devinitdata = {
 	.tlv.p = lola_dest_gain_tlv,
 };
 
-static int __devinit create_dest_gain_mixer(struct lola *chip,
+static int create_dest_gain_mixer(struct lola *chip,
 					    int src_num, int src_ofs,
 					    int num, int ofs, char *name)
 {
@@ -838,7 +838,7 @@ static int __devinit create_dest_gain_mixer(struct lola *chip,
 
 /*
  */
-int __devinit lola_create_mixer(struct lola *chip)
+int lola_create_mixer(struct lola *chip)
 {
 	int err;
 
diff --git a/sound/pci/lola/lola_pcm.c b/sound/pci/lola/lola_pcm.c
index c44db68..5ea85e8 100644
--- a/sound/pci/lola/lola_pcm.c
+++ b/sound/pci/lola/lola_pcm.c
@@ -597,7 +597,7 @@ static struct snd_pcm_ops lola_pcm_ops = {
 	.page = snd_pcm_sgbuf_ops_page,
 };
 
-int __devinit lola_create_pcm(struct lola *chip)
+int lola_create_pcm(struct lola *chip)
 {
 	struct snd_pcm *pcm;
 	int i, err;
@@ -690,7 +690,7 @@ static int lola_init_stream(struct lola *chip, struct lola_stream *str,
 	return 0;
 }
 
-int __devinit lola_init_pcm(struct lola *chip, int dir, int *nidp)
+int lola_init_pcm(struct lola *chip, int dir, int *nidp)
 {
 	struct lola_pcm *pcm = &chip->pcm[dir];
 	int i, nid, err;
diff --git a/sound/pci/lola/lola_proc.c b/sound/pci/lola/lola_proc.c
index 9d7daf8..04df83d 100644
--- a/sound/pci/lola/lola_proc.c
+++ b/sound/pci/lola/lola_proc.c
@@ -206,7 +206,7 @@ static void lola_proc_regs_read(struct snd_info_entry *entry,
 	}
 }
 
-void __devinit lola_proc_debug_new(struct lola *chip)
+void lola_proc_debug_new(struct lola *chip)
 {
 	struct snd_info_entry *entry;
 
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 62b378c..62ff221 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -578,7 +578,7 @@ static int snd_lx6464es_dev_free(struct snd_device *device)
 }
 
 /* reset the dsp during initialization */
-static int __devinit lx_init_xilinx_reset(struct lx6464es *chip)
+static int lx_init_xilinx_reset(struct lx6464es *chip)
 {
 	int i;
 	u32 plx_reg = lx_plx_reg_read(chip, ePLX_CHIPSC);
@@ -620,7 +620,7 @@ static int __devinit lx_init_xilinx_reset(struct lx6464es *chip)
 	return 0;
 }
 
-static int __devinit lx_init_xilinx_test(struct lx6464es *chip)
+static int lx_init_xilinx_test(struct lx6464es *chip)
 {
 	u32 reg;
 
@@ -650,7 +650,7 @@ static int __devinit lx_init_xilinx_test(struct lx6464es *chip)
 }
 
 /* initialize ethersound */
-static int __devinit lx_init_ethersound_config(struct lx6464es *chip)
+static int lx_init_ethersound_config(struct lx6464es *chip)
 {
 	int i;
 	u32 orig_conf_es = lx_dsp_reg_read(chip, eReg_CONFES);
@@ -690,7 +690,7 @@ static int __devinit lx_init_ethersound_config(struct lx6464es *chip)
 	return 0;
 }
 
-static int __devinit lx_init_get_version_features(struct lx6464es *chip)
+static int lx_init_get_version_features(struct lx6464es *chip)
 {
 	u32 dsp_version;
 
@@ -759,7 +759,7 @@ static int lx_set_granularity(struct lx6464es *chip, u32 gran)
 }
 
 /* initialize and test the xilinx dsp chip */
-static int __devinit lx_init_dsp(struct lx6464es *chip)
+static int lx_init_dsp(struct lx6464es *chip)
 {
 	int err;
 	int i;
@@ -835,7 +835,7 @@ static struct snd_pcm_ops lx_ops_capture = {
 	.pointer   = lx_pcm_stream_pointer,
 };
 
-static int __devinit lx_pcm_create(struct lx6464es *chip)
+static int lx_pcm_create(struct lx6464es *chip)
 {
 	int err;
 	struct snd_pcm *pcm;
@@ -954,7 +954,7 @@ static void lx_proc_levels_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "\n");
 }
 
-static int __devinit lx_proc_create(struct snd_card *card, struct lx6464es *chip)
+static int lx_proc_create(struct snd_card *card, struct lx6464es *chip)
 {
 	struct snd_info_entry *entry;
 	int err = snd_card_proc_new(card, "levels", &entry);
@@ -966,7 +966,7 @@ static int __devinit lx_proc_create(struct snd_card *card, struct lx6464es *chip
 }
 
 
-static int __devinit snd_lx6464es_create(struct snd_card *card,
+static int snd_lx6464es_create(struct snd_card *card,
 					 struct pci_dev *pci,
 					 struct lx6464es **rchip)
 {
@@ -1082,7 +1082,7 @@ alloc_failed:
 	return err;
 }
 
-static int __devinit snd_lx6464es_probe(struct pci_dev *pci,
+static int snd_lx6464es_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 8c3e7fc..633c860 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -385,7 +385,7 @@ polling_successful:
 
 
 /* low-level dsp access */
-int __devinit lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
+int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 {
 	u16 ret;
 	unsigned long flags;
diff --git a/sound/pci/lx6464es/lx_core.h b/sound/pci/lx6464es/lx_core.h
index 4d7ff79..5ec5e04 100644
--- a/sound/pci/lx6464es/lx_core.h
+++ b/sound/pci/lx6464es/lx_core.h
@@ -109,7 +109,7 @@ struct lx_rmh {
 
 
 /* low-level dsp access */
-int __devinit lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version);
+int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version);
 int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq);
 int lx_dsp_set_granularity(struct lx6464es *chip, u32 gran);
 int lx_dsp_read_async_events(struct lx6464es *chip, u32 *data);
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 8b76a52..7dc0cc8 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -1856,8 +1856,7 @@ static struct snd_pcm_ops snd_m3_capture_ops = {
 	.pointer =	snd_m3_pcm_pointer,
 };
 
-static int __devinit
-snd_m3_pcm(struct snd_m3 * chip, int device)
+static int snd_m3_pcm(struct snd_m3 * chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -2031,7 +2030,7 @@ static void snd_m3_ac97_reset(struct snd_m3 *chip)
 #endif
 }
 
-static int __devinit snd_m3_mixer(struct snd_m3 *chip)
+static int snd_m3_mixer(struct snd_m3 *chip)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
@@ -2173,7 +2172,7 @@ static void snd_m3_assp_init(struct snd_m3 *chip)
 }
 
 
-static int __devinit snd_m3_assp_client_init(struct snd_m3 *chip, struct m3_dma *s, int index)
+static int snd_m3_assp_client_init(struct snd_m3 *chip, struct m3_dma *s, int index)
 {
 	int data_bytes = 2 * ( MINISRC_TMP_BUFFER_SIZE / 2 + 
 			       MINISRC_IN_BUFFER_SIZE / 2 +
@@ -2488,7 +2487,7 @@ static SIMPLE_DEV_PM_OPS(m3_pm, m3_suspend, m3_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_SND_MAESTRO3_INPUT
-static int __devinit snd_m3_input_register(struct snd_m3 *chip)
+static int snd_m3_input_register(struct snd_m3 *chip)
 {
 	struct input_dev *input_dev;
 	int err;
@@ -2532,8 +2531,7 @@ static int snd_m3_dev_free(struct snd_device *device)
 	return snd_m3_free(chip);
 }
 
-static int __devinit
-snd_m3_create(struct snd_card *card, struct pci_dev *pci,
+static int snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 	      int enable_amp,
 	      int amp_gpio,
 	      struct snd_m3 **chip_ret)
@@ -2700,8 +2698,7 @@ snd_m3_create(struct snd_card *card, struct pci_dev *pci,
 
 /*
  */
-static int __devinit
-snd_m3_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+static int snd_m3_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index c5becc9..f744df5 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1004,7 +1004,7 @@ static int snd_mixart_chip_dev_free(struct snd_device *device)
 
 /*
  */
-static int __devinit snd_mixart_create(struct mixart_mgr *mgr, struct snd_card *card, int idx)
+static int snd_mixart_create(struct mixart_mgr *mgr, struct snd_card *card, int idx)
 {
 	int err;
 	struct snd_mixart *chip;
@@ -1180,7 +1180,7 @@ static void snd_mixart_proc_read(struct snd_info_entry *entry,
 	} /* endif elf loaded */
 }
 
-static void __devinit snd_mixart_proc_init(struct snd_mixart *chip)
+static void snd_mixart_proc_init(struct snd_mixart *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1209,7 +1209,7 @@ static void __devinit snd_mixart_proc_init(struct snd_mixart *chip)
 /*
  *    probe function - creates the card manager
  */
-static int __devinit snd_mixart_probe(struct pci_dev *pci,
+static int snd_mixart_probe(struct pci_dev *pci,
 				      const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 77b1811..6c06e85 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -928,8 +928,7 @@ static struct snd_pcm_ops snd_nm256_capture_ops = {
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-static int __devinit
-snd_nm256_pcm(struct nm256 *chip, int device)
+static int snd_nm256_pcm(struct nm256 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int i, err;
@@ -1295,8 +1294,7 @@ snd_nm256_ac97_reset(struct snd_ac97 *ac97)
 }
 
 /* create an ac97 mixer interface */
-static int __devinit
-snd_nm256_mixer(struct nm256 *chip)
+static int snd_nm256_mixer(struct nm256 *chip)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
@@ -1336,8 +1334,7 @@ snd_nm256_mixer(struct nm256 *chip)
  * RAM.
  */
 
-static int __devinit
-snd_nm256_peek_for_sig(struct nm256 *chip)
+static int snd_nm256_peek_for_sig(struct nm256 *chip)
 {
 	/* The signature is located 1K below the end of video RAM.  */
 	void __iomem *temp;
@@ -1472,8 +1469,7 @@ static int snd_nm256_dev_free(struct snd_device *device)
 	return snd_nm256_free(chip);
 }
 
-static int __devinit
-snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
+static int snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 		 struct nm256 **chip_ret)
 {
 	struct nm256 *chip;
@@ -1650,7 +1646,7 @@ static struct snd_pci_quirk nm256_quirks[] __devinitdata = {
 };
 
 
-static int __devinit snd_nm256_probe(struct pci_dev *pci,
+static int snd_nm256_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
index d061c79..7fbe1cb 100644
--- a/sound/pci/oxygen/oxygen.c
+++ b/sound/pci/oxygen/oxygen.c
@@ -756,7 +756,7 @@ static const struct oxygen_model model_generic = {
 	.adc_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
 };
 
-static int __devinit get_oxygen_model(struct oxygen *chip,
+static int get_oxygen_model(struct oxygen *chip,
 				      const struct pci_device_id *id)
 {
 	static const char *const names[] = {
@@ -848,7 +848,7 @@ static int __devinit get_oxygen_model(struct oxygen *chip,
 	return 0;
 }
 
-static int __devinit generic_oxygen_probe(struct pci_dev *pci,
+static int generic_oxygen_probe(struct pci_dev *pci,
 					  const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/oxygen/virtuoso.c b/sound/pci/oxygen/virtuoso.c
index ebae284..4a29c3a 100644
--- a/sound/pci/oxygen/virtuoso.c
+++ b/sound/pci/oxygen/virtuoso.c
@@ -58,7 +58,7 @@ static DEFINE_PCI_DEVICE_TABLE(xonar_ids) = {
 };
 MODULE_DEVICE_TABLE(pci, xonar_ids);
 
-static int __devinit get_xonar_model(struct oxygen *chip,
+static int get_xonar_model(struct oxygen *chip,
 				     const struct pci_device_id *id)
 {
 	if (get_xonar_pcm179x_model(chip, id) >= 0)
@@ -70,7 +70,7 @@ static int __devinit get_xonar_model(struct oxygen *chip,
 	return -EINVAL;
 }
 
-static int __devinit xonar_probe(struct pci_dev *pci,
+static int xonar_probe(struct pci_dev *pci,
 				 const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/oxygen/xonar_cs43xx.c b/sound/pci/oxygen/xonar_cs43xx.c
index c8febf4..babb5ea 100644
--- a/sound/pci/oxygen/xonar_cs43xx.c
+++ b/sound/pci/oxygen/xonar_cs43xx.c
@@ -431,7 +431,7 @@ static const struct oxygen_model model_xonar_d1 = {
 	.adc_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
 };
 
-int __devinit get_xonar_cs43xx_model(struct oxygen *chip,
+int get_xonar_cs43xx_model(struct oxygen *chip,
 				     const struct pci_device_id *id)
 {
 	switch (id->subdevice) {
diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
index 8433aa7..60785a6 100644
--- a/sound/pci/oxygen/xonar_pcm179x.c
+++ b/sound/pci/oxygen/xonar_pcm179x.c
@@ -1087,7 +1087,7 @@ static const struct oxygen_model model_xonar_st = {
 	.adc_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
 };
 
-int __devinit get_xonar_pcm179x_model(struct oxygen *chip,
+int get_xonar_pcm179x_model(struct oxygen *chip,
 				      const struct pci_device_id *id)
 {
 	switch (id->subdevice) {
diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
index b555b62..9fe2ed9 100644
--- a/sound/pci/oxygen/xonar_wm87x6.c
+++ b/sound/pci/oxygen/xonar_wm87x6.c
@@ -1320,7 +1320,7 @@ static const struct oxygen_model model_xonar_hdav_slim = {
 	.adc_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
 };
 
-int __devinit get_xonar_wm87x6_model(struct oxygen *chip,
+int get_xonar_wm87x6_model(struct oxygen *chip,
 				     const struct pci_device_id *id)
 {
 	switch (id->subdevice) {
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 2007a33..cc2008a 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1203,7 +1203,7 @@ static int pcxhr_chip_dev_free(struct snd_device *device)
 
 /*
  */
-static int __devinit pcxhr_create(struct pcxhr_mgr *mgr,
+static int pcxhr_create(struct pcxhr_mgr *mgr,
 				  struct snd_card *card, int idx)
 {
 	int err;
@@ -1453,7 +1453,7 @@ static void pcxhr_proc_ltc(struct snd_info_entry *entry,
 	}
 }
 
-static void __devinit pcxhr_proc_init(struct snd_pcxhr *chip)
+static void pcxhr_proc_init(struct snd_pcxhr *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1513,7 +1513,7 @@ static int pcxhr_free(struct pcxhr_mgr *mgr)
 /*
  *    probe function - creates the card manager
  */
-static int __devinit pcxhr_probe(struct pci_dev *pci,
+static int pcxhr_probe(struct pci_dev *pci,
 				 const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 9638a5a..42da7d5 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1706,8 +1706,7 @@ static struct snd_pcm_ops snd_riptide_capture_ops = {
 	.pointer = snd_riptide_pointer,
 };
 
-static int __devinit
-snd_riptide_pcm(struct snd_riptide *chip, int device, struct snd_pcm **rpcm)
+static int snd_riptide_pcm(struct snd_riptide *chip, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1857,8 +1856,7 @@ static int snd_riptide_dev_free(struct snd_device *device)
 	return snd_riptide_free(chip);
 }
 
-static int __devinit
-snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
+static int snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 		   struct snd_riptide **rchip)
 {
 	struct snd_riptide *chip;
@@ -1993,7 +1991,7 @@ snd_riptide_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "\n");
 }
 
-static void __devinit snd_riptide_proc_init(struct snd_riptide *chip)
+static void snd_riptide_proc_init(struct snd_riptide *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -2001,7 +1999,7 @@ static void __devinit snd_riptide_proc_init(struct snd_riptide *chip)
 		snd_info_set_text_ops(entry, chip, snd_riptide_proc_read);
 }
 
-static int __devinit snd_riptide_mixer(struct snd_riptide *chip)
+static int snd_riptide_mixer(struct snd_riptide *chip)
 {
 	struct snd_ac97_bus *pbus;
 	struct snd_ac97_template ac97;
@@ -2027,8 +2025,7 @@ static int __devinit snd_riptide_mixer(struct snd_riptide *chip)
 
 #ifdef SUPPORT_JOYSTICK
 
-static int __devinit
-snd_riptide_joystick_probe(struct pci_dev *pci, const struct pci_device_id *id)
+static int snd_riptide_joystick_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	static int dev;
 	struct gameport *gameport;
@@ -2071,8 +2068,7 @@ static void __devexit snd_riptide_joystick_remove(struct pci_dev *pci)
 }
 #endif
 
-static int __devinit
-snd_card_riptide_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+static int snd_card_riptide_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index d7db4d3..1378c3c 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1332,7 +1332,7 @@ snd_rme32_free_adat_pcm(struct snd_pcm *pcm)
 	rme32->adat_pcm = NULL;
 }
 
-static int __devinit snd_rme32_create(struct rme32 * rme32)
+static int snd_rme32_create(struct rme32 * rme32)
 {
 	struct pci_dev *pci = rme32->pci;
 	int err;
@@ -1554,7 +1554,7 @@ snd_rme32_proc_read(struct snd_info_entry * entry, struct snd_info_buffer *buffe
 	}
 }
 
-static void __devinit snd_rme32_proc_init(struct rme32 * rme32)
+static void snd_rme32_proc_init(struct rme32 * rme32)
 {
 	struct snd_info_entry *entry;
 
@@ -1922,8 +1922,7 @@ static void snd_rme32_card_free(struct snd_card *card)
 	snd_rme32_free(card->private_data);
 }
 
-static int __devinit
-snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+static int snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct rme32 *rme32;
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 4486e75..c145d80 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -270,7 +270,7 @@ snd_rme96_playback_pointer(struct snd_pcm_substream *substream);
 static snd_pcm_uframes_t
 snd_rme96_capture_pointer(struct snd_pcm_substream *substream);
 
-static void __devinit 
+static void
 snd_rme96_proc_init(struct rme96 *rme96);
 
 static int
@@ -1538,8 +1538,7 @@ snd_rme96_free_adat_pcm(struct snd_pcm *pcm)
 	rme96->adat_pcm = NULL;
 }
 
-static int __devinit
-snd_rme96_create(struct rme96 *rme96)
+static int snd_rme96_create(struct rme96 *rme96)
 {
 	struct pci_dev *pci = rme96->pci;
 	int err;
@@ -1786,7 +1785,7 @@ snd_rme96_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer
 	}
 }
 
-static void __devinit 
+static void
 snd_rme96_proc_init(struct rme96 *rme96)
 {
 	struct snd_info_entry *entry;
@@ -2326,8 +2325,7 @@ static void snd_rme96_card_free(struct snd_card *card)
 	snd_rme96_free(card->private_data);
 }
 
-static int __devinit
-snd_rme96_probe(struct pci_dev *pci,
+static int snd_rme96_probe(struct pci_dev *pci,
 		const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 916aff1..bff2f60 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4020,7 +4020,7 @@ static void snd_hdsp_free_buffers(struct hdsp *hdsp)
 	snd_hammerfall_free_buffer(&hdsp->playback_dma_buf, hdsp->pci);
 }
 
-static int __devinit snd_hdsp_initialize_memory(struct hdsp *hdsp)
+static int snd_hdsp_initialize_memory(struct hdsp *hdsp)
 {
 	unsigned long pb_bus, cb_bus;
 
@@ -5408,7 +5408,7 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 }
 #endif
 
-static int __devinit snd_hdsp_create(struct snd_card *card,
+static int snd_hdsp_create(struct snd_card *card,
 				     struct hdsp *hdsp)
 {
 	struct pci_dev *pci = hdsp->pci;
@@ -5586,7 +5586,7 @@ static void snd_hdsp_card_free(struct snd_card *card)
 		snd_hdsp_free(hdsp);
 }
 
-static int __devinit snd_hdsp_probe(struct pci_dev *pci,
+static int snd_hdsp_probe(struct pci_dev *pci,
 				    const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 2435cb5..4724808 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -962,9 +962,9 @@ static DEFINE_PCI_DEVICE_TABLE(snd_hdspm_ids) = {
 MODULE_DEVICE_TABLE(pci, snd_hdspm_ids);
 
 /* prototypes */
-static int __devinit snd_hdspm_create_alsa_devices(struct snd_card *card,
+static int snd_hdspm_create_alsa_devices(struct snd_card *card,
 						   struct hdspm * hdspm);
-static int __devinit snd_hdspm_create_pcm(struct snd_card *card,
+static int snd_hdspm_create_pcm(struct snd_card *card,
 					  struct hdspm * hdspm);
 
 static inline void snd_hdspm_initialize_midi_flush(struct hdspm *hdspm);
@@ -1845,7 +1845,7 @@ static struct snd_rawmidi_ops snd_hdspm_midi_input =
 	.trigger =	snd_hdspm_midi_input_trigger,
 };
 
-static int __devinit snd_hdspm_create_midi (struct snd_card *card,
+static int snd_hdspm_create_midi (struct snd_card *card,
 					    struct hdspm *hdspm, int id)
 {
 	int err;
@@ -5233,7 +5233,7 @@ static void snd_hdspm_proc_ports_out(struct snd_info_entry *entry,
 }
 
 
-static void __devinit snd_hdspm_proc_init(struct hdspm *hdspm)
+static void snd_hdspm_proc_init(struct hdspm *hdspm)
 {
 	struct snd_info_entry *entry;
 
@@ -6369,7 +6369,7 @@ static struct snd_pcm_ops snd_hdspm_capture_ops = {
 	.page = snd_pcm_sgbuf_ops_page,
 };
 
-static int __devinit snd_hdspm_create_hwdep(struct snd_card *card,
+static int snd_hdspm_create_hwdep(struct snd_card *card,
 					    struct hdspm * hdspm)
 {
 	struct snd_hwdep *hw;
@@ -6395,7 +6395,7 @@ static int __devinit snd_hdspm_create_hwdep(struct snd_card *card,
 /*------------------------------------------------------------
    memory interface
  ------------------------------------------------------------*/
-static int __devinit snd_hdspm_preallocate_memory(struct hdspm *hdspm)
+static int snd_hdspm_preallocate_memory(struct hdspm *hdspm)
 {
 	int err;
 	struct snd_pcm *pcm;
@@ -6436,7 +6436,7 @@ static void hdspm_set_sgbuf(struct hdspm *hdspm,
 
 
 /* ------------- ALSA Devices ---------------------------- */
-static int __devinit snd_hdspm_create_pcm(struct snd_card *card,
+static int snd_hdspm_create_pcm(struct snd_card *card,
 					  struct hdspm *hdspm)
 {
 	struct snd_pcm *pcm;
@@ -6472,7 +6472,7 @@ static inline void snd_hdspm_initialize_midi_flush(struct hdspm * hdspm)
 		snd_hdspm_flush_midi_input(hdspm, i);
 }
 
-static int __devinit snd_hdspm_create_alsa_devices(struct snd_card *card,
+static int snd_hdspm_create_alsa_devices(struct snd_card *card,
 						   struct hdspm * hdspm)
 {
 	int err, i;
@@ -6531,7 +6531,7 @@ static int __devinit snd_hdspm_create_alsa_devices(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit snd_hdspm_create(struct snd_card *card,
+static int snd_hdspm_create(struct snd_card *card,
 		struct hdspm *hdspm) {
 
 	struct pci_dev *pci = hdspm->pci;
@@ -6905,7 +6905,7 @@ static void snd_hdspm_card_free(struct snd_card *card)
 }
 
 
-static int __devinit snd_hdspm_probe(struct pci_dev *pci,
+static int snd_hdspm_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 125d745..077cfb7 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -1757,7 +1757,7 @@ snd_rme9652_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buff
 	snd_iprintf(buffer, "\n");
 }
 
-static void __devinit snd_rme9652_proc_init(struct snd_rme9652 *rme9652)
+static void snd_rme9652_proc_init(struct snd_rme9652 *rme9652)
 {
 	struct snd_info_entry *entry;
 
@@ -1788,7 +1788,7 @@ static int snd_rme9652_free(struct snd_rme9652 *rme9652)
 	return 0;
 }
 
-static int __devinit snd_rme9652_initialize_memory(struct snd_rme9652 *rme9652)
+static int snd_rme9652_initialize_memory(struct snd_rme9652 *rme9652)
 {
 	unsigned long pb_bus, cb_bus;
 
@@ -2414,7 +2414,7 @@ static struct snd_pcm_ops snd_rme9652_capture_ops = {
 	.copy =		snd_rme9652_capture_copy,
 };
 
-static int __devinit snd_rme9652_create_pcm(struct snd_card *card,
+static int snd_rme9652_create_pcm(struct snd_card *card,
 					 struct snd_rme9652 *rme9652)
 {
 	struct snd_pcm *pcm;
@@ -2438,7 +2438,7 @@ static int __devinit snd_rme9652_create_pcm(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit snd_rme9652_create(struct snd_card *card,
+static int snd_rme9652_create(struct snd_card *card,
 				     struct snd_rme9652 *rme9652,
 				     int precise_ptr)
 {
@@ -2578,7 +2578,7 @@ static void snd_rme9652_card_free(struct snd_card *card)
 		snd_rme9652_free(rme9652);
 }
 
-static int __devinit snd_rme9652_probe(struct pci_dev *pci,
+static int snd_rme9652_probe(struct pci_dev *pci,
 				       const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index e1786ef..8548deb 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -894,7 +894,7 @@ static struct snd_pcm_ops sis_capture_ops = {
 	.pointer = sis_pcm_pointer,
 };
 
-static int __devinit sis_pcm_create(struct sis7019 *sis)
+static int sis_pcm_create(struct sis7019 *sis)
 {
 	struct snd_pcm *pcm;
 	int rc;
@@ -1013,7 +1013,7 @@ static unsigned short sis_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 					(reg << 8) | cmd[ac97->num]);
 }
 
-static int __devinit sis_mixer_create(struct sis7019 *sis)
+static int sis_mixer_create(struct sis7019 *sis)
 {
 	struct snd_ac97_bus *bus;
 	struct snd_ac97_template ac97;
@@ -1326,7 +1326,7 @@ static int sis_alloc_suspend(struct sis7019 *sis)
 	return 0;
 }
 
-static int __devinit sis_chip_create(struct snd_card *card,
+static int sis_chip_create(struct snd_card *card,
 					struct pci_dev *pci)
 {
 	struct sis7019 *sis = card->private_data;
@@ -1417,7 +1417,7 @@ error_out:
 	return rc;
 }
 
-static int __devinit snd_sis7019_probe(struct pci_dev *pci,
+static int snd_sis7019_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index bc5ca1d2..ead7218 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -877,7 +877,7 @@ static struct snd_pcm_ops snd_sonicvibes_capture_ops = {
 	.pointer =	snd_sonicvibes_capture_pointer,
 };
 
-static int __devinit snd_sonicvibes_pcm(struct sonicvibes * sonic, int device, struct snd_pcm ** rpcm)
+static int snd_sonicvibes_pcm(struct sonicvibes * sonic, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1118,7 +1118,7 @@ static void snd_sonicvibes_master_free(struct snd_kcontrol *kcontrol)
 	sonic->master_volume = NULL;
 }
 
-static int __devinit snd_sonicvibes_mixer(struct sonicvibes * sonic)
+static int snd_sonicvibes_mixer(struct sonicvibes * sonic)
 {
 	struct snd_card *card;
 	struct snd_kcontrol *kctl;
@@ -1175,7 +1175,7 @@ static void snd_sonicvibes_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "MIDI to ext. Tx  : %s\n", tmp & 0x04 ? "on" : "off");
 }
 
-static void __devinit snd_sonicvibes_proc_init(struct sonicvibes * sonic)
+static void snd_sonicvibes_proc_init(struct sonicvibes * sonic)
 {
 	struct snd_info_entry *entry;
 
@@ -1191,7 +1191,7 @@ static void __devinit snd_sonicvibes_proc_init(struct sonicvibes * sonic)
 static struct snd_kcontrol_new snd_sonicvibes_game_control __devinitdata =
 SONICVIBES_SINGLE("Joystick Speed", 0, SV_IREG_GAME_PORT, 1, 15, 0);
 
-static int __devinit snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
+static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
 {
 	struct gameport *gp;
 
@@ -1246,7 +1246,7 @@ static int snd_sonicvibes_dev_free(struct snd_device *device)
 	return snd_sonicvibes_free(sonic);
 }
 
-static int __devinit snd_sonicvibes_create(struct snd_card *card,
+static int snd_sonicvibes_create(struct snd_card *card,
 					struct pci_dev *pci,
 					int reverb,
 					int mge,
@@ -1422,7 +1422,7 @@ static void snd_sonicvibes_midi_input_close(struct snd_mpu401 * mpu)
 	outb(sonic->irqmask |= SV_MIDI_MASK, SV_REG(sonic, IRQMASK));
 }
 
-static int __devinit snd_sonicvibes_midi(struct sonicvibes * sonic,
+static int snd_sonicvibes_midi(struct sonicvibes * sonic,
 					 struct snd_rawmidi *rmidi)
 {
 	struct snd_mpu401 * mpu = rmidi->private_data;
@@ -1441,7 +1441,7 @@ static int __devinit snd_sonicvibes_midi(struct sonicvibes * sonic,
 	return 0;
 }
 
-static int __devinit snd_sonic_probe(struct pci_dev *pci,
+static int snd_sonic_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index 8cec678..7594bc2 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -73,7 +73,7 @@ static DEFINE_PCI_DEVICE_TABLE(snd_trident_ids) = {
 
 MODULE_DEVICE_TABLE(pci, snd_trident_ids);
 
-static int __devinit snd_trident_probe(struct pci_dev *pci,
+static int snd_trident_probe(struct pci_dev *pci,
 				       const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 06b10d1..1bf070b 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -2171,7 +2171,7 @@ static struct snd_pcm_ops snd_trident_spdif_7018_ops = {
   
   ---------------------------------------------------------------------------*/
 
-int __devinit snd_trident_pcm(struct snd_trident * trident,
+int snd_trident_pcm(struct snd_trident * trident,
 			      int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
@@ -2229,7 +2229,7 @@ int __devinit snd_trident_pcm(struct snd_trident * trident,
   
   ---------------------------------------------------------------------------*/
 
-int __devinit snd_trident_foldback_pcm(struct snd_trident * trident,
+int snd_trident_foldback_pcm(struct snd_trident * trident,
 				       int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *foldback;
@@ -2286,7 +2286,7 @@ int __devinit snd_trident_foldback_pcm(struct snd_trident * trident,
   
   ---------------------------------------------------------------------------*/
 
-int __devinit snd_trident_spdif_pcm(struct snd_trident * trident,
+int snd_trident_spdif_pcm(struct snd_trident * trident,
 				    int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *spdif;
@@ -2972,7 +2972,7 @@ static int snd_trident_pcm_mixer_free(struct snd_trident *trident, struct snd_tr
   
   ---------------------------------------------------------------------------*/
 
-static int __devinit snd_trident_mixer(struct snd_trident * trident, int pcm_spdif_device)
+static int snd_trident_mixer(struct snd_trident * trident, int pcm_spdif_device)
 {
 	struct snd_ac97_template _ac97;
 	struct snd_card *card = trident->card;
@@ -3191,7 +3191,7 @@ static int snd_trident_gameport_open(struct gameport *gameport, int mode)
 	}
 }
 
-int __devinit snd_trident_create_gameport(struct snd_trident *chip)
+int snd_trident_create_gameport(struct snd_trident *chip)
 {
 	struct gameport *gp;
 
@@ -3225,7 +3225,7 @@ static inline void snd_trident_free_gameport(struct snd_trident *chip)
 	}
 }
 #else
-int __devinit snd_trident_create_gameport(struct snd_trident *chip) { return -ENOSYS; }
+int snd_trident_create_gameport(struct snd_trident *chip) { return -ENOSYS; }
 static inline void snd_trident_free_gameport(struct snd_trident *chip) { }
 #endif /* CONFIG_GAMEPORT */
 
@@ -3329,7 +3329,7 @@ static void snd_trident_proc_read(struct snd_info_entry *entry,
 	}
 }
 
-static void __devinit snd_trident_proc_init(struct snd_trident * trident)
+static void snd_trident_proc_init(struct snd_trident * trident)
 {
 	struct snd_info_entry *entry;
 	const char *s = "trident";
@@ -3358,7 +3358,7 @@ static int snd_trident_dev_free(struct snd_device *device)
   
   ---------------------------------------------------------------------------*/
 
-static int __devinit snd_trident_tlb_alloc(struct snd_trident *trident)
+static int snd_trident_tlb_alloc(struct snd_trident *trident)
 {
 	int i;
 
@@ -3539,7 +3539,7 @@ static int snd_trident_sis_init(struct snd_trident *trident)
   
   ---------------------------------------------------------------------------*/
 
-int __devinit snd_trident_create(struct snd_card *card,
+int snd_trident_create(struct snd_card *card,
 		       struct pci_dev *pci,
 		       int pcm_streams,
 		       int pcm_spdif_device,
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 5312cb2..7ac1fe2 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1437,7 +1437,7 @@ static void init_viadev(struct via82xx *chip, int idx, unsigned int reg_offset,
 /*
  * create pcm instances for VIA8233, 8233C and 8235 (not 8233A)
  */
-static int __devinit snd_via8233_pcm_new(struct via82xx *chip)
+static int snd_via8233_pcm_new(struct via82xx *chip)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_chmap *chmap;
@@ -1505,7 +1505,7 @@ static int __devinit snd_via8233_pcm_new(struct via82xx *chip)
 /*
  * create pcm instances for VIA8233A
  */
-static int __devinit snd_via8233a_pcm_new(struct via82xx *chip)
+static int snd_via8233a_pcm_new(struct via82xx *chip)
 {
 	struct snd_pcm *pcm;
 	struct snd_pcm_chmap *chmap;
@@ -1566,7 +1566,7 @@ static int __devinit snd_via8233a_pcm_new(struct via82xx *chip)
 /*
  * create a pcm instance for via686a/b
  */
-static int __devinit snd_via686_pcm_new(struct via82xx *chip)
+static int snd_via686_pcm_new(struct via82xx *chip)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1895,7 +1895,7 @@ static struct ac97_quirk ac97_quirks[] = {
 	{ } /* terminator */
 };
 
-static int __devinit snd_via82xx_mixer_new(struct via82xx *chip, const char *quirk_override)
+static int snd_via82xx_mixer_new(struct via82xx *chip, const char *quirk_override)
 {
 	struct snd_ac97_template ac97;
 	int err;
@@ -1930,7 +1930,7 @@ static int __devinit snd_via82xx_mixer_new(struct via82xx *chip, const char *qui
 
 #ifdef SUPPORT_JOYSTICK
 #define JOYSTICK_ADDR	0x200
-static int __devinit snd_via686_create_gameport(struct via82xx *chip, unsigned char *legacy)
+static int snd_via686_create_gameport(struct via82xx *chip, unsigned char *legacy)
 {
 	struct gameport *gp;
 	struct resource *r;
@@ -1990,7 +1990,7 @@ static inline void snd_via686_free_gameport(struct via82xx *chip) { }
  *
  */
 
-static int __devinit snd_via8233_init_misc(struct via82xx *chip)
+static int snd_via8233_init_misc(struct via82xx *chip)
 {
 	int i, err, caps;
 	unsigned char val;
@@ -2047,7 +2047,7 @@ static int __devinit snd_via8233_init_misc(struct via82xx *chip)
 	return 0;
 }
 
-static int __devinit snd_via686_init_misc(struct via82xx *chip)
+static int snd_via686_init_misc(struct via82xx *chip)
 {
 	unsigned char legacy, legacy_cfg;
 	int rev_h = 0;
@@ -2137,7 +2137,7 @@ static void snd_via82xx_proc_read(struct snd_info_entry *entry,
 	}
 }
 
-static void __devinit snd_via82xx_proc_init(struct via82xx *chip)
+static void snd_via82xx_proc_init(struct via82xx *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -2370,7 +2370,7 @@ static int snd_via82xx_dev_free(struct snd_device *device)
 	return snd_via82xx_free(chip);
 }
 
-static int __devinit snd_via82xx_create(struct snd_card *card,
+static int snd_via82xx_create(struct snd_card *card,
 					struct pci_dev *pci,
 					int chip_type,
 					int revision,
@@ -2510,7 +2510,7 @@ static struct snd_pci_quirk dxs_whitelist[] __devinitdata = {
 	{ } /* terminator */
 };
 
-static int __devinit check_dxs_list(struct pci_dev *pci, int revision)
+static int check_dxs_list(struct pci_dev *pci, int revision)
 {
 	const struct snd_pci_quirk *w;
 
@@ -2535,7 +2535,7 @@ static int __devinit check_dxs_list(struct pci_dev *pci, int revision)
 	return VIA_DXS_48K;
 };
 
-static int __devinit snd_via82xx_probe(struct pci_dev *pci,
+static int snd_via82xx_probe(struct pci_dev *pci,
 				       const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index fa2ecc2..a7f5c64 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -836,7 +836,7 @@ static void init_viadev(struct via82xx_modem *chip, int idx, unsigned int reg_of
 /*
  * create a pcm instance for via686a/b
  */
-static int __devinit snd_via686_pcm_new(struct via82xx_modem *chip)
+static int snd_via686_pcm_new(struct via82xx_modem *chip)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -885,7 +885,7 @@ static void snd_via82xx_mixer_free_ac97(struct snd_ac97 *ac97)
 }
 
 
-static int __devinit snd_via82xx_mixer_new(struct via82xx_modem *chip)
+static int snd_via82xx_mixer_new(struct via82xx_modem *chip)
 {
 	struct snd_ac97_template ac97;
 	int err;
@@ -928,7 +928,7 @@ static void snd_via82xx_proc_read(struct snd_info_entry *entry, struct snd_info_
 	}
 }
 
-static void __devinit snd_via82xx_proc_init(struct via82xx_modem *chip)
+static void snd_via82xx_proc_init(struct via82xx_modem *chip)
 {
 	struct snd_info_entry *entry;
 
@@ -1103,7 +1103,7 @@ static int snd_via82xx_dev_free(struct snd_device *device)
 	return snd_via82xx_free(chip);
 }
 
-static int __devinit snd_via82xx_create(struct snd_card *card,
+static int snd_via82xx_create(struct snd_card *card,
 					struct pci_dev *pci,
 					int chip_type,
 					int revision,
@@ -1168,7 +1168,7 @@ static int __devinit snd_via82xx_create(struct snd_card *card,
 }
 
 
-static int __devinit snd_via82xx_probe(struct pci_dev *pci,
+static int snd_via82xx_probe(struct pci_dev *pci,
 				       const struct pci_device_id *pci_id)
 {
 	struct snd_card *card;
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 22d3f92..6d4fbcf 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -134,7 +134,7 @@ static int snd_vx222_dev_free(struct snd_device *device)
 }
 
 
-static int __devinit snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
+static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 				      struct snd_vx_hardware *hw,
 				      struct snd_vx222 **rchip)
 {
@@ -188,7 +188,7 @@ static int __devinit snd_vx222_create(struct snd_card *card, struct pci_dev *pci
 }
 
 
-static int __devinit snd_vx222_probe(struct pci_dev *pci,
+static int snd_vx222_probe(struct pci_dev *pci,
 				     const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index d5ccc2d..2dbb55f 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -79,7 +79,7 @@ static DEFINE_PCI_DEVICE_TABLE(snd_ymfpci_ids) = {
 MODULE_DEVICE_TABLE(pci, snd_ymfpci_ids);
 
 #ifdef SUPPORT_JOYSTICK
-static int __devinit snd_ymfpci_create_gameport(struct snd_ymfpci *chip, int dev,
+static int snd_ymfpci_create_gameport(struct snd_ymfpci *chip, int dev,
 						int legacy_ctrl, int legacy_ctrl2)
 {
 	struct gameport *gp;
@@ -167,7 +167,7 @@ static inline int snd_ymfpci_create_gameport(struct snd_ymfpci *chip, int dev, i
 void snd_ymfpci_free_gameport(struct snd_ymfpci *chip) { }
 #endif /* SUPPORT_JOYSTICK */
 
-static int __devinit snd_card_ymfpci_probe(struct pci_dev *pci,
+static int snd_card_ymfpci_probe(struct pci_dev *pci,
 					   const struct pci_device_id *pci_id)
 {
 	static int dev;
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 3a6f03f..b947594 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -598,7 +598,7 @@ static void snd_ymfpci_pcm_init_voice(struct snd_ymfpci_pcm *ypcm, unsigned int
 	}
 }
 
-static int __devinit snd_ymfpci_ac3_init(struct snd_ymfpci *chip)
+static int snd_ymfpci_ac3_init(struct snd_ymfpci *chip)
 {
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(chip->pci),
 				4096, &chip->ac3_tmp_base) < 0)
@@ -1144,7 +1144,7 @@ static struct snd_pcm_ops snd_ymfpci_capture_rec_ops = {
 	.pointer =		snd_ymfpci_capture_pointer,
 };
 
-int __devinit snd_ymfpci_pcm(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
+int snd_ymfpci_pcm(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1187,7 +1187,7 @@ static struct snd_pcm_ops snd_ymfpci_capture_ac97_ops = {
 	.pointer =		snd_ymfpci_capture_pointer,
 };
 
-int __devinit snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
+int snd_ymfpci_pcm2(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1225,7 +1225,7 @@ static struct snd_pcm_ops snd_ymfpci_playback_spdif_ops = {
 	.pointer =		snd_ymfpci_playback_pointer,
 };
 
-int __devinit snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
+int snd_ymfpci_pcm_spdif(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1270,7 +1270,7 @@ static const struct snd_pcm_chmap_elem surround_map[] = {
 	{ }
 };
 
-int __devinit snd_ymfpci_pcm_4ch(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
+int snd_ymfpci_pcm_4ch(struct snd_ymfpci *chip, int device, struct snd_pcm ** rpcm)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -1826,7 +1826,7 @@ static void snd_ymfpci_mixer_free_ac97(struct snd_ac97 *ac97)
 	chip->ac97 = NULL;
 }
 
-int __devinit snd_ymfpci_mixer(struct snd_ymfpci *chip, int rear_switch)
+int snd_ymfpci_mixer(struct snd_ymfpci *chip, int rear_switch)
 {
 	struct snd_ac97_template ac97;
 	struct snd_kcontrol *kctl;
@@ -1970,7 +1970,7 @@ static struct snd_timer_hardware snd_ymfpci_timer_hw = {
 	.precise_resolution = snd_ymfpci_timer_precise_resolution,
 };
 
-int __devinit snd_ymfpci_timer(struct snd_ymfpci *chip, int device)
+int snd_ymfpci_timer(struct snd_ymfpci *chip, int device)
 {
 	struct snd_timer *timer = NULL;
 	struct snd_timer_id tid;
@@ -2006,7 +2006,7 @@ static void snd_ymfpci_proc_read(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "%04x: %04x\n", i, snd_ymfpci_readl(chip, i));
 }
 
-static int __devinit snd_ymfpci_proc_init(struct snd_card *card, struct snd_ymfpci *chip)
+static int snd_ymfpci_proc_init(struct snd_card *card, struct snd_ymfpci *chip)
 {
 	struct snd_info_entry *entry;
 	
@@ -2128,7 +2128,7 @@ static void snd_ymfpci_download_image(struct snd_ymfpci *chip)
 	snd_ymfpci_enable_dsp(chip);
 }
 
-static int __devinit snd_ymfpci_memalloc(struct snd_ymfpci *chip)
+static int snd_ymfpci_memalloc(struct snd_ymfpci *chip)
 {
 	long size, playback_ctrl_size;
 	int voice, bank, reg;
@@ -2394,7 +2394,7 @@ static int snd_ymfpci_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(snd_ymfpci_pm, snd_ymfpci_suspend, snd_ymfpci_resume);
 #endif /* CONFIG_PM_SLEEP */
 
-int __devinit snd_ymfpci_create(struct snd_card *card,
+int snd_ymfpci_create(struct snd_card *card,
 				struct pci_dev * pci,
 				unsigned short old_legacy_ctrl,
 				struct snd_ymfpci ** rchip)
diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index b366793..667a067 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -872,8 +872,7 @@ static void snd_pmac_awacs_update_automute(struct snd_pmac *chip, int do_notify)
 /*
  * initialize chip
  */
-int __devinit
-snd_pmac_awacs_init(struct snd_pmac *chip)
+int snd_pmac_awacs_init(struct snd_pmac *chip)
 {
 	int pm7500 = IS_PM7500;
 	int pm5500 = IS_PM5500;
diff --git a/sound/ppc/beep.c b/sound/ppc/beep.c
index a9d3507..0040f04 100644
--- a/sound/ppc/beep.c
+++ b/sound/ppc/beep.c
@@ -215,7 +215,7 @@ static struct snd_kcontrol_new snd_pmac_beep_mixer = {
 };
 
 /* Initialize beep stuff */
-int __devinit snd_pmac_attach_beep(struct snd_pmac *chip)
+int snd_pmac_attach_beep(struct snd_pmac *chip)
 {
 	struct pmac_beep *beep;
 	struct input_dev *input_dev;
diff --git a/sound/ppc/burgundy.c b/sound/ppc/burgundy.c
index 00e2d51..6c76724 100644
--- a/sound/ppc/burgundy.c
+++ b/sound/ppc/burgundy.c
@@ -617,7 +617,7 @@ static void snd_pmac_burgundy_update_automute(struct snd_pmac *chip, int do_noti
 /*
  * initialize burgundy
  */
-int __devinit snd_pmac_burgundy_init(struct snd_pmac *chip)
+int snd_pmac_burgundy_init(struct snd_pmac *chip)
 {
 	int imac = of_machine_is_compatible("iMac");
 	int i, err;
diff --git a/sound/ppc/daca.c b/sound/ppc/daca.c
index 24200b7..b865262 100644
--- a/sound/ppc/daca.c
+++ b/sound/ppc/daca.c
@@ -244,7 +244,7 @@ static void daca_cleanup(struct snd_pmac *chip)
 }
 
 /* exported */
-int __devinit snd_pmac_daca_init(struct snd_pmac *chip)
+int snd_pmac_daca_init(struct snd_pmac *chip)
 {
 	int i, err;
 	struct pmac_daca *mix;
diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 4080bec..01aecc2 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -115,7 +115,7 @@ void snd_pmac_keywest_cleanup(struct pmac_keywest *i2c)
 	}
 }
 
-int __devinit snd_pmac_tumbler_post_init(void)
+int snd_pmac_tumbler_post_init(void)
 {
 	int err;
 	
@@ -130,7 +130,7 @@ int __devinit snd_pmac_tumbler_post_init(void)
 }
 
 /* exported */
-int __devinit snd_pmac_keywest_init(struct pmac_keywest *i2c)
+int snd_pmac_keywest_init(struct pmac_keywest *i2c)
 {
 	int err;
 
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index ab96cde..792bf7b 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -702,7 +702,7 @@ static struct snd_pcm_ops snd_pmac_capture_ops = {
 	.pointer =	snd_pmac_capture_pointer,
 };
 
-int __devinit snd_pmac_pcm_new(struct snd_pmac *chip)
+int snd_pmac_pcm_new(struct snd_pmac *chip)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -907,7 +907,7 @@ static int snd_pmac_dev_free(struct snd_device *device)
  * check the machine support byteswap (little-endian)
  */
 
-static void __devinit detect_byte_swap(struct snd_pmac *chip)
+static void detect_byte_swap(struct snd_pmac *chip)
 {
 	struct device_node *mio;
 
@@ -933,7 +933,7 @@ static void __devinit detect_byte_swap(struct snd_pmac *chip)
 /*
  * detect a sound chip
  */
-static int __devinit snd_pmac_detect(struct snd_pmac *chip)
+static int snd_pmac_detect(struct snd_pmac *chip)
 {
 	struct device_node *sound;
 	struct device_node *dn;
@@ -1161,7 +1161,7 @@ static struct snd_kcontrol_new auto_mute_controls[] __devinitdata = {
 	},
 };
 
-int __devinit snd_pmac_add_automute(struct snd_pmac *chip)
+int snd_pmac_add_automute(struct snd_pmac *chip)
 {
 	int err;
 	chip->auto_mute = 1;
@@ -1178,7 +1178,7 @@ int __devinit snd_pmac_add_automute(struct snd_pmac *chip)
 /*
  * create and detect a pmac chip record
  */
-int __devinit snd_pmac_new(struct snd_card *card, struct snd_pmac **chip_return)
+int snd_pmac_new(struct snd_card *card, struct snd_pmac **chip_return)
 {
 	struct snd_pmac *chip;
 	struct device_node *np;
diff --git a/sound/ppc/powermac.c b/sound/ppc/powermac.c
index ce6db15..625d12e 100644
--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -51,7 +51,7 @@ static struct platform_device *device;
 /*
  */
 
-static int __devinit snd_pmac_probe(struct platform_device *devptr)
+static int snd_pmac_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
 	struct snd_pmac *chip;
diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 9b18b52..8c7dcbe 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -786,7 +786,7 @@ static struct snd_pcm_ops snd_ps3_pcm_spdif_ops = {
 };
 
 
-static int __devinit snd_ps3_map_mmio(void)
+static int snd_ps3_map_mmio(void)
 {
 	the_card.mapped_mmio_vaddr =
 		ioremap(the_card.ps3_dev->m_region->bus_addr,
@@ -808,7 +808,7 @@ static void snd_ps3_unmap_mmio(void)
 	the_card.mapped_mmio_vaddr = NULL;
 }
 
-static int __devinit snd_ps3_allocate_irq(void)
+static int snd_ps3_allocate_irq(void)
 {
 	int ret;
 	u64 lpar_addr, lpar_size;
@@ -866,7 +866,7 @@ static void snd_ps3_free_irq(void)
 	ps3_irq_plug_destroy(the_card.irq_no);
 }
 
-static void __devinit snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
+static void snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
 {
 	uint64_t val;
 	int ret;
@@ -882,7 +882,7 @@ static void __devinit snd_ps3_audio_set_base_addr(uint64_t ioaddr_start)
 			ret);
 }
 
-static void __devinit snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
+static void snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
 {
 	/*
 	 * avsetting driver seems to never change the followings
@@ -906,7 +906,7 @@ static void __devinit snd_ps3_audio_fixup(struct snd_ps3_card_info *card)
 		   PS3_AUDIO_AO_3WMCTRL_ASOPLRCK_DEFAULT);
 }
 
-static int __devinit snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
+static int snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
 {
 	int ret;
 	pr_debug("%s: start\n", __func__);
@@ -928,7 +928,7 @@ static int __devinit snd_ps3_init_avsetting(struct snd_ps3_card_info *card)
 	return ret;
 }
 
-static int __devinit snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
+static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 {
 	int i, ret;
 	u64 lpar_addr, lpar_size;
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 9cea84c..6dd2e47 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1276,7 +1276,7 @@ static void tumbler_resume(struct snd_pmac *chip)
 #endif
 
 /* initialize tumbler */
-static int __devinit tumbler_init(struct snd_pmac *chip)
+static int tumbler_init(struct snd_pmac *chip)
 {
 	int irq;
 	struct pmac_tumbler *mix = chip->mixer_data;
@@ -1349,7 +1349,7 @@ static void tumbler_cleanup(struct snd_pmac *chip)
 }
 
 /* exported */
-int __devinit snd_pmac_tumbler_init(struct snd_pmac *chip)
+int snd_pmac_tumbler_init(struct snd_pmac *chip)
 {
 	int i, err;
 	struct pmac_tumbler *mix;
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 2b776ee..a6de99f 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -574,7 +574,7 @@ static int load_aica_firmware(void)
 	return err;
 }
 
-static int __devinit add_aicamixer_controls(struct snd_card_aica
+static int add_aicamixer_controls(struct snd_card_aica
 					    *dreamcastcard)
 {
 	int err;
@@ -603,7 +603,7 @@ static int __devexit snd_aica_remove(struct platform_device *devptr)
 	return 0;
 }
 
-static int __devinit snd_aica_probe(struct platform_device *devptr)
+static int snd_aica_probe(struct platform_device *devptr)
 {
 	int err;
 	struct snd_card_aica *dreamcastcard;
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 0a33947..b0f12f2 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -261,7 +261,7 @@ static struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.mmap		= snd_pcm_lib_mmap_iomem,
 };
 
-static int __devinit snd_sh_dac_pcm(struct snd_sh_dac *chip, int device)
+static int snd_sh_dac_pcm(struct snd_sh_dac *chip, int device)
 {
 	int err;
 	struct snd_pcm *pcm;
@@ -346,7 +346,7 @@ static enum hrtimer_restart sh_dac_audio_timer(struct hrtimer *handle)
 }
 
 /* create  --  chip-specific constructor for the cards components */
-static int __devinit snd_sh_dac_create(struct snd_card *card,
+static int snd_sh_dac_create(struct snd_card *card,
 				       struct platform_device *devptr,
 				       struct snd_sh_dac **rchip)
 {
@@ -392,7 +392,7 @@ static int __devinit snd_sh_dac_create(struct snd_card *card,
 }
 
 /* driver .probe  --  constructor */
-static int __devinit snd_sh_dac_probe(struct platform_device *devptr)
+static int snd_sh_dac_probe(struct platform_device *devptr)
 {
 	struct snd_sh_dac *chip;
 	struct snd_card *card;
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 194eb85..92cc26d 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -473,7 +473,7 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 	.resume		= atmel_pcm_resume,
 };
 
-static int __devinit atmel_soc_platform_probe(struct platform_device *pdev)
+static int atmel_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &atmel_soc_platform);
 }
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 90a1188..f2e6efd 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -787,7 +787,7 @@ static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
 #endif
 };
 
-static __devinit int asoc_ssc_probe(struct platform_device *pdev)
+static int asoc_ssc_probe(struct platform_device *pdev)
 {
 	BUG_ON(pdev->id < 0);
 	BUG_ON(pdev->id >= ARRAY_SIZE(atmel_ssc_dai));
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index a1dfe46..1197515 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -195,7 +195,7 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.set_bias_level = at91sam9g20ek_set_bias_level,
 };
 
-static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
+static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 {
 	struct clk *pllb;
 	struct snd_soc_card *card = &snd_soc_at91sam9g20ek;
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index f54edf4..a444bfb 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -223,7 +223,7 @@ static struct snd_soc_dai_driver au1xac97c_dai_driver = {
 	.ops			= &alchemy_ac97c_ops,
 };
 
-static int __devinit au1xac97c_drvprobe(struct platform_device *pdev)
+static int au1xac97c_drvprobe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *iores, *dmares;
diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
index faf55ab..2a8bf01 100644
--- a/sound/soc/au1x/db1000.c
+++ b/sound/soc/au1x/db1000.c
@@ -34,7 +34,7 @@ static struct snd_soc_card db1000_ac97 = {
 	.num_links	= 1,
 };
 
-static int __devinit db1000_audio_probe(struct platform_device *pdev)
+static int db1000_audio_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &db1000_ac97;
 	card->dev = &pdev->dev;
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 2d7f9b8..f319419 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -176,7 +176,7 @@ static struct snd_soc_card *db1200_cards[] __devinitdata = {
 	&db1550_i2s_machine,
 };
 
-static int __devinit db1200_audio_probe(struct platform_device *pdev)
+static int db1200_audio_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *pid = platform_get_device_id(pdev);
 	struct snd_soc_card *card;
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index fe5bbf4..ec85c58 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -347,7 +347,7 @@ static struct snd_soc_platform_driver au1xpsc_soc_platform = {
 	.pcm_free	= au1xpsc_pcm_free_dma_buffers,
 };
 
-static int __devinit au1xpsc_pcm_drvprobe(struct platform_device *pdev)
+static int au1xpsc_pcm_drvprobe(struct platform_device *pdev)
 {
 	struct au1xpsc_audio_dmadata *dmadata;
 
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 264e820..ccfbe5b 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -322,7 +322,7 @@ static struct snd_soc_platform_driver alchemy_pcm_soc_platform = {
 	.pcm_free	= alchemy_pcm_free_dma_buffers,
 };
 
-static int __devinit alchemy_pcm_drvprobe(struct platform_device *pdev)
+static int alchemy_pcm_drvprobe(struct platform_device *pdev)
 {
 	struct alchemy_pcm_ctx *ctx;
 
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index 329ec51..4737c85 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -225,7 +225,7 @@ static struct snd_soc_dai_driver au1xi2s_dai_driver = {
 	.ops = &au1xi2s_dai_ops,
 };
 
-static int __devinit au1xi2s_drvprobe(struct platform_device *pdev)
+static int au1xi2s_drvprobe(struct platform_device *pdev)
 {
 	struct resource *iores, *dmares;
 	struct au1xpsc_audio_data *ctx;
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index dab4b75..c541c92 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -361,7 +361,7 @@ static const struct snd_soc_dai_driver au1xpsc_ac97_dai_template = {
 	.ops = &au1xpsc_ac97_dai_ops,
 };
 
-static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
+static int au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *iores, *dmares;
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 73800b2..bed90cc 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -288,7 +288,7 @@ static const struct snd_soc_dai_driver au1xpsc_i2s_dai_template = {
 	.ops = &au1xpsc_i2s_dai_ops,
 };
 
-static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
+static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 {
 	struct resource *iores, *dmares;
 	unsigned long sel;
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index cb29219..dce0f25 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -453,7 +453,7 @@ static struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
 
-static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
+static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_ac97_soc_platform);
 }
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index cce2e8d..6845373 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -282,7 +282,7 @@ static struct snd_soc_dai_driver bfin_ac97_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 };
 
-static int __devinit asoc_bfin_ac97_probe(struct platform_device *pdev)
+static int asoc_bfin_ac97_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle;
 	int ret;
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index f34b99f..b87f5aa 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -75,7 +75,7 @@ static struct snd_soc_card bf5xx_ad1836 = {
 	.num_links = 1,
 };
 
-static __devinit int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
+static int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &bf5xx_ad1836;
 	const char **link_name;
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index a0fbb1e..b3a5cbe 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -292,7 +292,7 @@ static struct snd_soc_platform_driver bf5xx_i2s_soc_platform = {
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
 
-static int __devinit bfin_i2s_soc_platform_probe(struct platform_device *pdev)
+static int bfin_i2s_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_i2s_soc_platform);
 }
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 990b6d1..f07e3ae 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -245,7 +245,7 @@ static struct snd_soc_dai_driver bf5xx_i2s_dai = {
 	.ops = &bf5xx_i2s_dai_ops,
 };
 
-static int __devinit bf5xx_i2s_probe(struct platform_device *pdev)
+static int bf5xx_i2s_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle;
 	int ret;
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 9740e0f..23a4dec 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -317,7 +317,7 @@ static struct snd_soc_platform_driver bf5xx_tdm_soc_platform = {
 	.pcm_free       = bf5xx_pcm_free_dma_buffers,
 };
 
-static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
+static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_tdm_soc_platform);
 }
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index a4fe59c..806f8f0 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -249,7 +249,7 @@ static struct snd_soc_dai_driver bf5xx_tdm_dai = {
 	.ops = &bf5xx_tdm_dai_ops,
 };
 
-static int __devinit bfin_tdm_probe(struct platform_device *pdev)
+static int bfin_tdm_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle;
 	int ret;
diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
index 0021bd6..a87b7b2 100644
--- a/sound/soc/blackfin/bf6xx-i2s.c
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -186,7 +186,7 @@ static struct snd_soc_dai_driver bfin_i2s_dai = {
 	.ops = &bfin_i2s_dai_ops,
 };
 
-static int __devinit bfin_i2s_probe(struct platform_device *pdev)
+static int bfin_i2s_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport;
 	struct device *dev = &pdev->dev;
diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index b610600..0e766a5 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -80,7 +80,7 @@ static struct snd_soc_card snd_soc_edb93xx = {
 	.num_links	= 1,
 };
 
-static int __devinit edb93xx_probe(struct platform_device *pdev)
+static int edb93xx_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_edb93xx;
 	int ret;
diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index 2c15880..e70f53f 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -352,7 +352,7 @@ static struct snd_soc_dai_driver ep93xx_ac97_dai = {
 	.ops			= &ep93xx_ac97_dai_ops,
 };
 
-static int __devinit ep93xx_ac97_probe(struct platform_device *pdev)
+static int ep93xx_ac97_probe(struct platform_device *pdev)
 {
 	struct ep93xx_ac97_info *info;
 	struct resource *res;
diff --git a/sound/soc/cirrus/ep93xx-pcm.c b/sound/soc/cirrus/ep93xx-pcm.c
index 4274ba2..b294fb1 100644
--- a/sound/soc/cirrus/ep93xx-pcm.c
+++ b/sound/soc/cirrus/ep93xx-pcm.c
@@ -213,7 +213,7 @@ static struct snd_soc_platform_driver ep93xx_soc_platform = {
 	.pcm_free	= &ep93xx_pcm_free_dma_buffers,
 };
 
-static int __devinit ep93xx_soc_platform_probe(struct platform_device *pdev)
+static int ep93xx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &ep93xx_soc_platform);
 }
diff --git a/sound/soc/cirrus/simone.c b/sound/soc/cirrus/simone.c
index 04f59a9..1c8d9aa 100644
--- a/sound/soc/cirrus/simone.c
+++ b/sound/soc/cirrus/simone.c
@@ -41,7 +41,7 @@ static struct snd_soc_card snd_soc_simone = {
 
 static struct platform_device *simone_snd_ac97_device;
 
-static int __devinit simone_probe(struct platform_device *pdev)
+static int simone_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_simone;
 	int ret;
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index a98bec1..7f8dcd2 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -98,7 +98,7 @@ static struct snd_soc_card snd_soc_snappercl15 = {
 	.num_links	= 1,
 };
 
-static int __devinit snappercl15_probe(struct platform_device *pdev)
+static int snappercl15_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_snappercl15;
 	int ret;
diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 6e9d31b..0631036 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1423,7 +1423,7 @@ static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.num_dapm_routes = ARRAY_SIZE(pm860x_dapm_routes),
 };
 
-static int __devinit pm860x_codec_probe(struct platform_device *pdev)
+static int pm860x_codec_probe(struct platform_device *pdev)
 {
 	struct pm860x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm860x_priv *pm860x;
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index bf9db7f..300ea60 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2554,7 +2554,7 @@ static struct snd_soc_codec_driver ab8500_codec_driver = {
 	.num_dapm_routes =	ARRAY_SIZE(ab8500_dapm_routes),
 };
 
-static int __devinit ab8500_codec_driver_probe(struct platform_device *pdev)
+static int ab8500_codec_driver_probe(struct platform_device *pdev)
 {
 	int status;
 	struct ab8500_codec_drvdata *drvdata;
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 0ae093b..5c0837b 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -118,7 +118,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
 	.resume =	ac97_soc_resume,
 };
 
-static __devinit int ac97_probe(struct platform_device *pdev)
+static int ac97_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_ac97, &ac97_dai, 1);
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 1613241..384ae12 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -360,7 +360,7 @@ static const struct regmap_config ad1836_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit ad1836_spi_probe(struct spi_device *spi)
+static int ad1836_spi_probe(struct spi_device *spi)
 {
 	struct ad1836_priv *ad1836;
 	int ret;
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 9537b66..209b7b5 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -378,7 +378,7 @@ static const struct regmap_config ad193x_spi_regmap_config = {
 	.volatile_reg = adau193x_reg_volatile,
 };
 
-static int __devinit ad193x_spi_probe(struct spi_device *spi)
+static int ad193x_spi_probe(struct spi_device *spi)
 {
 	struct ad193x_priv *ad193x;
 
@@ -430,7 +430,7 @@ static const struct i2c_device_id ad193x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad193x_id);
 
-static int __devinit ad193x_i2c_probe(struct i2c_client *client,
+static int ad193x_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ad193x_priv *ad193x;
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index b095553..db6657f 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -255,7 +255,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ad1980 = {
 	.read = ac97_read,
 };
 
-static __devinit int ad1980_probe(struct platform_device *pdev)
+static int ad1980_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_ad1980, &ad1980_dai, 1);
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 7f62721..e20e267 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1353,7 +1353,7 @@ static struct snd_soc_codec_driver adau1373_codec_driver = {
 	.num_dapm_routes = ARRAY_SIZE(adau1373_dapm_routes),
 };
 
-static int __devinit adau1373_i2c_probe(struct i2c_client *client,
+static int adau1373_i2c_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	struct adau1373 *adau1373;
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index f02b1c83..bd7d58f 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -489,7 +489,7 @@ static struct snd_soc_codec_driver adau1701_codec_drv = {
 	.set_sysclk		= adau1701_set_sysclk,
 };
 
-static __devinit int adau1701_i2c_probe(struct i2c_client *client,
+static int adau1701_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct adau1701 *adau1701;
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index cd5d0f6..cb960fd 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -839,7 +839,7 @@ static struct snd_soc_codec_driver adav80x_codec_driver = {
 	.num_dapm_routes = ARRAY_SIZE(adav80x_dapm_routes),
 };
 
-static int __devinit adav80x_bus_probe(struct device *dev,
+static int adav80x_bus_probe(struct device *dev,
 		enum snd_soc_control_type control_type)
 {
 	struct adav80x *adav80x;
@@ -868,7 +868,7 @@ static int __devexit adav80x_bus_remove(struct device *dev)
 }
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit adav80x_spi_probe(struct spi_device *spi)
+static int adav80x_spi_probe(struct spi_device *spi)
 {
 	return adav80x_bus_probe(&spi->dev, SND_SOC_SPI);
 }
@@ -895,7 +895,7 @@ static const struct i2c_device_id adav80x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adav80x_id);
 
-static int __devinit adav80x_i2c_probe(struct i2c_client *client,
+static int adav80x_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	return adav80x_bus_probe(&client->dev, SND_SOC_I2C);
diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 93aae10..a152f5a 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -36,7 +36,7 @@ static struct snd_soc_dai_driver ads117x_dai = {
 
 static struct snd_soc_codec_driver soc_codec_dev_ads117x;
 
-static __devinit int ads117x_probe(struct platform_device *pdev)
+static int ads117x_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_ads117x, &ads117x_dai, 1);
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 66b3669..77e285c 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -436,7 +436,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
 	.num_dapm_routes = ARRAY_SIZE(ak4535_audio_map),
 };
 
-static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
+static int ak4535_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct ak4535_priv *ak4535;
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 8c8ef10..09da215 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -557,7 +557,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4641 = {
 };
 
 
-static int __devinit ak4641_i2c_probe(struct i2c_client *i2c,
+static int ak4641_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct ak4641_platform_data *pdata = i2c->dev.platform_data;
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index e2c3222..aba3813 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -520,7 +520,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4648 = {
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int ak4642_i2c_probe(struct i2c_client *i2c,
+static int ak4642_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct ak4642_priv *ak4642;
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 2fc0a5d..93a76cb 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -655,7 +655,7 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
 	.num_dapm_routes = ARRAY_SIZE(ak4671_intercon),
 };
 
-static int __devinit ak4671_i2c_probe(struct i2c_client *client,
+static int ak4671_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ak4671_priv *ak4671;
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index cef214e..5a7ad19 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -991,7 +991,7 @@ static struct snd_soc_codec_driver soc_codec_device_alc5623 = {
  *    low  = 0x1a
  *    high = 0x1b
  */
-static __devinit int alc5623_i2c_probe(struct i2c_client *client,
+static int alc5623_i2c_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct alc5623_platform_data *pdata;
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 93fd94d..7026e3d 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1116,7 +1116,7 @@ static struct regmap_config alc5632_regmap = {
  *    low  = 0x1a
  *    high = 0x1b
  */
-static __devinit int alc5632_i2c_probe(struct i2c_client *client,
+static int alc5632_i2c_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct alc5632_priv *alc5632;
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 976b9bd..3d637b2 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -570,7 +570,7 @@ static struct snd_soc_codec_driver soc_codec_dev_cs4271 = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit cs4271_spi_probe(struct spi_device *spi)
+static int cs4271_spi_probe(struct spi_device *spi)
 {
 	struct cs4271_private *cs4271;
 
@@ -609,7 +609,7 @@ static const struct i2c_device_id cs4271_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
 
-static int __devinit cs4271_i2c_probe(struct i2c_client *client,
+static int cs4271_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct cs4271_private *cs4271;
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index f68bbc7..362c20b 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1345,7 +1345,7 @@ static struct regmap_config cs42l73_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static __devinit int cs42l73_i2c_probe(struct i2c_client *i2c_client,
+static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 				       const struct i2c_device_id *id)
 {
 	struct cs42l73_private *cs42l73;
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 7ab571d..0c3b09c 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1218,7 +1218,7 @@ static const struct regmap_config da7210_regmap_config_i2c = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
+static int da7210_i2c_probe(struct i2c_client *i2c,
 			   	      const struct i2c_device_id *id)
 {
 	struct da7210_priv *da7210;
@@ -1323,7 +1323,7 @@ static const struct regmap_config da7210_regmap_config_spi = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit da7210_spi_probe(struct spi_device *spi)
+static int da7210_spi_probe(struct spi_device *spi)
 {
 	struct da7210_priv *da7210;
 	int ret;
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index c6f1ef9..850bfed 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1557,7 +1557,7 @@ static struct snd_soc_codec_driver soc_codec_dev_da732x = {
 	.reg_cache_size		= ARRAY_SIZE(da732x_reg_cache),
 };
 
-static __devinit int da732x_i2c_probe(struct i2c_client *i2c,
+static int da732x_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct da732x_priv *da732x;
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 468ad60..cf8dfeb 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1484,7 +1484,7 @@ static const struct regmap_config da9055_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit da9055_i2c_probe(struct i2c_client *i2c,
+static int da9055_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct da9055_priv *da9055;
diff --git a/sound/soc/codecs/dfbmcs320.c b/sound/soc/codecs/dfbmcs320.c
index af7e38d..61ccf30 100644
--- a/sound/soc/codecs/dfbmcs320.c
+++ b/sound/soc/codecs/dfbmcs320.c
@@ -33,7 +33,7 @@ static struct snd_soc_dai_driver dfbmcs320_dai = {
 
 static struct snd_soc_codec_driver soc_codec_dev_dfbmcs320;
 
-static int __devinit dfbmcs320_probe(struct platform_device *pdev)
+static int dfbmcs320_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_dfbmcs320,
 			&dfbmcs320_dai, 1);
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 95b39ac..0dc7fab 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -66,7 +66,7 @@ static struct snd_soc_codec_driver soc_dmic = {
 	.probe	= dmic_probe,
 };
 
-static int __devinit dmic_dev_probe(struct platform_device *pdev)
+static int dmic_dev_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_dmic, &dmic_dai, 1);
diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 25e57ea..8853a83 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1119,7 +1119,7 @@ static const struct regmap_config isabelle_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit isabelle_i2c_probe(struct i2c_client *i2c,
+static int isabelle_i2c_probe(struct i2c_client *i2c,
 					const struct i2c_device_id *id)
 {
 	struct regmap *isabelle_regmap;
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index d295dcf..3606f26 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -348,7 +348,7 @@ static const struct regmap_config jz4740_codec_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit jz4740_codec_probe(struct platform_device *pdev)
+static int jz4740_codec_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_codec *jz4740_codec;
diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index b0db011..27e7991 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -209,7 +209,7 @@ static struct snd_soc_codec_driver soc_codec_dev_lm4857 = {
 	.set_bias_level = lm4857_set_bias_level,
 };
 
-static int __devinit lm4857_i2c_probe(struct i2c_client *i2c,
+static int lm4857_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	struct lm4857 *lm4857;
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index af16b4a..568e499 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1483,7 +1483,7 @@ static const struct regmap_config lm49453_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static __devinit int lm49453_i2c_probe(struct i2c_client *i2c,
+static int lm49453_i2c_probe(struct i2c_client *i2c,
 				       const struct i2c_device_id *id)
 {
 	struct lm49453_priv *lm49453;
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index 367d886..4ece6ab 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -159,7 +159,7 @@ static const struct regmap_config max9768_i2c_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit max9768_i2c_probe(struct i2c_client *client,
+static int max9768_i2c_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	struct max9768 *max9768;
diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index adf2317..261b62f 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -329,7 +329,7 @@ static struct snd_soc_codec_driver soc_codec_dev_max9850 = {
 	.num_dapm_routes = ARRAY_SIZE(max9850_dapm_routes),
 };
 
-static int __devinit max9850_i2c_probe(struct i2c_client *i2c,
+static int max9850_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
 	struct max9850_priv *max9850;
diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index bc15f5a..5243340 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -258,7 +258,7 @@ int max9877_add_controls(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(max9877_add_controls);
 
-static int __devinit max9877_i2c_probe(struct i2c_client *client,
+static int max9877_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	i2c = client;
diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 7b15fe8..d3d6b26 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -626,7 +626,7 @@ static const struct regmap_config ml26124_i2c_regmap = {
 	.write_flag_mask = 0x01,
 };
 
-static __devinit int ml26124_i2c_probe(struct i2c_client *i2c,
+static int ml26124_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct ml26124_priv *priv;
diff --git a/sound/soc/codecs/omap-hdmi.c b/sound/soc/codecs/omap-hdmi.c
index 1437766..8ddc3d56 100644
--- a/sound/soc/codecs/omap-hdmi.c
+++ b/sound/soc/codecs/omap-hdmi.c
@@ -39,7 +39,7 @@ static struct snd_soc_dai_driver omap_hdmi_codec_dai = {
 	},
 };
 
-static __devinit int omap_hdmi_codec_probe(struct platform_device *pdev)
+static int omap_hdmi_codec_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &omap_hdmi_codec,
 			&omap_hdmi_codec_dai, 1);
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index bb48aa6..74561f3 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -149,7 +149,7 @@ static struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
 	.resume =	pcm3008_soc_resume,
 };
 
-static int __devinit pcm3008_codec_probe(struct platform_device *pdev)
+static int pcm3008_codec_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_pcm3008, &pcm3008_dai, 1);
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 66e6e43..40d4fc1 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1404,7 +1404,7 @@ static struct snd_soc_codec_driver sgtl5000_driver = {
 	.num_dapm_routes = ARRAY_SIZE(sgtl5000_dapm_routes),
 };
 
-static __devinit int sgtl5000_i2c_probe(struct i2c_client *client,
+static int sgtl5000_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct sgtl5000_priv *sgtl5000;
diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 13fff24..8c46732 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -226,7 +226,7 @@ static struct snd_soc_codec_driver soc_codec_dev_si476x = {
 	.write  = si476x_codec_write,
 };
 
-static int __devinit si476x_platform_probe(struct platform_device *pdev)
+static int si476x_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_si476x,
 				      &si476x_dai, 1);
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 97bad86..98529c5 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -896,7 +896,7 @@ struct snd_soc_codec_driver sn95031_codec = {
 	.num_dapm_routes	= ARRAY_SIZE(sn95031_audio_map),
 };
 
-static int __devinit sn95031_device_probe(struct platform_device *pdev)
+static int sn95031_device_probe(struct platform_device *pdev)
 {
 	pr_debug("codec device probe called for %s\n", dev_name(&pdev->dev));
 	return snd_soc_register_codec(&pdev->dev, &sn95031_codec,
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index c290fe10..6fa63cc 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -691,7 +691,7 @@ static const struct regmap_config ssm2602_regmap_config = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit ssm2602_spi_probe(struct spi_device *spi)
+static int ssm2602_spi_probe(struct spi_device *spi)
 {
 	struct ssm2602_priv *ssm2602;
 	int ret;
@@ -736,7 +736,7 @@ static struct spi_driver ssm2602_spi_driver = {
  *    low  = 0x1a
  *    high = 0x1b
  */
-static int __devinit ssm2602_i2c_probe(struct i2c_client *i2c,
+static int ssm2602_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
 	struct ssm2602_priv *ssm2602;
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 2b10e20..2309f5a 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -995,7 +995,7 @@ static const struct regmap_config sta32x_regmap = {
 	.volatile_reg =		sta32x_reg_is_volatile,
 };
 
-static __devinit int sta32x_i2c_probe(struct i2c_client *i2c,
+static int sta32x_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct sta32x_priv *sta32x;
diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index 34a73b8..570a09e 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -380,7 +380,7 @@ static const struct regmap_config sta529_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(sta529_reg_defaults),
 };
 
-static __devinit int sta529_i2c_probe(struct i2c_client *i2c,
+static int sta529_i2c_probe(struct i2c_client *i2c,
 		const struct i2c_device_id *id)
 {
 	struct sta529 *sta529;
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 29a8b391..20ad890 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -385,7 +385,7 @@ static struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
 	.reg_cache_default = stac9766_reg,
 };
 
-static __devinit int stac9766_probe(struct platform_device *pdev)
+static int stac9766_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_stac9766, stac9766_dai, ARRAY_SIZE(stac9766_dai));
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 4cc54d5..1d45339 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -716,7 +716,7 @@ static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
 	.set_bias_level = aic32x4_set_bias_level,
 };
 
-static __devinit int aic32x4_i2c_probe(struct i2c_client *i2c,
+static int aic32x4_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct aic32x4_pdata *pdata = i2c->dev.platform_data;
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index c1e3804..8af052b 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1514,7 +1514,7 @@ static struct snd_soc_dai_driver dac33_dai = {
 	.ops = &dac33_dai_ops,
 };
 
-static int __devinit dac33_i2c_probe(struct i2c_client *client,
+static int dac33_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
 	struct tlv320dac33_platform_data *pdata;
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index aea6262..f1c0399 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -359,7 +359,7 @@ int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(tpa6130a2_add_controls);
 
-static int __devinit tpa6130a2_probe(struct i2c_client *client,
+static int tpa6130a2_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
 	struct device *dev;
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index d7e4e1b..c53c7fa 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2334,7 +2334,7 @@ static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
-static int __devinit twl4030_codec_probe(struct platform_device *pdev)
+static int twl4030_codec_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_twl4030,
 			twl4030_dai, ARRAY_SIZE(twl4030_dai));
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 37f060e..e3256ba 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1229,7 +1229,7 @@ static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
-static int __devinit twl6040_codec_probe(struct platform_device *pdev)
+static int twl6040_codec_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_twl6040,
 				      twl6040_dai, ARRAY_SIZE(twl6040_dai));
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 9c60366..6c5a395 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -601,7 +601,7 @@ static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.set_bias_level = uda134x_set_bias_level,
 };
 
-static int __devinit uda134x_codec_probe(struct platform_device *pdev)
+static int uda134x_codec_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_uda134x, &uda134x_dai, 1);
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2f6c391..289dfe1 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -795,7 +795,7 @@ static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int uda1380_i2c_probe(struct i2c_client *i2c,
+static int uda1380_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct uda1380_priv *uda1380;
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 1823a45..2ae0302 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -485,7 +485,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wl1273 = {
 	.remove = wl1273_remove,
 };
 
-static int __devinit wl1273_platform_probe(struct platform_device *pdev)
+static int wl1273_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wl1273,
 				      &wl1273_dai, 1);
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 5af91d6..c449178 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -863,7 +863,7 @@ static int wm0010_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int __devinit wm0010_spi_probe(struct spi_device *spi)
+static int wm0010_spi_probe(struct spi_device *spi)
 {
 	unsigned long gpio_flags;
 	int ret;
diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 169fac1..18e58bd 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -153,7 +153,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
 	.idle_bias_off = true,
 };
 
-static int __devinit wm1250_ev1_pdata(struct i2c_client *i2c)
+static int wm1250_ev1_pdata(struct i2c_client *i2c)
 {
 	struct wm1250_ev1_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm1250_priv *wm1250;
@@ -199,7 +199,7 @@ static void wm1250_ev1_free(struct i2c_client *i2c)
 		gpio_free_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
 }
 
-static int __devinit wm1250_ev1_probe(struct i2c_client *i2c,
+static int wm1250_ev1_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *i2c_id)
 {
 	int id, board, rev, ret;
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index da4e707..9956b74 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -764,7 +764,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm2000 = {
 	.num_controls = ARRAY_SIZE(wm2000_controls),
 };
 
-static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
+static int wm2000_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *i2c_id)
 {
 	struct wm2000_priv *wm2000;
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 11cabda..b6428c6 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2184,7 +2184,7 @@ static const unsigned int wm2200_mic_ctrl_reg[] = {
 	WM2200_IN3L_CONTROL,
 };
 
-static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
+static int wm2200_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm2200_pdata *pdata = dev_get_platdata(&i2c->dev);
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 96069ec..ee4e4b2 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2414,7 +2414,7 @@ static const unsigned int wm5100_mic_ctrl_reg[] = {
 	WM5100_IN4L_CONTROL,
 };
 
-static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
+static int wm5100_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm5100_pdata *pdata = dev_get_platdata(&i2c->dev);
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 4a57802..0210a08 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1447,7 +1447,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	.num_dapm_routes = ARRAY_SIZE(wm5102_dapm_routes),
 };
 
-static int __devinit wm5102_probe(struct platform_device *pdev)
+static int wm5102_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct wm5102_priv *wm5102;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 6f66b11..59f5d16 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -949,7 +949,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	.num_dapm_routes = ARRAY_SIZE(wm5110_dapm_routes),
 };
 
-static int __devinit wm5110_probe(struct platform_device *pdev)
+static int wm5110_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct wm5110_priv *wm5110;
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index d0e35d3..24eaf4d 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1627,7 +1627,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8350_dapm_routes),
 };
 
-static int __devinit wm8350_probe(struct platform_device *pdev)
+static int wm8350_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8350,
 			&wm8350_dai, 1);
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index a9a85f6..fde7b17 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1439,7 +1439,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8400_dapm_routes),
 };
 
-static int __devinit wm8400_probe(struct platform_device *pdev)
+static int wm8400_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8400,
 			&wm8400_dai, 1);
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 91816eb..28dbbdc 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -648,7 +648,7 @@ static const struct regmap_config wm8510_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8510_spi_probe(struct spi_device *spi)
+static int wm8510_spi_probe(struct spi_device *spi)
 {
 	struct wm8510_priv *wm8510;
 	int ret;
@@ -688,7 +688,7 @@ static struct spi_driver wm8510_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8510_i2c_probe(struct i2c_client *i2c,
+static int wm8510_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8510_priv *wm8510;
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 6004c17..c05c55d 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -453,7 +453,7 @@ static const struct regmap_config wm8523_regmap = {
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8523_i2c_probe(struct i2c_client *i2c,
+static int wm8523_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8523_priv *wm8523;
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index c97eb50..a366fdc 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -429,7 +429,7 @@ static const struct regmap_config wm8711_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8711_spi_probe(struct spi_device *spi)
+static int wm8711_spi_probe(struct spi_device *spi)
 {
 	struct wm8711_priv *wm8711;
 	int ret;
@@ -470,7 +470,7 @@ static struct spi_driver wm8711_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8711_i2c_probe(struct i2c_client *client,
+static int wm8711_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct wm8711_priv *wm8711;
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index a38c36b..3bc03f8 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -45,7 +45,7 @@ static struct snd_soc_dai_driver wm8727_dai = {
 
 static struct snd_soc_codec_driver soc_codec_dev_wm8727;
 
-static __devinit int wm8727_probe(struct platform_device *pdev)
+static int wm8727_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm8727, &wm8727_dai, 1);
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 50aa6dd..245c2b4 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -280,7 +280,7 @@ static const struct regmap_config wm8728_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8728_spi_probe(struct spi_device *spi)
+static int wm8728_spi_probe(struct spi_device *spi)
 {
 	struct wm8728_priv *wm8728;
 	int ret;
@@ -321,7 +321,7 @@ static struct spi_driver wm8728_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8728_i2c_probe(struct i2c_client *i2c,
+static int wm8728_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8728_priv *wm8728;
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c277327..71617ad 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -631,7 +631,7 @@ static const struct regmap_config wm8731_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8731_spi_probe(struct spi_device *spi)
+static int wm8731_spi_probe(struct spi_device *spi)
 {
 	struct wm8731_priv *wm8731;
 	int ret;
@@ -679,7 +679,7 @@ static struct spi_driver wm8731_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
+static int wm8731_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8731_priv *wm8731;
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 46caa41..9e1a100 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -645,7 +645,7 @@ static const struct regmap_config wm8737_regmap = {
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8737_i2c_probe(struct i2c_client *i2c,
+static int wm8737_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8737_priv *wm8737;
@@ -705,7 +705,7 @@ static struct i2c_driver wm8737_i2c_driver = {
 #endif
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8737_spi_probe(struct spi_device *spi)
+static int wm8737_spi_probe(struct spi_device *spi)
 {
 	struct wm8737_priv *wm8737;
 	int ret, i;
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 24c5576..019558c 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -562,7 +562,7 @@ static struct i2c_driver wm8741_i2c_driver = {
 #endif
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8741_spi_probe(struct spi_device *spi)
+static int wm8741_spi_probe(struct spi_device *spi)
 {
 	struct wm8741_priv *wm8741;
 	int ret, i;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index b45575e..28256c4 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -769,7 +769,7 @@ static const struct regmap_config wm8750_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8750_spi_probe(struct spi_device *spi)
+static int wm8750_spi_probe(struct spi_device *spi)
 {
 	struct wm8750_priv *wm8750;
 	struct regmap *regmap;
@@ -817,7 +817,7 @@ static struct spi_driver wm8750_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8750_i2c_probe(struct i2c_client *i2c,
+static int wm8750_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8750_priv *wm8750;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 0daacac..c22f580 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1550,7 +1550,7 @@ static const struct regmap_config wm8753_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8753_spi_probe(struct spi_device *spi)
+static int wm8753_spi_probe(struct spi_device *spi)
 {
 	struct wm8753_priv *wm8753;
 	int ret;
@@ -1607,7 +1607,7 @@ static struct spi_driver wm8753_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8753_i2c_probe(struct i2c_client *i2c,
+static int wm8753_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8753_priv *wm8753;
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 849b5f3..053a2f5 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -650,7 +650,7 @@ static const struct regmap_config wm8770_regmap = {
 	.volatile_reg = wm8770_volatile_reg,
 };
 
-static int __devinit wm8770_spi_probe(struct spi_device *spi)
+static int wm8770_spi_probe(struct spi_device *spi)
 {
 	struct wm8770_priv *wm8770;
 	int ret, i;
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 7bb0ee5..93bca00 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -492,7 +492,7 @@ static const struct regmap_config wm8776_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8776_spi_probe(struct spi_device *spi)
+static int wm8776_spi_probe(struct spi_device *spi)
 {
 	struct wm8776_priv *wm8776;
 	int ret;
@@ -532,7 +532,7 @@ static struct spi_driver wm8776_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8776_i2c_probe(struct i2c_client *i2c,
+static int wm8776_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8776_priv *wm8776;
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 6b82ae6..4b752b7 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -42,7 +42,7 @@ static struct snd_soc_dai_driver wm8782_dai = {
 
 static struct snd_soc_codec_driver soc_codec_dev_wm8782;
 
-static __devinit int wm8782_probe(struct platform_device *pdev)
+static int wm8782_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm8782, &wm8782_dai, 1);
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 368fe09..cad8ea0 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -702,7 +702,7 @@ static struct regmap_config wm8804_regmap_config = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8804_spi_probe(struct spi_device *spi)
+static int wm8804_spi_probe(struct spi_device *spi)
 {
 	struct wm8804_priv *wm8804;
 	int ret;
@@ -745,7 +745,7 @@ static struct spi_driver wm8804_spi_driver = {
 #endif
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8804_i2c_probe(struct i2c_client *i2c,
+static int wm8804_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8804_priv *wm8804;
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index d68b2dd..375720e 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1247,7 +1247,7 @@ static const struct regmap_config wm8900_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8900_spi_probe(struct spi_device *spi)
+static int wm8900_spi_probe(struct spi_device *spi)
 {
 	struct wm8900_priv *wm8900;
 	int ret;
@@ -1286,7 +1286,7 @@ static struct spi_driver wm8900_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
+static int wm8900_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8900_priv *wm8900;
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 8e9977b..930b1a2 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2020,7 +2020,7 @@ static int wm8903_set_pdata_from_of(struct i2c_client *i2c,
 	return 0;
 }
 
-static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
+static int wm8903_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8903_platform_data *pdata = dev_get_platdata(&i2c->dev);
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index b1d0ea5..6a150d0 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2111,7 +2111,7 @@ static const struct regmap_config wm8904_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8904_reg_defaults),
 };
 
-static __devinit int wm8904_i2c_probe(struct i2c_client *i2c,
+static int wm8904_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8904_priv *wm8904;
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 9a9a17f..d80fbcf 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -742,7 +742,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
 	.volatile_register = wm8940_volatile_register,
 };
 
-static __devinit int wm8940_i2c_probe(struct i2c_client *i2c,
+static int wm8940_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8940_priv *wm8940;
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index a18b15b..b1fd4d7 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -1012,7 +1012,7 @@ static const struct regmap_config wm8955_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8955_reg_defaults),
 };
 
-static __devinit int wm8955_i2c_probe(struct i2c_client *i2c,
+static int wm8955_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8955_priv *wm8955;
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index bb6eba5..e22a440 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1028,7 +1028,7 @@ static const struct regmap_config wm8960_regmap = {
 	.volatile_reg = wm8960_volatile,
 };
 
-static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
+static int wm8960_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8960_data *pdata = dev_get_platdata(&i2c->dev);
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index aade82e..f862f7b 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -937,7 +937,7 @@ static const struct regmap_config wm8961_regmap = {
 	.readable_reg = wm8961_readable,
 };
 
-static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
+static int wm8961_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8961_priv *wm8961;
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index de01896..dccc56f 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3588,7 +3588,7 @@ static const struct regmap_config wm8962_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
+static int wm8962_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8962_pdata *pdata = dev_get_platdata(&i2c->dev);
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index eea701e..6028e99 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -717,7 +717,7 @@ static const struct regmap_config wm8971_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static __devinit int wm8971_i2c_probe(struct i2c_client *i2c,
+static int wm8971_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index ff5e507..a1c8c52 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -625,7 +625,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 	.num_dapm_routes = ARRAY_SIZE(wm8974_dapm_routes),
 };
 
-static __devinit int wm8974_i2c_probe(struct i2c_client *i2c,
+static int wm8974_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	int ret;
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 5a8a0a3..7028f1a 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1038,7 +1038,7 @@ static const struct regmap_config wm8978_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(wm8978_reg_defaults),
 };
 
-static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
+static int wm8978_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8978_priv *wm8978;
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index e29c736..9b2b612 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -1087,7 +1087,7 @@ static const struct regmap_config wm8983_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8983_spi_probe(struct spi_device *spi)
+static int wm8983_spi_probe(struct spi_device *spi)
 {
 	struct wm8983_priv *wm8983;
 	int ret;
@@ -1127,7 +1127,7 @@ static struct spi_driver wm8983_spi_driver = {
 #endif
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8983_i2c_probe(struct i2c_client *i2c,
+static int wm8983_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8983_priv *wm8983;
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 4e1ef71..76c0503 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1111,7 +1111,7 @@ static const struct regmap_config wm8985_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8985_spi_probe(struct spi_device *spi)
+static int wm8985_spi_probe(struct spi_device *spi)
 {
 	struct wm8985_priv *wm8985;
 	int ret;
@@ -1163,7 +1163,7 @@ static struct spi_driver wm8985_spi_driver = {
 #endif
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8985_i2c_probe(struct i2c_client *i2c,
+static int wm8985_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8985_priv *wm8985;
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 1e6cb3e..20b0425 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -872,7 +872,7 @@ static struct regmap_config wm8988_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8988_spi_probe(struct spi_device *spi)
+static int wm8988_spi_probe(struct spi_device *spi)
 {
 	struct wm8988_priv *wm8988;
 	int ret;
@@ -918,7 +918,7 @@ static struct spi_driver wm8988_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
+static int wm8988_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8988_priv *wm8988;
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index db75bd2..a666c16 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1382,7 +1382,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8990_i2c_probe(struct i2c_client *i2c,
+static int wm8990_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8990_priv *wm8990;
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index e09efea..556e43f 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1357,7 +1357,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
 	.reg_cache_default = wm8991_reg_defs
 };
 
-static __devinit int wm8991_i2c_probe(struct i2c_client *i2c,
+static int wm8991_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8991_priv *wm8991;
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index d57ec80..0a7c29a 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1645,7 +1645,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
 	.set_bias_level = wm8993_set_bias_level,
 };
 
-static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
+static int wm8993_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8993_priv *wm8993;
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 52d4ec7..2c1e0b5 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4247,7 +4247,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 	.set_bias_level = wm8994_set_bias_level,
 };
 
-static int __devinit wm8994_probe(struct platform_device *pdev)
+static int wm8994_probe(struct platform_device *pdev)
 {
 	struct wm8994_priv *wm8994;
 
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 2503294..bbfb5b9 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2256,7 +2256,7 @@ static struct regmap_config wm8995_regmap = {
 };
 
 #if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8995_spi_probe(struct spi_device *spi)
+static int wm8995_spi_probe(struct spi_device *spi)
 {
 	struct wm8995_priv *wm8995;
 	int ret;
@@ -2310,7 +2310,7 @@ static struct spi_driver wm8995_spi_driver = {
 #endif
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8995_i2c_probe(struct i2c_client *i2c,
+static int wm8995_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8995_priv *wm8995;
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index ed7d6ed..49a4147 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2765,7 +2765,7 @@ static struct snd_soc_dai_driver wm8996_dai[] = {
 	},
 };
 
-static __devinit int wm8996_i2c_probe(struct i2c_client *i2c,
+static int wm8996_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8996_priv *wm8996;
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index d639602..f6b522a 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1327,7 +1327,7 @@ static const struct regmap_config wm9081_regmap = {
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
+static int wm9081_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm9081_priv *wm9081;
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 9c380f6..b330d7a 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -382,7 +382,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.num_dapm_routes = ARRAY_SIZE(wm9705_audio_map),
 };
 
-static __devinit int wm9705_probe(struct platform_device *pdev)
+static int wm9705_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm9705, wm9705_dai, ARRAY_SIZE(wm9705_dai));
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 73de205..c44ea10 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -685,7 +685,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.num_dapm_routes = ARRAY_SIZE(wm9712_audio_map),
 };
 
-static __devinit int wm9712_probe(struct platform_device *pdev)
+static int wm9712_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm9712, wm9712_dai, ARRAY_SIZE(wm9712_dai));
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 5e5afeb..0285223 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1254,7 +1254,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.num_dapm_routes = ARRAY_SIZE(wm9713_audio_map),
 };
 
-static __devinit int wm9713_probe(struct platform_device *pdev)
+static int wm9713_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_wm9713, wm9713_dai, ARRAY_SIZE(wm9713_dai));
diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 855b851..8a87f0e 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -93,7 +93,7 @@ static struct snd_soc_card eukrea_tlv320 = {
 	.num_links	= 1,
 };
 
-static int __devinit eukrea_tlv320_probe(struct platform_device *pdev)
+static int eukrea_tlv320_probe(struct platform_device *pdev)
 {
 	int ret;
 	int int_port = 0, ext_port;
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 36fbf7a..8a07360 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -894,7 +894,7 @@ static struct snd_pcm_ops fsl_dma_ops = {
 	.pointer	= fsl_dma_pointer,
 };
 
-static int __devinit fsl_soc_dma_probe(struct platform_device *pdev)
+static int fsl_soc_dma_probe(struct platform_device *pdev)
  {
 	struct dma_object *dma;
 	struct device_node *np = pdev->dev.of_node;
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4ed2afd..7decbd9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -639,7 +639,7 @@ static void make_lowercase(char *s)
 	}
 }
 
-static int __devinit fsl_ssi_probe(struct platform_device *pdev)
+static int fsl_ssi_probe(struct platform_device *pdev)
 {
 	struct fsl_ssi_private *ssi_private;
 	int ret = 0;
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index ff0266b..71454ae 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -244,7 +244,7 @@ int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 }
 EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 
-static int __devinit imx_audmux_probe(struct platform_device *pdev)
+static int imx_audmux_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct pinctrl *pinctrl;
diff --git a/sound/soc/fsl/imx-mc13783.c b/sound/soc/fsl/imx-mc13783.c
index ed027c2..6803e0a 100644
--- a/sound/soc/fsl/imx-mc13783.c
+++ b/sound/soc/fsl/imx-mc13783.c
@@ -98,7 +98,7 @@ static struct snd_soc_card imx_mc13783 = {
 	.num_dapm_routes = ARRAY_SIZE(imx_mc13783_routes),
 };
 
-static int __devinit imx_mc13783_probe(struct platform_device *pdev)
+static int imx_mc13783_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 4252e16..d0ebbfa 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -154,7 +154,7 @@ static struct snd_soc_platform_driver imx_soc_platform_mx2 = {
 	.pcm_free	= imx_pcm_free,
 };
 
-static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
+static int imx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_mx2);
 }
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 8d88642..5a452a4 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -281,7 +281,7 @@ static struct snd_soc_platform_driver imx_soc_platform_fiq = {
 	.pcm_free	= imx_pcm_fiq_free,
 };
 
-static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
+static int imx_soc_platform_probe(struct platform_device *pdev)
 {
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 	int ret;
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index dc646b2..013322c 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -56,7 +56,7 @@ static const struct snd_soc_dapm_widget imx_sgtl5000_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 };
 
-static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
+static int imx_sgtl5000_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ssi_np, *codec_np;
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index da6d6d9..8a7ec26 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -277,7 +277,7 @@ static struct snd_soc_dai_driver psc_ac97_dai[] = {
  * - Probe/remove operations
  * - OF device match table
  */
-static int __devinit psc_ac97_of_probe(struct platform_device *op)
+static int psc_ac97_of_probe(struct platform_device *op)
 {
 	int rc;
 	struct snd_ac97 ac97;
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index e25c62d..328b9df 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -153,7 +153,7 @@ static struct snd_soc_dai_driver psc_i2s_dai[] = {{
  * - Probe/remove operations
  * - OF device match table
  */
-static int __devinit psc_i2s_of_probe(struct platform_device *op)
+static int psc_i2s_of_probe(struct platform_device *op)
 {
 	int rc;
 	struct psc_dma *psc_dma;
diff --git a/sound/soc/fsl/mx27vis-aic32x4.c b/sound/soc/fsl/mx27vis-aic32x4.c
index 687b830..e88a5ea 100644
--- a/sound/soc/fsl/mx27vis-aic32x4.c
+++ b/sound/soc/fsl/mx27vis-aic32x4.c
@@ -180,7 +180,7 @@ static struct snd_soc_card mx27vis_aic32x4 = {
 	.num_dapm_routes = ARRAY_SIZE(aic32x4_dapm_routes),
 };
 
-static int __devinit mx27vis_aic32x4_probe(struct platform_device *pdev)
+static int mx27vis_aic32x4_probe(struct platform_device *pdev)
 {
 	struct snd_mx27vis_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 940e0f3..21051b3 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -425,7 +425,7 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.resume = jz4740_i2s_resume,
 };
 
-static int __devinit jz4740_i2s_dev_probe(struct platform_device *pdev)
+static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct jz4740_i2s *i2s;
 	int ret;
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
index c7b61ab..770e4e2 100644
--- a/sound/soc/jz4740/jz4740-pcm.c
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -335,7 +335,7 @@ static struct snd_soc_platform_driver jz4740_soc_platform = {
 		.pcm_free	= jz4740_pcm_free,
 };
 
-static int __devinit jz4740_pcm_probe(struct platform_device *pdev)
+static int jz4740_pcm_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &jz4740_soc_platform);
 }
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 5c15950..5937ddf 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -96,7 +96,7 @@ static const struct gpio qi_lb60_gpios[] = {
 	{ QI_LB60_AMP_GPIO, GPIOF_OUT_INIT_LOW, "AMP" },
 };
 
-static int __devinit qi_lb60_probe(struct platform_device *pdev)
+static int qi_lb60_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &qi_lb60;
 	int ret;
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index da85321..23ead2b 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -369,7 +369,7 @@ static struct snd_soc_platform_driver kirkwood_soc_platform = {
 	.pcm_free	= kirkwood_dma_free_dma_buffers,
 };
 
-static int __devinit kirkwood_soc_platform_probe(struct platform_device *pdev)
+static int kirkwood_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
 }
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 4565dc3..2c6e99f 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -398,7 +398,7 @@ static struct snd_soc_dai_driver kirkwood_i2s_dai = {
 	.ops = &kirkwood_i2s_dai_ops,
 };
 
-static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
+static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
 	struct kirkwood_asoc_platform_data *data =
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index f8518dc..1c682ef 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -71,7 +71,7 @@ static struct snd_soc_card openrd_client = {
 	.num_links = ARRAY_SIZE(openrd_client_dai),
 };
 
-static int __devinit openrd_probe(struct platform_device *pdev)
+static int openrd_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &openrd_client;
 	int ret;
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index d66b21e..bc142a7 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -92,7 +92,7 @@ static struct snd_soc_card t5325 = {
 	.num_dapm_routes = ARRAY_SIZE(t5325_route),
 };
 
-static int __devinit t5325_probe(struct platform_device *pdev)
+static int t5325_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &t5325;
 	int ret;
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index c703870..671eb18 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -358,7 +358,7 @@ static irqreturn_t snd_mfld_jack_detection(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int __devinit snd_mfld_mc_probe(struct platform_device *pdev)
+static int snd_mfld_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0, irq;
 	struct mfld_mc_private *mc_drv_ctx;
diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index f82d766..d41c770 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -220,7 +220,7 @@ static struct snd_soc_platform_driver mxs_soc_platform = {
 	.pcm_free	= mxs_pcm_free,
 };
 
-int __devinit mxs_pcm_platform_register(struct device *dev)
+int mxs_pcm_platform_register(struct device *dev)
 {
 	return snd_soc_register_platform(dev, &mxs_soc_platform);
 }
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 93fe366..c8c882a 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -655,7 +655,7 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit mxs_saif_probe(struct platform_device *pdev)
+static int mxs_saif_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *iores, *dmares;
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index add904e..638c42d 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -112,7 +112,7 @@ static struct snd_soc_card mxs_sgtl5000 = {
 	.num_links	= ARRAY_SIZE(mxs_sgtl5000_dai),
 };
 
-static int __devinit mxs_sgtl5000_probe_dt(struct platform_device *pdev)
+static int mxs_sgtl5000_probe_dt(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *saif_np[2], *codec_np;
@@ -145,7 +145,7 @@ static int __devinit mxs_sgtl5000_probe_dt(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devinit mxs_sgtl5000_probe(struct platform_device *pdev)
+static int mxs_sgtl5000_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mxs_sgtl5000;
 	int ret;
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index a2171bf..0121557 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -314,7 +314,7 @@ static struct snd_soc_dai_driver nuc900_ac97_dai = {
 	.ops = &nuc900_ac97_dai_ops,
 };
 
-static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
+static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 {
 	struct nuc900_audio *nuc900_audio;
 	int ret;
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index ca49f9d..37d8cc3 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -337,7 +337,7 @@ static struct snd_soc_platform_driver nuc900_soc_platform = {
 	.pcm_free	= nuc900_dma_free_dma_buffers,
 };
 
-static int __devinit nuc900_soc_platform_probe(struct platform_device *pdev)
+static int nuc900_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &nuc900_soc_platform);
 }
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 9c0107e..1acab65 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -575,7 +575,7 @@ static struct snd_soc_card ams_delta_audio_card = {
 };
 
 /* Module init/exit */
-static __devinit int ams_delta_probe(struct platform_device *pdev)
+static int ams_delta_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &ams_delta_audio_card;
 	int ret;
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index afb8d4f..e166312 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -932,7 +932,7 @@ static const struct attribute_group sidetone_attr_group = {
 	.attrs = (struct attribute **)sidetone_attrs,
 };
 
-static int __devinit omap_st_add(struct omap_mcbsp *mcbsp,
+static int omap_st_add(struct omap_mcbsp *mcbsp,
 				 struct resource *res)
 {
 	struct omap_mcbsp_st_data *st_data;
@@ -959,7 +959,7 @@ static int __devinit omap_st_add(struct omap_mcbsp *mcbsp,
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
  * 730 has only 2 McBSP, and both of them are MPU peripherals.
  */
-int __devinit omap_mcbsp_init(struct platform_device *pdev)
+int omap_mcbsp_init(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 49a6725..27bf6c3 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -341,7 +341,7 @@ int omap_st_enable(struct omap_mcbsp *mcbsp);
 int omap_st_disable(struct omap_mcbsp *mcbsp);
 int omap_st_is_enabled(struct omap_mcbsp *mcbsp);
 
-int __devinit omap_mcbsp_init(struct platform_device *pdev);
+int omap_mcbsp_init(struct platform_device *pdev);
 void __devexit omap_mcbsp_sysfs_remove(struct omap_mcbsp *mcbsp);
 
 #endif /* __ASOC_MCBSP_H */
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index ab439fe..a594ebf 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -273,7 +273,7 @@ static struct snd_soc_card omap_abe_card = {
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
-static __devinit int omap_abe_probe(struct platform_device *pdev)
+static int omap_abe_probe(struct platform_device *pdev)
 {
 	struct omap_abe_twl6040_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index d101541..bd46176 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -448,7 +448,7 @@ static struct snd_soc_dai_driver omap_dmic_dai = {
 	.ops = &omap_dmic_dai_ops,
 };
 
-static __devinit int asoc_dmic_probe(struct platform_device *pdev)
+static int asoc_dmic_probe(struct platform_device *pdev)
 {
 	struct omap_dmic *dmic;
 	struct resource *res;
diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index 290b94c..092d45c 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -45,7 +45,7 @@ static struct snd_soc_card snd_soc_omap_hdmi = {
 	.num_links = 1,
 };
 
-static __devinit int omap_hdmi_probe(struct platform_device *pdev)
+static int omap_hdmi_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_omap_hdmi;
 	int ret;
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 7225e7c..3845781 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -262,7 +262,7 @@ static struct snd_soc_dai_driver omap_hdmi_dai = {
 	.ops = &omap_hdmi_dai_ops,
 };
 
-static __devinit int omap_hdmi_probe(struct platform_device *pdev)
+static int omap_hdmi_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *hdmi_rsrc;
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 734a6dc..316ea7d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -758,7 +758,7 @@ static const struct of_device_id omap_mcbsp_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_mcbsp_of_match);
 
-static __devinit int asoc_mcbsp_probe(struct platform_device *pdev)
+static int asoc_mcbsp_probe(struct platform_device *pdev)
 {
 	struct omap_mcbsp_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct omap_mcbsp *mcbsp;
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 9a37da1..803ff6a 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -429,7 +429,7 @@ void omap_mcpdm_configure_dn_offsets(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(omap_mcpdm_configure_dn_offsets);
 
-static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
+static int asoc_mcpdm_probe(struct platform_device *pdev)
 {
 	struct omap_mcpdm *mcpdm;
 	struct resource *res;
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 0fb8614..21f927b 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -302,7 +302,7 @@ static struct snd_soc_platform_driver omap_soc_platform = {
 	.pcm_free	= omap_pcm_free_dma_buffers,
 };
 
-static __devinit int omap_pcm_probe(struct platform_device *pdev)
+static int omap_pcm_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev,
 			&omap_soc_platform);
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index c356c6f..c505ec2 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -107,7 +107,7 @@ static struct snd_soc_card omap_twl4030_card = {
 	.num_links = ARRAY_SIZE(omap_twl4030_dai_links),
 };
 
-static __devinit int omap_twl4030_probe(struct platform_device *pdev)
+static int omap_twl4030_probe(struct platform_device *pdev)
 {
 	struct omap_tw4030_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 162532b..8c5b325 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -140,7 +140,7 @@ static struct snd_soc_card brownstone = {
 	.num_dapm_routes = ARRAY_SIZE(brownstone_audio_map),
 };
 
-static int __devinit brownstone_probe(struct platform_device *pdev)
+static int brownstone_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index d74cc33..3e08dcf 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -303,7 +303,7 @@ static struct snd_soc_card corgi = {
 	.num_dapm_routes = ARRAY_SIZE(corgi_audio_map),
 };
 
-static int __devinit corgi_probe(struct platform_device *pdev)
+static int corgi_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &corgi;
 	int ret;
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index f2c828e..189d77c 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -144,7 +144,7 @@ static struct gpio e740_audio_gpios[] = {
 	{ GPIO_E740_WM9705_nAVDD2, GPIOF_OUT_INIT_HIGH, "Audio power" },
 };
 
-static int __devinit e740_probe(struct platform_device *pdev)
+static int e740_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &e740;
 	int ret;
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index fb38914..319d55b 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -126,7 +126,7 @@ static struct gpio e750_audio_gpios[] = {
 	{ GPIO_E750_SPK_AMP_OFF, GPIOF_OUT_INIT_HIGH, "Speaker amp" },
 };
 
-static int __devinit e750_probe(struct platform_device *pdev)
+static int e750_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &e750;
 	int ret;
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 9a93cae..9fa2cd1 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -116,7 +116,7 @@ static struct gpio e800_audio_gpios[] = {
 	{ GPIO_E800_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH, "Speaker amp" },
 };
 
-static int __devinit e800_probe(struct platform_device *pdev)
+static int e800_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &e800;
 	int ret;
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 368cd51..40c07b3 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -183,7 +183,7 @@ static struct gpio hx4700_audio_gpios[] = {
 	{ GPIO92_HX4700_HP_DRIVER, GPIOF_OUT_INIT_LOW, "EP_POWER" },
 };
 
-static int __devinit hx4700_audio_probe(struct platform_device *pdev)
+static int hx4700_audio_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index d8b123b..e89441d 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -65,7 +65,7 @@ static struct snd_soc_card imote2 = {
 	.num_links = 1,
 };
 
-static int __devinit imote2_probe(struct platform_device *pdev)
+static int imote2_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &imote2;
 	int ret;
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index c02d1da..135a839 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -186,7 +186,7 @@ static struct snd_soc_card mioa701 = {
 	.num_links = ARRAY_SIZE(mioa701_dai),
 };
 
-static int __devinit mioa701_wm9713_probe(struct platform_device *pdev)
+static int mioa701_wm9713_probe(struct platform_device *pdev)
 {
 	int rc;
 
diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 3e8cb21..1324673 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -257,7 +257,7 @@ struct snd_soc_platform_driver mmp_soc_platform = {
 	.pcm_free	= mmp_pcm_free_dma_buffers,
 };
 
-static __devinit int mmp_pcm_probe(struct platform_device *pdev)
+static int mmp_pcm_probe(struct platform_device *pdev)
 {
 	struct mmp_audio_platdata *pdata = pdev->dev.platform_data;
 
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
index acdbdcf..c97ce5b0 100644
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -405,7 +405,7 @@ struct snd_soc_dai_driver mmp_sspa_dai = {
 	.ops = &mmp_sspa_dai_ops,
 };
 
-static __devinit int asoc_mmp_sspa_probe(struct platform_device *pdev)
+static int asoc_mmp_sspa_probe(struct platform_device *pdev)
 {
 	struct sspa_priv *priv;
 	struct resource *res;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 48ba129..bc00684 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -269,7 +269,7 @@ static struct snd_soc_card poodle = {
 	.num_dapm_routes = ARRAY_SIZE(poodle_audio_map),
 };
 
-static int __devinit poodle_probe(struct platform_device *pdev)
+static int poodle_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &poodle;
 	int ret;
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 9d13de0..6a61748 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -794,7 +794,7 @@ static struct snd_soc_dai_driver pxa_ssp_dai = {
 		.ops = &pxa_ssp_dai_ops,
 };
 
-static __devinit int asoc_ssp_probe(struct platform_device *pdev)
+static int asoc_ssp_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_dai(&pdev->dev, &pxa_ssp_dai);
 }
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 19224cb..0a6194d 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -104,7 +104,7 @@ static int pxa2xx_ac97_resume(struct snd_soc_dai *dai)
 #define pxa2xx_ac97_resume	NULL
 #endif
 
-static int __devinit pxa2xx_ac97_probe(struct snd_soc_dai *dai)
+static int pxa2xx_ac97_probe(struct snd_soc_dai *dai)
 {
 	return pxa2xx_ac97_hw_probe(to_platform_device(dai->dev));
 }
@@ -234,7 +234,7 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
-static __devinit int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
+static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 96cd23d..9d6f78a 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -120,7 +120,7 @@ static struct snd_soc_platform_driver pxa2xx_soc_platform = {
 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
 
-static int __devinit pxa2xx_soc_platform_probe(struct platform_device *pdev)
+static int pxa2xx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &pxa2xx_soc_platform);
 }
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index fca9e41..4f6d8b1 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -241,7 +241,7 @@ static struct snd_soc_card tosa = {
 	.num_links = ARRAY_SIZE(tosa_dai),
 };
 
-static int __devinit tosa_probe(struct platform_device *pdev)
+static int tosa_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &tosa;
 	int ret;
diff --git a/sound/soc/pxa/ttc-dkb.c b/sound/soc/pxa/ttc-dkb.c
index 0e22e68..490c76c 100644
--- a/sound/soc/pxa/ttc-dkb.c
+++ b/sound/soc/pxa/ttc-dkb.c
@@ -131,7 +131,7 @@ static struct snd_soc_card ttc_dkb_card = {
 	.num_dapm_routes = ARRAY_SIZE(ttc_audio_map),
 };
 
-static int __devinit ttc_dkb_probe(struct platform_device *pdev)
+static int ttc_dkb_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &ttc_dkb_card;
 	int ret;
diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index aa44a4f..79abcd0 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -436,7 +436,7 @@ static struct snd_soc_dai_driver s6000_i2s_dai = {
 	.ops = &s6000_i2s_dai_ops,
 };
 
-static int __devinit s6000_i2s_probe(struct platform_device *pdev)
+static int s6000_i2s_probe(struct platform_device *pdev)
 {
 	struct s6000_i2s_dev *dev;
 	struct resource *scbmem, *sifmem, *region, *dma1, *dma2;
diff --git a/sound/soc/s6000/s6000-pcm.c b/sound/soc/s6000/s6000-pcm.c
index af245bc..d4672ba 100644
--- a/sound/soc/s6000/s6000-pcm.c
+++ b/sound/soc/s6000/s6000-pcm.c
@@ -500,7 +500,7 @@ static struct snd_soc_platform_driver s6000_soc_platform = {
 	.pcm_free = 	s6000_pcm_free,
 };
 
-static int __devinit s6000_soc_platform_probe(struct platform_device *pdev)
+static int s6000_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &s6000_soc_platform);
 }
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index a9f9632d..1d097f7 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -370,7 +370,7 @@ static struct snd_soc_dai_driver s3c_ac97_dai[] = {
 	},
 };
 
-static __devinit int s3c_ac97_probe(struct platform_device *pdev)
+static int s3c_ac97_probe(struct platform_device *pdev)
 {
 	struct resource *mem_res, *dmatx_res, *dmarx_res, *dmamic_res, *irq_res;
 	struct s3c_audio_pdata *ac97_pdata;
diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 0e02d14..f7545ac 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -412,7 +412,7 @@ static struct snd_soc_card bells_cards[] = {
 };
 
 
-static __devinit int bells_probe(struct platform_device *pdev)
+static int bells_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index f02896e..3705a8a 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -432,7 +432,7 @@ static struct snd_soc_platform_driver samsung_asoc_platform = {
 	.pcm_free	= dma_free_dma_buffers,
 };
 
-static int __devinit samsung_asoc_platform_probe(struct platform_device *pdev)
+static int samsung_asoc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &samsung_asoc_platform);
 }
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ec4567b..6a60e71 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -950,8 +950,7 @@ static const struct snd_soc_dai_ops samsung_i2s_dai_ops = {
 					SNDRV_PCM_FMTBIT_S16_LE | \
 					SNDRV_PCM_FMTBIT_S24_LE)
 
-static __devinit
-struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
+static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 {
 	struct i2s_dai *i2s;
 
@@ -992,7 +991,7 @@ struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev, bool sec)
 	return i2s;
 }
 
-static __devinit int samsung_i2s_probe(struct platform_device *pdev)
+static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	u32 dma_pl_chan, dma_cp_chan, dma_pl_sec_chan;
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 9db1a5d..136285b 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -416,7 +416,7 @@ static struct snd_soc_platform_driver asoc_idma_platform = {
 	.pcm_free = idma_free,
 };
 
-static int __devinit asoc_idma_platform_probe(struct platform_device *pdev)
+static int asoc_idma_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &asoc_idma_platform);
 }
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index c84e1ac..0d06249 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -297,7 +297,7 @@ static struct snd_soc_card littlemill = {
 	.late_probe = littlemill_late_probe,
 };
 
-static __devinit int littlemill_probe(struct platform_device *pdev)
+static int littlemill_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &littlemill;
 	int ret;
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 782ee23..e4f08fc 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -180,7 +180,7 @@ static struct snd_soc_card lowland = {
 	.num_dapm_routes = ARRAY_SIZE(audio_paths),
 };
 
-static __devinit int lowland_probe(struct platform_device *pdev)
+static int lowland_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &lowland;
 	int ret;
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 918f943..3708658 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -490,7 +490,7 @@ static struct snd_soc_dai_driver s3c_pcm_dai[] = {
 	},
 };
 
-static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
+static int s3c_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_pcm_info *pcm;
 	struct resource *mem_res, *dmatx_res, *dmarx_res;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 83fd46a..e2db71e 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -160,7 +160,7 @@ static struct snd_soc_dai_driver s3c2412_i2s_dai = {
 	.ops = &s3c2412_i2s_dai_ops,
 };
 
-static __devinit int s3c2412_iis_dev_probe(struct platform_device *pdev)
+static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 {
 	return s3c_i2sv2_register_dai(&pdev->dev, -1, &s3c2412_i2s_dai);
 }
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 347676f..05491d9 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -465,7 +465,7 @@ static struct snd_soc_dai_driver s3c24xx_i2s_dai = {
 	.ops = &s3c24xx_i2s_dai_ops,
 };
 
-static __devinit int s3c24xx_iis_dev_probe(struct platform_device *pdev)
+static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_dai(&pdev->dev, &s3c24xx_i2s_dai);
 }
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index 335a7d8..98b7c98 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -313,7 +313,7 @@ const struct dev_pm_ops simtec_audio_pmops = {
 EXPORT_SYMBOL_GPL(simtec_audio_pmops);
 #endif
 
-int __devinit simtec_audio_core_probe(struct platform_device *pdev,
+int simtec_audio_core_probe(struct platform_device *pdev,
 				      struct snd_soc_card *card)
 {
 	struct platform_device *snd_dev;
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index df40b8a..80617c3 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -99,7 +99,7 @@ static struct snd_soc_card snd_soc_machine_simtec_aic33 = {
 	.num_dapm_routes = ARRAY_SIZE(base_map),
 };
 
-static int __devinit simtec_audio_hermes_probe(struct platform_device *pd)
+static int simtec_audio_hermes_probe(struct platform_device *pd)
 {
 	dev_info(&pd->dev, "probing....\n");
 	return simtec_audio_core_probe(pd, &snd_soc_machine_simtec_aic33);
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index 2e64534..e359d3d 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -88,7 +88,7 @@ static struct snd_soc_card snd_soc_machine_simtec_aic23 = {
 	.num_dapm_routes = ARRAY_SIZE(base_map),
 };
 
-static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
+static int simtec_audio_tlv320aic23_probe(struct platform_device *pd)
 {
 	return simtec_audio_core_probe(pd, &snd_soc_machine_simtec_aic23);
 }
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index 73bef15..649997e 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -153,7 +153,7 @@ static struct snd_soc_card smdk_pcm = {
  * is absent (or not connected), so we connect EXT_VOICE_CLK(OSC4),
  * 2.0484Mhz, directly with MCLK both Codec and SoC.
  */
-static int __devinit snd_smdk_probe(struct platform_device *pdev)
+static int snd_smdk_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 7707d6e..1a01571 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -150,7 +150,7 @@ static struct snd_soc_card smdk = {
 };
 
 
-static int __devinit smdk_audio_probe(struct platform_device *pdev)
+static int smdk_audio_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card = &smdk;
diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 8bec27e..84d8f94 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -129,7 +129,7 @@ static struct snd_soc_card smdk_pcm = {
 	.num_links = 1,
 };
 
-static int __devinit snd_smdk_probe(struct platform_device *pdev)
+static int snd_smdk_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 9275a03..5612ea8 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -357,7 +357,7 @@ static struct snd_soc_dai_driver samsung_spdif_dai = {
 	.resume = spdif_resume,
 };
 
-static __devinit int spdif_probe(struct platform_device *pdev)
+static int spdif_probe(struct platform_device *pdev)
 {
 	struct s3c_audio_pdata *spdif_pdata;
 	struct resource *mem_res, *dma_res;
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 173f47c..01bad86 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -320,7 +320,7 @@ static struct snd_soc_card speyside = {
 	.late_probe = speyside_late_probe,
 };
 
-static __devinit int speyside_probe(struct platform_device *pdev)
+static int speyside_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &speyside;
 	int ret;
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index da7ce64..01d474c 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -214,7 +214,7 @@ static struct snd_soc_card tobermory = {
 	.late_probe = tobermory_late_probe,
 };
 
-static __devinit int tobermory_probe(struct platform_device *pdev)
+static int tobermory_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &tobermory;
 	int ret;
diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 7a50c2a..9b06724 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -348,7 +348,7 @@ static struct snd_soc_platform sh7760_soc_platform = {
 	.pcm_free	= camelot_pcm_free,
 };
 
-static int __devinit sh7760_soc_platform_probe(struct platform_device *pdev)
+static int sh7760_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
 }
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index dd00356..2efdd48 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -310,7 +310,7 @@ static struct snd_soc_dai_driver sh4_hac_dai[] = {
 #endif
 };
 
-static int __devinit hac_soc_platform_probe(struct platform_device *pdev)
+static int hac_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_dais(&pdev->dev, sh4_hac_dai,
 			ARRAY_SIZE(sh4_hac_dai));
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 7b1bc77..694cb96 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -726,7 +726,7 @@ static struct snd_soc_dai_driver siu_i2s_dai = {
 	.ops = &siu_dai_ops,
 };
 
-static int __devinit siu_probe(struct platform_device *pdev)
+static int siu_probe(struct platform_device *pdev)
 {
 	const struct firmware *fw_entry;
 	struct resource *res, *region;
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 768de1c..1b26656 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -379,7 +379,7 @@ static struct snd_soc_dai_driver sh4_ssi_dai[] = {
 #endif
 };
 
-static int __devinit sh4_soc_dai_probe(struct platform_device *pdev)
+static int sh4_soc_dai_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_dais(&pdev->dev, sh4_ssi_dai,
 			ARRAY_SIZE(sh4_ssi_dai));
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index d9a3ac9..813689d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -94,7 +94,7 @@ static struct snd_soc_dai_driver dummy_dai = {
 	.name = "snd-soc-dummy-dai",
 };
 
-static __devinit int snd_soc_dummy_probe(struct platform_device *pdev)
+static int snd_soc_dummy_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index 9f8f5cd..29c23d3 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -184,7 +184,7 @@ struct snd_soc_platform_driver spear_soc_platform = {
 	.pcm_free	=	spear_pcm_free,
 };
 
-static int __devinit spear_soc_platform_probe(struct platform_device *pdev)
+static int spear_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &spear_soc_platform);
 }
diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index 45c67e0..b0c29eb 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -131,7 +131,7 @@ static const struct regmap_config tegra20_das_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit tegra20_das_probe(struct platform_device *pdev)
+static int tegra20_das_probe(struct platform_device *pdev)
 {
 	struct resource *res, *region;
 	void __iomem *regs;
diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 1892a0c..256607f 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -331,7 +331,7 @@ static const struct regmap_config tegra20_i2s_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static __devinit int tegra20_i2s_platform_probe(struct platform_device *pdev)
+static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_i2s *i2s;
 	struct resource *mem, *memregion, *dmareq;
diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index ee04bae..8df9ab0 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -257,7 +257,7 @@ static const struct regmap_config tegra20_spdif_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static __devinit int tegra20_spdif_platform_probe(struct platform_device *pdev)
+static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 {
 	struct tegra20_spdif *spdif;
 	struct resource *mem, *memregion, *dmareq;
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index b167b1f..ed812d2 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -433,7 +433,7 @@ static const struct regmap_config tegra30_ahub_ahub_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit tegra30_ahub_probe(struct platform_device *pdev)
+static int tegra30_ahub_probe(struct platform_device *pdev)
 {
 	struct clk *clk;
 	int i;
diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index eb28f27..af2c187 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -391,7 +391,7 @@ static const struct regmap_config tegra30_i2s_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static __devinit int tegra30_i2s_platform_probe(struct platform_device *pdev)
+static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 {
 	struct tegra30_i2s *i2s;
 	u32 cif_ids[2];
diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 2ccffdb..bf40691 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -150,7 +150,7 @@ static struct snd_soc_card snd_soc_tegra_alc5632 = {
 	.fully_routed = true,
 };
 
-static __devinit int tegra_alc5632_probe(struct platform_device *pdev)
+static int tegra_alc5632_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct snd_soc_card *card = &snd_soc_tegra_alc5632;
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index e187339..4061984 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -253,7 +253,7 @@ static struct snd_soc_platform_driver tegra_pcm_platform = {
 	.pcm_free	= tegra_pcm_free,
 };
 
-int __devinit tegra_pcm_platform_register(struct device *dev)
+int tegra_pcm_platform_register(struct device *dev)
 {
 	return snd_soc_register_platform(dev, &tegra_pcm_platform);
 }
diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
index 7512884..f5ea8a9 100644
--- a/sound/soc/tegra/tegra_wm8753.c
+++ b/sound/soc/tegra/tegra_wm8753.c
@@ -122,7 +122,7 @@ static struct snd_soc_card snd_soc_tegra_wm8753 = {
 	.fully_routed = true,
 };
 
-static __devinit int tegra_wm8753_driver_probe(struct platform_device *pdev)
+static int tegra_wm8753_driver_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_tegra_wm8753;
 	struct tegra_wm8753 *machine;
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index a583a6b..fa838d3 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -252,7 +252,7 @@ static struct snd_soc_card snd_soc_tegra_wm8903 = {
 	.fully_routed = true,
 };
 
-static __devinit int tegra_wm8903_driver_probe(struct platform_device *pdev)
+static int tegra_wm8903_driver_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct snd_soc_card *card = &snd_soc_tegra_wm8903;
diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
index 8173551..5f98970 100644
--- a/sound/soc/tegra/trimslice.c
+++ b/sound/soc/tegra/trimslice.c
@@ -120,7 +120,7 @@ static struct snd_soc_card snd_soc_trimslice = {
 	.fully_routed = true,
 };
 
-static __devinit int tegra_snd_trimslice_probe(struct platform_device *pdev)
+static int tegra_snd_trimslice_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &snd_soc_trimslice;
 	struct tegra_trimslice *trimslice;
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index e3dd45e..4855398 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -170,7 +170,7 @@ static struct snd_soc_dai_driver txx9aclc_ac97_dai = {
 	},
 };
 
-static int __devinit txx9aclc_ac97_dev_probe(struct platform_device *pdev)
+static int txx9aclc_ac97_dev_probe(struct platform_device *pdev)
 {
 	struct txx9aclc_plat_drvdata *drvdata;
 	struct resource *r;
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 856a2cf..bdb8165 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -417,7 +417,7 @@ static struct snd_soc_platform_driver txx9aclc_soc_platform = {
 	.pcm_free	= txx9aclc_pcm_free_dma_buffers,
 };
 
-static int __devinit txx9aclc_soc_platform_probe(struct platform_device *pdev)
+static int txx9aclc_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &txx9aclc_soc_platform);
 }
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index c964d60..c04c927 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -71,7 +71,7 @@ static void mop500_of_node_put(void)
 	}
 }
 
-static int __devinit mop500_of_probe(struct platform_device *pdev,
+static int mop500_of_probe(struct platform_device *pdev,
 				struct device_node *np)
 {
 	struct device_node *codec_np, *msp_np[2];
@@ -99,7 +99,7 @@ static int __devinit mop500_of_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static int __devinit mop500_probe(struct platform_device *pdev)
+static int mop500_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 74bb3c0..5e9fc81 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -767,7 +767,7 @@ static struct snd_soc_dai_driver ux500_msp_dai_drv[UX500_NBR_OF_DAI] = {
 	},
 };
 
-static int __devinit ux500_msp_drv_probe(struct platform_device *pdev)
+static int ux500_msp_drv_probe(struct platform_device *pdev)
 {
 	struct ux500_msp_i2s_drvdata *drvdata;
 	int ret = 0;
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index b703532..9703b2d 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -296,7 +296,7 @@ static int __devexit ux500_pcm_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devinit ux500_pcm_drv_remove(struct platform_device *pdev)
+static int ux500_pcm_drv_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 5701787..5809a94 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -755,7 +755,7 @@ static struct snd_pcm_ops snd_amd7930_capture_ops = {
 	.pointer	=	snd_amd7930_capture_pointer,
 };
 
-static int __devinit snd_amd7930_pcm(struct snd_amd7930 *amd)
+static int snd_amd7930_pcm(struct snd_amd7930 *amd)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -884,7 +884,7 @@ static struct snd_kcontrol_new amd7930_controls[] __devinitdata = {
 	},
 };
 
-static int __devinit snd_amd7930_mixer(struct snd_amd7930 *amd)
+static int snd_amd7930_mixer(struct snd_amd7930 *amd)
 {
 	struct snd_card *card;
 	int idx, err;
@@ -933,7 +933,7 @@ static struct snd_device_ops snd_amd7930_dev_ops = {
 	.dev_free	=	snd_amd7930_dev_free,
 };
 
-static int __devinit snd_amd7930_create(struct snd_card *card,
+static int snd_amd7930_create(struct snd_card *card,
 					struct platform_device *op,
 					int irq, int dev,
 					struct snd_amd7930 **ramd)
@@ -1002,7 +1002,7 @@ static int __devinit snd_amd7930_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit amd7930_sbus_probe(struct platform_device *op)
+static int amd7930_sbus_probe(struct platform_device *op)
 {
 	struct resource *rp = &op->resource[0];
 	static int dev_num;
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 344eb3f..102ad1e 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -702,7 +702,7 @@ static int snd_cs4231_timer_stop(struct snd_timer *timer)
 	return 0;
 }
 
-static void __devinit snd_cs4231_init(struct snd_cs4231 *chip)
+static void snd_cs4231_init(struct snd_cs4231 *chip)
 {
 	unsigned long flags;
 
@@ -1019,7 +1019,7 @@ static snd_pcm_uframes_t snd_cs4231_capture_pointer(
 	return bytes_to_frames(substream->runtime, ptr);
 }
 
-static int __devinit snd_cs4231_probe(struct snd_cs4231 *chip)
+static int snd_cs4231_probe(struct snd_cs4231 *chip)
 {
 	unsigned long flags;
 	int i;
@@ -1218,7 +1218,7 @@ static struct snd_pcm_ops snd_cs4231_capture_ops = {
 	.pointer	=	snd_cs4231_capture_pointer,
 };
 
-static int __devinit snd_cs4231_pcm(struct snd_card *card)
+static int snd_cs4231_pcm(struct snd_card *card)
 {
 	struct snd_cs4231 *chip = card->private_data;
 	struct snd_pcm *pcm;
@@ -1247,7 +1247,7 @@ static int __devinit snd_cs4231_pcm(struct snd_card *card)
 	return 0;
 }
 
-static int __devinit snd_cs4231_timer(struct snd_card *card)
+static int snd_cs4231_timer(struct snd_card *card)
 {
 	struct snd_cs4231 *chip = card->private_data;
 	struct snd_timer *timer;
@@ -1537,7 +1537,7 @@ CS4231_SINGLE("Line Out Switch", 0, CS4231_PIN_CTRL, 6, 1, 1),
 CS4231_SINGLE("Headphone Out Switch", 0, CS4231_PIN_CTRL, 7, 1, 1)
 };
 
-static int __devinit snd_cs4231_mixer(struct snd_card *card)
+static int snd_cs4231_mixer(struct snd_card *card)
 {
 	struct snd_cs4231 *chip = card->private_data;
 	int err, idx;
@@ -1558,7 +1558,7 @@ static int __devinit snd_cs4231_mixer(struct snd_card *card)
 
 static int dev;
 
-static int __devinit cs4231_attach_begin(struct snd_card **rcard)
+static int cs4231_attach_begin(struct snd_card **rcard)
 {
 	struct snd_card *card;
 	struct snd_cs4231 *chip;
@@ -1589,7 +1589,7 @@ static int __devinit cs4231_attach_begin(struct snd_card **rcard)
 	return 0;
 }
 
-static int __devinit cs4231_attach_finish(struct snd_card *card)
+static int cs4231_attach_finish(struct snd_card *card)
 {
 	struct snd_cs4231 *chip = card->private_data;
 	int err;
@@ -1793,7 +1793,7 @@ static struct snd_device_ops snd_cs4231_sbus_dev_ops = {
 	.dev_free	=	snd_cs4231_sbus_dev_free,
 };
 
-static int __devinit snd_cs4231_sbus_create(struct snd_card *card,
+static int snd_cs4231_sbus_create(struct snd_card *card,
 					    struct platform_device *op,
 					    int dev)
 {
@@ -1856,7 +1856,7 @@ static int __devinit snd_cs4231_sbus_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit cs4231_sbus_probe(struct platform_device *op)
+static int cs4231_sbus_probe(struct platform_device *op)
 {
 	struct resource *rp = &op->resource[0];
 	struct snd_card *card;
@@ -1959,7 +1959,7 @@ static struct snd_device_ops snd_cs4231_ebus_dev_ops = {
 	.dev_free	=	snd_cs4231_ebus_dev_free,
 };
 
-static int __devinit snd_cs4231_ebus_create(struct snd_card *card,
+static int snd_cs4231_ebus_create(struct snd_card *card,
 					    struct platform_device *op,
 					    int dev)
 {
@@ -2048,7 +2048,7 @@ static int __devinit snd_cs4231_ebus_create(struct snd_card *card,
 	return 0;
 }
 
-static int __devinit cs4231_ebus_probe(struct platform_device *op)
+static int cs4231_ebus_probe(struct platform_device *op)
 {
 	struct snd_card *card;
 	int err;
@@ -2072,7 +2072,7 @@ static int __devinit cs4231_ebus_probe(struct platform_device *op)
 }
 #endif
 
-static int __devinit cs4231_probe(struct platform_device *op)
+static int cs4231_probe(struct platform_device *op)
 {
 #ifdef EBUS_SUPPORT
 	if (!strcmp(op->dev.of_node->parent->name, "ebus"))
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 55c80c4..8763ba0 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -745,7 +745,7 @@ static void dbri_reset(struct snd_dbri *dbri)
 }
 
 /* Lock must not be held before calling this */
-static void __devinit dbri_initialize(struct snd_dbri *dbri)
+static void dbri_initialize(struct snd_dbri *dbri)
 {
 	s32 *cmd;
 	u32 dma_addr;
@@ -1305,7 +1305,7 @@ to the DBRI via the CHI interface and few of the DBRI's PIO pins.
  * Lock must not be held before calling it.
 
 */
-static __devinit void cs4215_setup_pipes(struct snd_dbri *dbri)
+static void cs4215_setup_pipes(struct snd_dbri *dbri)
 {
 	unsigned long flags;
 
@@ -1338,7 +1338,7 @@ static __devinit void cs4215_setup_pipes(struct snd_dbri *dbri)
 	dbri_cmdwait(dbri);
 }
 
-static __devinit int cs4215_init_data(struct cs4215 *mm)
+static int cs4215_init_data(struct cs4215 *mm)
 {
 	/*
 	 * No action, memory resetting only.
@@ -1630,7 +1630,7 @@ static int cs4215_prepare(struct snd_dbri *dbri, unsigned int rate,
 /*
  *
  */
-static __devinit int cs4215_init(struct snd_dbri *dbri)
+static int cs4215_init(struct snd_dbri *dbri)
 {
 	u32 reg2 = sbus_readl(dbri->regs + REG2);
 	dprintk(D_MM, "cs4215_init: reg2=0x%x\n", reg2);
@@ -2217,7 +2217,7 @@ static struct snd_pcm_ops snd_dbri_ops = {
 	.pointer = snd_dbri_pointer,
 };
 
-static int __devinit snd_dbri_pcm(struct snd_card *card)
+static int snd_dbri_pcm(struct snd_card *card)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -2436,7 +2436,7 @@ static struct snd_kcontrol_new dbri_controls[] __devinitdata = {
 	CS4215_SINGLE("Mic boost", 4, 4, 1, 1)
 };
 
-static int __devinit snd_dbri_mixer(struct snd_card *card)
+static int snd_dbri_mixer(struct snd_card *card)
 {
 	int idx, err;
 	struct snd_dbri *dbri;
@@ -2500,7 +2500,7 @@ static void dbri_debug_read(struct snd_info_entry *entry,
 }
 #endif
 
-static void __devinit snd_dbri_proc(struct snd_card *card)
+static void snd_dbri_proc(struct snd_card *card)
 {
 	struct snd_dbri *dbri = card->private_data;
 	struct snd_info_entry *entry;
@@ -2523,7 +2523,7 @@ static void __devinit snd_dbri_proc(struct snd_card *card)
 */
 static void snd_dbri_free(struct snd_dbri *dbri);
 
-static int __devinit snd_dbri_create(struct snd_card *card,
+static int snd_dbri_create(struct snd_card *card,
 				     struct platform_device *op,
 				     int irq, int dev)
 {
@@ -2593,7 +2593,7 @@ static void snd_dbri_free(struct snd_dbri *dbri)
 				  (void *)dbri->dma, dbri->dma_dvma);
 }
 
-static int __devinit dbri_probe(struct platform_device *op)
+static int dbri_probe(struct platform_device *op)
 {
 	struct snd_dbri *dbri;
 	struct resource *rp;
diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index a887ef7..7f39fa2 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -330,7 +330,7 @@ static struct snd_pcm_ops at73c213_playback_ops = {
 	.pointer	= snd_at73c213_pcm_pointer,
 };
 
-static int __devinit snd_at73c213_pcm_new(struct snd_at73c213 *chip, int device)
+static int snd_at73c213_pcm_new(struct snd_at73c213 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int retval;
@@ -709,7 +709,7 @@ AT73C213_MONO_SWITCH("Aux Capture Switch", 0, DAC_CTRL, DAC_CTRL_ONAUXIN,
 AT73C213_MONO_SWITCH("Line Capture Switch", 0, DAC_CTRL, 0, 0x03, 0),
 };
 
-static int __devinit snd_at73c213_mixer(struct snd_at73c213 *chip)
+static int snd_at73c213_mixer(struct snd_at73c213 *chip)
 {
 	struct snd_card *card;
 	int errval, idx;
@@ -744,7 +744,7 @@ cleanup:
 /*
  * Device functions
  */
-static int __devinit snd_at73c213_ssc_init(struct snd_at73c213 *chip)
+static int snd_at73c213_ssc_init(struct snd_at73c213 *chip)
 {
 	/*
 	 * Continuous clock output.
@@ -774,7 +774,7 @@ static int __devinit snd_at73c213_ssc_init(struct snd_at73c213 *chip)
 	return 0;
 }
 
-static int __devinit snd_at73c213_chip_init(struct snd_at73c213 *chip)
+static int snd_at73c213_chip_init(struct snd_at73c213 *chip)
 {
 	int retval;
 	unsigned char dac_ctrl = 0;
@@ -879,7 +879,7 @@ static int snd_at73c213_dev_free(struct snd_device *device)
 	return 0;
 }
 
-static int __devinit snd_at73c213_dev_init(struct snd_card *card,
+static int snd_at73c213_dev_init(struct snd_card *card,
 					 struct spi_device *spi)
 {
 	static struct snd_device_ops ops = {
@@ -940,7 +940,7 @@ out:
 	return retval;
 }
 
-static int __devinit snd_at73c213_probe(struct spi_device *spi)
+static int snd_at73c213_probe(struct spi_device *spi)
 {
 	struct snd_card			*card;
 	struct snd_at73c213		*chip;
-- 
1.8.0
