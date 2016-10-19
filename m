Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szQ681YwYzDsrM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 19:27:11 +1100 (AEDT)
Date: Wed, 19 Oct 2016 10:27:15 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Y.B. Lu" <yangbo.lu@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Scott Wood <oss@buserror.net>,
 Arnd Bergmann <arnd@arndb.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "X.B. Xie" <xiaobo.xie@nxp.com>,
 "M.H. Lian" <minghuan.lian@nxp.com>
Subject: Re: [v12, 0/8] Fix eSDHC host version register bug
Message-ID: <20161019082715.GA6140@kroah.com>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
 <CAPDyKFoit0sTPpfi2=AHcdZsDwOJxbBX68O-1jBFL=5JN0m6_w@mail.gmail.com>
 <AM5PR0401MB2529BA70C6E7AF7C71631A47F8D20@AM5PR0401MB2529.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM5PR0401MB2529BA70C6E7AF7C71631A47F8D20@AM5PR0401MB2529.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 19, 2016 at 02:47:07AM +0000, Y.B. Lu wrote:
> + Greg
> 
> Hi Greg,
> 
> I submitted this patchset for a MMC bug fix, and introduce the below patch which needs your ACK.
> > > Arnd Bergmann (1):
> > >   base: soc: introduce soc_device_match() interface
> https://patchwork.kernel.org/patch/9342913/
> 
> Could you help to review it and give some comments or ACK.
> Thank you very much.

Now acked.
