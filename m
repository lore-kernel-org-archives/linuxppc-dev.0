Return-Path: <yangbo.lu@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0057.outbound.protection.outlook.com [104.47.1.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6q3d4PkQzDvJv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 20:35:41 +1100 (AEDT)
From: "Y.B. Lu" <yangbo.lu@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Scott Wood
 <oss@buserror.net>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "X.B. Xie" <xiaobo.xie@nxp.com>, "M.H. Lian"
 <minghuan.lian@nxp.com>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Russell King
 <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Kumar
 Gala" <galak@codeaurora.org>
Subject: RE: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Mon, 31 Oct 2016 09:35:33 +0000
Message-ID: <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <1477637418-38938-4-git-send-email-yangbo.lu@nxp.com>
 <2723366.1bJeJ7SKI6@wuerfel>
In-Reply-To: <2723366.1bJeJ7SKI6@wuerfel>
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

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Friday, October 28, 2016 6:53 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Y.B. Lu; linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Scott
> Wood; Mark Rutland; Greg Kroah-Hartman; X.B. Xie; M.H. Lian; linux-
> i2c@vger.kernel.org; linux-clk@vger.kernel.org; Qiang Zhao; Russell King;
> Bhupesh Sharma; Joerg Roedel; Claudiu Manoil; devicetree@vger.kernel.org;
> Rob Herring; Santosh Shilimkar; linux-arm-kernel@lists.infradead.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Leo Li;
> iommu@lists.linux-foundation.org; Kumar Gala
> Subject: Re: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
>=20
> On Friday, October 28, 2016 2:50:14 PM CEST Yangbo Lu wrote:
> > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a common
> > header file.  This SVR numberspace is used on some ARM chips as well
> > as PPC, and even to check for a PPC SVR multi-arch drivers would
> > otherwise need to ifdef the header inclusion and all references to the
> SVR symbols.
> >
> >
>=20
> I don't see any of the contents of this header referenced by the soc
> driver any more. I think you can just drop this patch.
>=20

[Lu Yangbo-B47093] This header file was included by guts.c.
The guts driver used macro SVR_MAJ/SVR_MIN for calculation.

This header file was for powerpc arch before. And this patch is to made it =
as common header file for both ARM and PPC.
Sooner or later this is needed.

> 	Arnd
