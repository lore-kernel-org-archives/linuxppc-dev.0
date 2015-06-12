Return-Path: <zidan.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0111.outbound.protection.outlook.com [157.56.110.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59D231A02D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 18:11:33 +1000 (AEST)
Date: Fri, 12 Jun 2015 16:09:32 +0800
From: Zidan Wang <zidan.wang@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
CC: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.de>, <timur@tabi.org>,
 <Xiubo.Lee@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel][PATCH] ASoC: fsl: add imx-wm8960 machine driver
Message-ID: <20150612080930.GB23608@shlinux2>
References: <b2a3c323a0507f3706041e1da98da8375aa61576.1433923593.git.zidan.wang@freescale.com>
 <20150610183619.GA3103@Asurada-CZ80> <20150611110958.GA23742@shlinux2>
 <20150611155106.GA3036@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150611155106.GA3036@Asurada>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2015 at 08:51:07AM -0700, Nicolin Chen wrote:
> On Thu, Jun 11, 2015 at 07:10:00PM +0800, Zidan Wang wrote:
> 
> > > > This imx-wm8960 device-tree-only machine driver works with sai driver
> > > > and have below feature.
> > > > * support codec master and slave mode
> > > > * support headphone jack detect
> > > > * support headphone and micphone jack event
> > > > * support asrc<->sai<->wm8960 mode
> > > > 
> > > > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > > 
> > > Above all, could you merge this into fsl-asoc-card?
> > > 
> > > It'd be nicer to have jack detection over there. And we can
> > > put PLL settings to the codec driver as Mark suggested.
> 
> > I want to modify imx-wm8960 and upstream it because our release is using it now. After
> > upstreaming imx-wm8960, i will try to merge it to fsl-asoc-card.
> 
> I knew your intention. That's why I suggested you to merge it directly
> to fsl-asoc-card instead of making a duplicated copy of that. Remember
> that getting code upstream should be a chance for us to improve thing.
> 
> If you find painstaking to handle it in parallel, you can focus on the
> improvements of the WM8960 driver while I would help you on the dai-
> link part. How about this?
> 
> Nicolin

The new imx7 release have two new codec wm8958 and wm8960. So we have two machine driver
imx-wm8960 and imx-wm8958 which should be upstreamed. I am appreciate that you can help me
merge the imx-wm8960 to fsl-asoc-card. And i will focus on wm8960 and wm8958 driver. And i
will try to merge imx-wm8958 to fsl-asoc-card.

Best Regards,
Zidan Wang 
