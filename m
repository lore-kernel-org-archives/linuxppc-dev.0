Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC7B52C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 07:43:30 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [RFC 0/7] mpc5200 ASoC and pcm030 board fixes
Date: Thu, 13 Sep 2012 17:43:09 -0400
Message-Id: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is a respin of "mpc5200 ASoC fixups"

The mpc5200 ASoC and pcm030 board code compiled, but did not run after the
multi-codec patches.  This series add the missing pieces into the mpc5200 ASoC
drivers and updates the pcm030 board to the current api.

Eric Millbrandt (7):
  powerpc/52xx: define FSL_SOC
  ASoC: fsl: mpc5200 combine psc_dma platform data
  ASoC: fsl: mpc5200 add missing information to snd_soc_dai_driver
  ASoC: fsl: cleanup headers in pcm030-audio-fabric
  ASoC: fsl: convert pcm030-audio-fabric to a platform-driver
  ASoC: fsl: convert pcm030-audio-fabric to use snd_soc_register_card
  ASoC: fsl: register the wm9712-codec

 arch/powerpc/platforms/52xx/Kconfig |    1 +
 sound/soc/fsl/mpc5200_dma.c         |   24 ++-------
 sound/soc/fsl/mpc5200_dma.h         |    3 +
 sound/soc/fsl/mpc5200_psc_ac97.c    |   10 ++++
 sound/soc/fsl/mpc5200_psc_i2s.c     |    8 +++
 sound/soc/fsl/pcm030-audio-fabric.c |  100 +++++++++++++++++++++++++---------
 6 files changed, 99 insertions(+), 47 deletions(-)

-- 
1.7.2.5
