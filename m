Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0QD94GQdzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 03:35:21 +1000 (AEST)
Message-ID: <1462383308.16584.43.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: ulf.hansson@linaro.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring
 <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jochen
 Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>,  Qiang Zhao <qiang.zhao@nxp.com>, Kumar
 Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 leoyang.li@nxp.com, xiaobo.xie@nxp.com
Date: Wed, 04 May 2016 12:35:08 -0500
In-Reply-To: <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
References: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
 <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-05-04 at 11:24 +0800, Yangbo Lu wrote:
> Add maintainer entry for Freescale SoC driver including
> the QE library and the GUTS driver now. Also add maintainer
> for QE library.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v8:
> 	- Added this patch
> Changes for v9:
> 	- Added linux-arm mail list
> 	- Removed GUTS driver entry
> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42e65d1..ce91db7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4622,9 +4622,18 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
>  F:	drivers/net/ethernet/freescale/fec.h
>  F:	Documentation/devicetree/bindings/net/fsl-fec.txt
>  
> +FREESCALE SOC DRIVER
> +M:	Scott Wood <oss@buserror.net>
> +L:	linuxppc-dev@lists.ozlabs.org
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/soc/fsl/
> +F:	include/linux/fsl/
> +
>  FREESCALE QUICC ENGINE LIBRARY
> +M:	Qiang Zhao <qiang.zhao@nxp.com>
>  L:	linuxppc-dev@lists.ozlabs.org
> -S:	Orphan
> +S:	Maintained
>  F:	drivers/soc/fsl/qe/
>  F:	include/soc/fsl/*qe*.h
>  F:	include/soc/fsl/*ucc*.h

s/DRIVER/DRIVERS/

There's more than one.

Otherwise:
Acked-by: Scott Wood <oss@buserror.net>

-Scott

> 
