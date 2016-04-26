Return-Path: <yangbo.lu@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0060.outbound.protection.outlook.com [157.55.234.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qv6pY6snszDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 12:43:17 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Scott Wood <scott.wood@nxp.com>, Rob Herring <robh+dt@kernel.org>, "Russell
 King" <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>, "Joerg
 Roedel" <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>, Zhao Qiang
 <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>, Xiaobo
 Xie <xiaobo.xie@nxp.com>
Subject: RE: [v8, 1/7] Documentation: DT: update Freescale DCFG compatible
Date: Tue, 26 Apr 2016 02:43:10 +0000
Message-ID: <HE1PR04MB0889A68C6D275D3102382D8BF8630@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1461306464-19521-1-git-send-email-yangbo.lu@nxp.com>
 <1461306464-19521-2-git-send-email-yangbo.lu@nxp.com>
 <20160422131151.GJ10606@leverpostej>
In-Reply-To: <20160422131151.GJ10606@leverpostej>
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

Hi Mark,


> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Friday, April 22, 2016 9:12 PM
> To: Yangbo Lu
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-clk@vger.kernel.org; linux-
> i2c@vger.kernel.org; iommu@lists.linux-foundation.org;
> netdev@vger.kernel.org; ulf.hansson@linaro.org; Scott Wood; Rob Herring;
> Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> Sharma; Zhao Qiang; Kumar Gala; Santosh Shilimkar; Yang-Leo Li; Xiaobo
> Xie
> Subject: Re: [v8, 1/7] Documentation: DT: update Freescale DCFG
> compatible
>=20
> On Fri, Apr 22, 2016 at 02:27:38PM +0800, Yangbo Lu wrote:
> > Update Freescale DCFG compatible with 'fsl,<chip>-dcfg' instead of
> > 'fsl,ls1021a-dcfg' to include more chips.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > ---
> > Changes for v8:
> > 	- Added this patch
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> > b/Documentation/devicetree/bindings/arm/fsl.txt
> > index 752a685..1d5f512 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -119,7 +119,7 @@ Freescale DCFG
> >  configuration and status for the device. Such as setting the
> > secondary  core start address and release the secondary core from
> holdoff and startup.
> >    Required properties:
> > -  - compatible: should be "fsl,ls1021a-dcfg"
> > +  - compatible: should be "fsl,<chip>-dcfg"
>=20
> Please list specific values expected for <chip>, while jusy saying <chip>
> may be more generic, it makes it practically impossible to search for the
> correct binding given a compatible string, and it's vague as to exaclty
> what <chip> should be.

[Lu Yangbo-B47093] Thanks for your comment. I will list the possible chips.

>=20
> Thanks,
> Mark.
>=20
>=20
>=20
> >    - reg : should contain base address and length of DCFG
> > memory-mapped registers
> >
> >  Example:
> > --
> > 2.1.0.27.g96db324
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
