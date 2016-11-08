Return-Path: <yangbo.lu@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0051.outbound.protection.outlook.com [104.47.2.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCg0n2hvWzDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 17:50:01 +1100 (AEDT)
From: "Y.B. Lu" <yangbo.lu@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
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
Date: Tue, 8 Nov 2016 06:49:51 +0000
Message-ID: <DB6PR0401MB25366BC8FF59C68E2823245EF8A60@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <2723366.1bJeJ7SKI6@wuerfel>
 <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <1543282.vWjeo4ynTa@wuerfel>
In-Reply-To: <1543282.vWjeo4ynTa@wuerfel>
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

Hi Arnd,


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Tuesday, November 08, 2016 5:20 AM
> To: Y.B. Lu
> Cc: linuxppc-dev@lists.ozlabs.org; linux-mmc@vger.kernel.org;
> ulf.hansson@linaro.org; Scott Wood; Mark Rutland; Greg Kroah-Hartman; X.B=
.
> Xie; M.H. Lian; linux-i2c@vger.kernel.org; linux-clk@vger.kernel.org;
> Qiang Zhao; Russell King; Bhupesh Sharma; Joerg Roedel; Claudiu Manoil;
> devicetree@vger.kernel.org; Rob Herring; Santosh Shilimkar; linux-arm-
> kernel@lists.infradead.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Leo Li; iommu@lists.linux-foundation.org; Kumar
> Gala
> Subject: Re: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
>=20
> On Monday, October 31, 2016 9:35:33 AM CET Y.B. Lu wrote:
> > >
> > > I don't see any of the contents of this header referenced by the soc
> > > driver any more. I think you can just drop this patch.
> > >
> >
> > [Lu Yangbo-B47093] This header file was included by guts.c.
> > The guts driver used macro SVR_MAJ/SVR_MIN for calculation.
> >
> > This header file was for powerpc arch before. And this patch is to
> > made it as common header file for both ARM and PPC.
> > Sooner or later this is needed.
>=20
> Let's discuss it once we actually need the header then, ok?

[Lu Yangbo-B47093] As I said, this header file was included by guts.c in pa=
tch 4.
The guts driver used macro SVR_MAJ/SVR_MIN for calculation which were defin=
ed in this header file.
Did you suggest we dropped this patch and just calculated them in driver?

Thanks :)


>=20
> 	Arnd
