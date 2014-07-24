Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 375EE1A013F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 18:45:14 +1000 (EST)
Date: Thu, 24 Jul 2014 16:25:46 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RFC][PATCH 0/2] Add ASRC Peripheral to Peripheral driver
Message-ID: <20140724082545.GA27595@MrMyself>
References: <cover.1402653667.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1402653667.git.nicoleotsuka@gmail.com>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, timur@tabi.org, lgirdwood@gmail.com,
 vinod.koul@intel.com, b42378@freescale.com, b02247@freescale.com,
 grant.likely@linaro.org, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, s.hauer@pengutronix.de, b38343@freescale.com,
 robh+dt@kernel.org, dan.j.williams@intel.com, perex@perex.cz,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, broonie@kernel.org,
 galak@codeaurora.org, dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 13, 2014 at 06:07:03PM +0800, Nicolin Chen wrote:
> This series of patches have a direct dependency between them. So we might
> need to push them into one branch. And sorry for this :(
> 
> Patch-1 adds device to device support in SDMA driver along with a secondary
> request in struct imx_dma_data which's requred in the Patch-2 ASRC driver.

I just sent a new version V2. So please disregard this version.

Thanks all,
Nicolin

> 
> Nicolin Chen (2):
>   dma: imx-sdma: Add device to device support
>   ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers
> 
>  .../devicetree/bindings/sound/fsl,asrc.txt         |   62 ++
>  drivers/dma/imx-sdma.c                             |   40 +-
>  include/linux/platform_data/dma-imx.h              |    1 +
>  sound/soc/fsl/Kconfig                              |    9 +
>  sound/soc/fsl/Makefile                             |    2 +
>  sound/soc/fsl/fsl_asrc.c                           | 1031 ++++++++++++++++++++
>  sound/soc/fsl/fsl_asrc.h                           |  431 ++++++++
>  sound/soc/fsl/fsl_asrc_dma.c                       |  385 ++++++++
>  8 files changed, 1956 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
>  create mode 100644 sound/soc/fsl/fsl_asrc.c
>  create mode 100644 sound/soc/fsl/fsl_asrc.h
>  create mode 100644 sound/soc/fsl/fsl_asrc_dma.c
> 
> -- 
> 1.8.4
> 
