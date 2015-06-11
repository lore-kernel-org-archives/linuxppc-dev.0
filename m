Return-Path: <zidan.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED8E21A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:12:01 +1000 (AEST)
Date: Thu, 11 Jun 2015 19:10:00 +0800
From: Zidan Wang <zidan.wang@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
CC: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.de>, <timur@tabi.org>,
 <Xiubo.Lee@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel][PATCH] ASoC: fsl: add imx-wm8960 machine driver
Message-ID: <20150611110958.GA23742@shlinux2>
References: <b2a3c323a0507f3706041e1da98da8375aa61576.1433923593.git.zidan.wang@freescale.com>
 <20150610183619.GA3103@Asurada-CZ80>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150610183619.GA3103@Asurada-CZ80>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2015 at 11:36:21AM -0700, Nicolin Chen wrote:
> On Wed, Jun 10, 2015 at 04:26:27PM +0800, Zidan Wang wrote:
> > This imx-wm8960 device-tree-only machine driver works with sai driver
> > and have below feature.
> > * support codec master and slave mode
> > * support headphone jack detect
> > * support headphone and micphone jack event
> > * support asrc<->sai<->wm8960 mode
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> 
> Above all, could you merge this into fsl-asoc-card?
> 
> It'd be nicer to have jack detection over there. And we can
> put PLL settings to the codec driver as Mark suggested.
> 
Hi Nicolin,

I want to modify imx-wm8960 and upstream it because our release is using it now. After
upstreaming imx-wm8960, i will try to merge it to fsl-asoc-card.

Best Regards,
Zidan Wang
> Thanks
> Nicolin
