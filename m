Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCQNZ1pQ3zDvNT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 08:21:17 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: "Y.B. Lu" <yangbo.lu@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Scott Wood <oss@buserror.net>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "X.B. Xie" <xiaobo.xie@nxp.com>, "M.H. Lian" <minghuan.lian@nxp.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Qiang Zhao <qiang.zhao@nxp.com>, Russell King <linux@arm.linux.org.uk>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kumar Gala <galak@codeaurora.org>
Subject: Re: [v15, 3/7] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Mon, 07 Nov 2016 22:20:18 +0100
Message-ID: <1543282.vWjeo4ynTa@wuerfel>
In-Reply-To: <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <2723366.1bJeJ7SKI6@wuerfel>
 <DB6PR0401MB2536B1B2E6AC36BDC8FC540DF8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, October 31, 2016 9:35:33 AM CET Y.B. Lu wrote:
> > 
> > I don't see any of the contents of this header referenced by the soc
> > driver any more. I think you can just drop this patch.
> > 
> 
> [Lu Yangbo-B47093] This header file was included by guts.c.
> The guts driver used macro SVR_MAJ/SVR_MIN for calculation.
> 
> This header file was for powerpc arch before. And this patch is to made it as
> common header file for both ARM and PPC.
> Sooner or later this is needed.

Let's discuss it once we actually need the header then, ok?

	Arnd
