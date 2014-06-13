Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F1021A055D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 20:05:58 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>, <vinod.koul@intel.com>, <s.hauer@pengutronix.de>
Subject: [RFC][PATCH 0/2] Add ASRC Peripheral to Peripheral driver
Date: Fri, 13 Jun 2014 18:07:03 +0800
Message-ID: <cover.1402653667.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, b02247@freescale.com, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, lgirdwood@gmail.com, b38343@freescale.com,
 perex@perex.cz, dmaengine@vger.kernel.org, robh+dt@kernel.org,
 galak@codeaurora.org, grant.likely@linaro.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches have a direct dependency between them. So we might
need to push them into one branch. And sorry for this :(

Patch-1 adds device to device support in SDMA driver along with a secondary
request in struct imx_dma_data which's requred in the Patch-2 ASRC driver.

Nicolin Chen (2):
  dma: imx-sdma: Add device to device support
  ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers

 .../devicetree/bindings/sound/fsl,asrc.txt         |   62 ++
 drivers/dma/imx-sdma.c                             |   40 +-
 include/linux/platform_data/dma-imx.h              |    1 +
 sound/soc/fsl/Kconfig                              |    9 +
 sound/soc/fsl/Makefile                             |    2 +
 sound/soc/fsl/fsl_asrc.c                           | 1031 ++++++++++++++++++++
 sound/soc/fsl/fsl_asrc.h                           |  431 ++++++++
 sound/soc/fsl/fsl_asrc_dma.c                       |  385 ++++++++
 8 files changed, 1956 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
 create mode 100644 sound/soc/fsl/fsl_asrc.c
 create mode 100644 sound/soc/fsl/fsl_asrc.h
 create mode 100644 sound/soc/fsl/fsl_asrc_dma.c

-- 
1.8.4
