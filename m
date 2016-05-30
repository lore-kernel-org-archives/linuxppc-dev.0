Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJHC930hQzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:14:29 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, Scott Wood <oss@buserror.net>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Kumar Gala <galak@codeaurora.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yang-Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [v10,
 7/7] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
Date: Mon, 30 May 2016 15:13:39 +0200
Message-ID: <11214004.Ypipe5qZMl@wuerfel>
In-Reply-To: <CAPDyKFqx2JMLzXoDxGCKFYMFV47+SegnkuWFXKvsQHK7L5w-1g@mail.gmail.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <HE1PR04MB0889852B7809A1CCFF8922ACF8410@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <CAPDyKFqx2JMLzXoDxGCKFYMFV47+SegnkuWFXKvsQHK7L5w-1g@mail.gmail.com>
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

On Thursday, May 26, 2016 9:44:10 AM CEST Ulf Hansson wrote:
> On 26 May 2016 at 06:05, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> > Hi Uffe,
> >
> > Could we merge this patchset? ...
> > It has been a long time to wait for Arnd's response...
> >
> > Thanks a lot.
> >
> >
> 
> As we are still in the merge window I won't queue anything but fixes.
> Let's give Arnd another week or so to respond.

I've got a patch series now that implements a method for matching
the soc ID, see the following emails.

	Arnd
