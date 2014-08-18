Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9CD91A003B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 18:39:35 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.de>, <nicoleotsuka@gmail.com>, <Li.Xiubo@freescale.com>,
 <shc_work@mail.ru>, <fabio.estevam@freescale.com>,
 <shengjiu.wang@freescale.com>, <xobs@kosagi.com>, <arnd@arndb.de>,
 <sfr@canb.auug.org.au>, <timur@tabi.org>
Subject: [PATCH V1 0/3] fix build error/warning in sound/soc/fsl
Date: Mon, 18 Aug 2014 16:38:37 +0800
Message-ID: <cover.1408350626.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series patch is for fixing build error/waring in sound/soc/fsl

Shengjiu Wang (3):
  ASoC: fsl: Kconfig: remove dependence of SND_IMX_SOC for
    SND_SOC_IMX_PCM_DMA
  ASoC: fsl-asoc-card: Fix build warning for maybe-uninitialized
  ASoC: fsl: fsl-asoc-card: Select SND_SOC_IMX_AUDMUX

 sound/soc/fsl/Kconfig         |    9 +++++----
 sound/soc/fsl/fsl-asoc-card.c |    9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.7.9.5
