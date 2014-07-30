Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C2B31A01E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 13:08:12 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH 0/4] ASoC: fsl: Add stream names to CPU DAI drivers for DPCM
Date: Wed, 30 Jul 2014 11:10:25 +0800
Message-ID: <cover.1406688048.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 timur@tabi.org, Li.Xiubo@freescale.com, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DPCM needs extra dapm routes in the machine driver to route audio
between Front-End and Back-End. In order to differ the stream names
in the route map from CODECs, we here add specific stream names to
all Freescale ASoC CPU DAI drivers so that we can implement ASRC via
DPCM to each of them.

Document for DPCM: ./Documentation/sound/alsa/soc/DPCM.txt

Nicolin Chen (4):
  ASoC: fsl_esai: Add stream names for DPCM usage
  ASoC: fsl_sai: Add stream names for DPCM usage
  ASoC: fsl_spdif: Add stream names for DPCM usage
  ASoC: fsl_ssi: Add stream names for DPCM usage

 sound/soc/fsl/fsl_esai.c  | 2 ++
 sound/soc/fsl/fsl_sai.c   | 2 ++
 sound/soc/fsl/fsl_spdif.c | 2 ++
 sound/soc/fsl/fsl_ssi.c   | 2 ++
 4 files changed, 8 insertions(+)

-- 
1.8.4
