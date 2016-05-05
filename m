Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0084.outbound.protection.outlook.com [157.56.112.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0hCD6qWRzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 14:05:28 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Yangbo Lu <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Scott Wood
 <oss@buserror.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring
 <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jochen Friedrich
 <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>, Kumar Gala <galak@codeaurora.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>, "Xiaobo
 Xie" <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: RE: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
Date: Thu, 5 May 2016 02:31:27 +0000
Message-ID: <AM3PR04MB1185B5352C395FE8951CA5A5917C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
 <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-05-04 at 11:24 +0800, Yangbo Lu wrote:
> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Wednesday, May 04, 2016 11:25 AM
> To: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-clk@vger.kernel.org; linux-i2c@vger.kernel.=
org;
> iommu@lists.linux-foundation.org; netdev@vger.kernel.org
> Cc: ulf.hansson@linaro.org; Scott Wood <oss@buserror.net>; Mark Rutland
> <mark.rutland@arm.com>; Rob Herring <robh+dt@kernel.org>; Russell King
> <linux@arm.linux.org.uk>; Jochen Friedrich <jochen@scram.de>; Joerg Roede=
l
> <joro@8bytes.org>; Claudiu Manoil <claudiu.manoil@freescale.com>; Bhupesh
> Sharma <bhupesh.sharma@freescale.com>; Qiang Zhao
> <qiang.zhao@nxp.com>; Kumar Gala <galak@codeaurora.org>; Santosh
> Shilimkar <ssantosh@kernel.org>; Yang-Leo Li <leoyang.li@nxp.com>; Xiaobo
> Xie <xiaobo.xie@nxp.com>; Yangbo Lu <yangbo.lu@nxp.com>
> Subject: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
>=20
> Add maintainer entry for Freescale SoC driver including the QE library an=
d the
> GUTS driver now. Also add maintainer for QE library.
>=20
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
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42e65d1..ce91db7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4622,9 +4622,18 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
>  F:	drivers/net/ethernet/freescale/fec.h
>  F:	Documentation/devicetree/bindings/net/fsl-fec.txt
>=20
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
> --
> 2.1.0.27.g96db324

I am ok!

-Zhao Qiang
