Return-Path: <ulf.hansson@linaro.org>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r095X1QgdzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 17:43:43 +1000 (AEST)
Received: by mail-wm0-x230.google.com with SMTP id e201so175565999wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 May 2016 00:43:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
References: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
 <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
Date: Wed, 4 May 2016 09:43:38 +0200
Message-ID: <CAPDyKFoh7mfmMYxVxjG6jrRr6CuGKkuxdeON4yxX3yXFEamikg@mail.gmail.com>
Subject: Re: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Yangbo Lu <yangbo.lu@nxp.com>, Scott Wood <oss@buserror.net>,
 Qiang Zhao <qiang.zhao@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Xiaobo Xie <xiaobo.xie@nxp.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4 May 2016 at 05:24, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> Add maintainer entry for Freescale SoC driver including
> the QE library and the GUTS driver now. Also add maintainer
> for QE library.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

So I need an ack from Scott and Qiang for this one, then I intend to
queue up the series.

Kind regards
Uffe

> ---
> Changes for v8:
>         - Added this patch
> Changes for v9:
>         - Added linux-arm mail list
>         - Removed GUTS driver entry
> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42e65d1..ce91db7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4622,9 +4622,18 @@ F:       drivers/net/ethernet/freescale/fec_ptp.c
>  F:     drivers/net/ethernet/freescale/fec.h
>  F:     Documentation/devicetree/bindings/net/fsl-fec.txt
>
> +FREESCALE SOC DRIVER
> +M:     Scott Wood <oss@buserror.net>
> +L:     linuxppc-dev@lists.ozlabs.org
> +L:     linux-arm-kernel@lists.infradead.org
> +S:     Maintained
> +F:     drivers/soc/fsl/
> +F:     include/linux/fsl/
> +
>  FREESCALE QUICC ENGINE LIBRARY
> +M:     Qiang Zhao <qiang.zhao@nxp.com>
>  L:     linuxppc-dev@lists.ozlabs.org
> -S:     Orphan
> +S:     Maintained
>  F:     drivers/soc/fsl/qe/
>  F:     include/soc/fsl/*qe*.h
>  F:     include/soc/fsl/*ucc*.h
> --
> 2.1.0.27.g96db324
>
