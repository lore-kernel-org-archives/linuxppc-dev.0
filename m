Return-Path: <gustavo@embeddedor.com>
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.150.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41htMq4zddzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 02:50:47 +1000 (AEST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 19D2ACCD3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 11:27:01 -0500 (CDT)
Date: Fri, 3 Aug 2018 11:26:59 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/7] ASoC: Mark expected switch fall-throughs
Message-ID: <cover.1533312229.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

In preparation to enabling -Wimplicit-fallthrough, this patchset aims
to add some annotations in order to mark switch cases where we are
expecting to fall through.

Thanks

Gustavo A. R. Silva (7):
  ASoC: davinci-i2s: mark expected switch fall-through
  ASoC: fsl_esai: Mark expected switch fall-through
  ASoC: Intel: skl-pcm: Mark expected switch fall-through
  ASoC: omap-dmic: Mark expected switch fall-throughs
  ASoC: omap-mcpdm: MArk expected switch fall-throughs
  ASoC: samsung: i2s: Mark expected switch fall-through
  ASoC: core: mark expected switch fall-through

 sound/soc/davinci/davinci-i2s.c   | 1 +
 sound/soc/fsl/fsl_esai.c          | 1 +
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 sound/soc/omap/omap-dmic.c        | 2 ++
 sound/soc/omap/omap-mcpdm.c       | 4 ++++
 sound/soc/samsung/i2s.c           | 1 +
 sound/soc/soc-core.c              | 1 +
 7 files changed, 11 insertions(+)

-- 
2.7.4
