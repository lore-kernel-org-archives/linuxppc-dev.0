Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlqMG44DrzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 06:43:06 +1000 (AEST)
Message-ID: <1467924174.32358.69.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Arnd Bergmann <arnd@arndb.de>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Mark
 Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Qiang Zhao
 <qiang.zhao@nxp.com>, Russell King <linux@arm.linux.org.uk>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>,  Joerg Roedel <joro@8bytes.org>, Claudiu
 Manoil <claudiu.manoil@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob
 Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Yang-Leo Li
 <leoyang.li@nxp.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Date: Thu, 07 Jul 2016 15:42:54 -0500
In-Reply-To: <4094106.qfxJu3tJbO@wuerfel>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1465609853.22191.151.camel@buserror.net>
 <HE1PR04MB0889646206BFAD68046F3473F83B0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <4094106.qfxJu3tJbO@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 2/4] soc: fsl: add GUTS driver for QorIQ platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-07 at 10:30 +0200, Arnd Bergmann wrote:
> On Thursday, July 7, 2016 2:35:33 AM CEST Yangbo Lu wrote:
> > 
> > Hi Arnd,
> > 
> > Could you reply when you see the email?
> > If your method doesn’t resolve the problem, we still want to use our old
> > patchset.
> > 
> > This guts driver had been discussed about one year and blocked many
> > workaround upstream.
> > So please help to review and comment soon.
> > 
> I don't really see how more discussion is going to help us here. I think
> I've made it pretty clear that I don't want to see another platform
> specific way to read an SoC revision and I've even sent a proof-of-concept
> patch to show how the interface can work, now it's up to you to fit the
> guts hardware into that and send a new patch series.

In which relevant maintainership capacity are you NACKing it?

-Scott
