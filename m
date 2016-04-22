Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qsBVT4dsKzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 09:22:41 +1000 (AEST)
Message-ID: <1461367352.32510.218.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, Zhao Qiang <qiang.zhao@freescale.com>, Russell
 King <linux@arm.linux.org.uk>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>,  scott.wood@nxp.com, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 leoyang.li@nxp.com, xiaobo.xie@nxp.com, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Fri, 22 Apr 2016 18:22:32 -0500
In-Reply-To: <1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
 <1461306464-19521-7-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [v8, 6/7] MAINTAINERS: add entry for Freescale SoC specific driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-22 at 14:27 +0800, Yangbo Lu wrote:
> Add maintainer entry for Freescale SoC specific driver including
> the QE library and the GUTS driver. Also add entry for GUTS driver
> and add maintainer for QE library.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v8:
> 	- Added this patch
> ---
>  MAINTAINERS | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d5b4be..d20aeb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4622,13 +4622,27 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
>  F:	drivers/net/ethernet/freescale/fec.h
>  F:	Documentation/devicetree/bindings/net/fsl-fec.txt
>  
> +FREESCALE SOC SPECIFIC DRIVER

FREESCALE SOC DRIVERS

> +M:	Scott Wood <oss@buserror.net>

Please CC me at this address, not the NXP address that you sent this to...

> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Maintained
> +F:	drivers/soc/fsl/
> +F:	include/linux/fsl/

This directory will contain drivers that work on PPC and ARM... I'm not 
sure what to put here in terms of mailing lists (we could put both, but 
people probably shouldn't spam both lists if only one arch is relevant 
to the patch), and whom to make pull requests to.
 
> +FREESCALE GUTS DRIVER
> +M:	Yangbo Lu <yangbo.lu@nxp.com>
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Maintained
> +F:	drivers/soc/fsl/guts.c

What about the header?

Does guts really need a separate maintainer from drivers/soc/fsl?

-Scott
