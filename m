Return-Path: <yangbo.lu@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0063.outbound.protection.outlook.com [104.47.1.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6q4m6ccqzDvMj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 20:36:40 +1100 (AEDT)
From: "Y.B. Lu" <yangbo.lu@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Scott Wood
 <oss@buserror.net>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "X.B. Xie" <xiaobo.xie@nxp.com>, "M.H. Lian"
 <minghuan.lian@nxp.com>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Russell King
 <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Joerg Roedel <joro@8bytes.org>, Jochen Friedrich <jochen@scram.de>, "Claudiu
 Manoil" <claudiu.manoil@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Kumar
 Gala" <galak@codeaurora.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [v15, 0/7] Fix eSDHC host version register bug
Date: Mon, 31 Oct 2016 09:36:33 +0000
Message-ID: <DB6PR0401MB25365B15D753E4D60A25C8F8F8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <3386858.dvuMhvkN3m@wuerfel>
In-Reply-To: <3386858.dvuMhvkN3m@wuerfel>
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
> Sent: Friday, October 28, 2016 6:54 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Y.B. Lu; linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Scott
> Wood; Mark Rutland; Greg Kroah-Hartman; X.B. Xie; M.H. Lian; linux-
> i2c@vger.kernel.org; linux-clk@vger.kernel.org; Qiang Zhao; Russell King;
> Bhupesh Sharma; Joerg Roedel; Jochen Friedrich; Claudiu Manoil;
> devicetree@vger.kernel.org; Rob Herring; Santosh Shilimkar;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Leo Li;
> iommu@lists.linux-foundation.org; Kumar Gala; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [v15, 0/7] Fix eSDHC host version register bug
>=20
> On Friday, October 28, 2016 2:50:11 PM CEST Yangbo Lu wrote:
> > This patchset is used to fix a host version register bug in the
> > T4240-R1.0-R2.0 eSDHC controller. To match the SoC version and
> > revision, 10 previous version patchsets had tried many methods but all
> of them were rejected by reviewers.
> > Such as
> >         - dts compatible method
> >         - syscon method
> >         - ifdef PPC method
> >         - GUTS driver getting SVR method Anrd suggested a
> > soc_device_match method in v10, and this is the only available method
> > left now. This v11 patchset introduces the soc_device_match interface
> > in soc driver.
> >
> > The first five patches of Yangbo are to add the GUTS driver. This is
> > used to register a soc device which contain soc version and revision
> information.
> > The other two patches introduce the soc_device_match method in soc
> > driver and apply it on esdhc driver to fix this bug.
> >
>=20
> Looks good overall. With patch 3 dropped (or an explanation why it's
> still needed), everything
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
=20
[Lu Yangbo-B47093] Thank you very much:) See my explaination in patch 3 ema=
il.

> 	Arnd
