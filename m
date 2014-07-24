Return-Path: <shawn.guo@linaro.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 105F61A095C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 23:45:25 +1000 (EST)
Date: Thu, 24 Jul 2014 21:30:04 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: imx: Add the secondary request into the
 structure for imx-sdma
Message-ID: <20140724133002.GC6827@dragon>
References: <cover.1406189745.git.nicoleotsuka@gmail.com>
 <e47c36814695fd8c88ef063a9771cf097a128ec0.1406189745.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <e47c36814695fd8c88ef063a9771cf097a128ec0.1406189745.git.nicoleotsuka@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org,
 galak@codeaurora.org, grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 24, 2014 at 04:35:28PM +0800, Nicolin Chen wrote:
> SDMA supports device to device (per_2_per) scripts to handle DMA transfering
> between two peripheral devices. The per_2_per script, however, needs two dma
> requests from two sides while the current structure only defined one request.
> 
> So this patch just simply adds the secondary request so as to let SDMA and
> its user to add its implementation later.
> 
> [ Both change in the SDMA driver and its users like Freescale ASRC ASoC driver
>   should be taken along with this change in order to truly support per_2_per
>   sciprts. However, we here make an expediency by adding this first so that
>   we can add either side later since this patch won't break any function and
>   meanwhile it can make merge window more smoothly: we don't need to apply the
>   change inside dmaengine branch via ASoC tree any more. -- Nicolin ]
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
