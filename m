Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-qg0-x243.google.com (mail-qg0-x243.google.com
 [IPv6:2607:f8b0:400d:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B25DE1A0601
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 01:51:29 +1000 (AEST)
Received: by qgdz60 with SMTP id z60so1165942qgd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 08:51:27 -0700 (PDT)
Date: Thu, 11 Jun 2015 08:51:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, timur@tabi.org,
 Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel][PATCH] ASoC: fsl: add imx-wm8960 machine driver
Message-ID: <20150611155106.GA3036@Asurada>
References: <b2a3c323a0507f3706041e1da98da8375aa61576.1433923593.git.zidan.wang@freescale.com>
 <20150610183619.GA3103@Asurada-CZ80>
 <20150611110958.GA23742@shlinux2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150611110958.GA23742@shlinux2>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2015 at 07:10:00PM +0800, Zidan Wang wrote:

> > > This imx-wm8960 device-tree-only machine driver works with sai driver
> > > and have below feature.
> > > * support codec master and slave mode
> > > * support headphone jack detect
> > > * support headphone and micphone jack event
> > > * support asrc<->sai<->wm8960 mode
> > > 
> > > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > 
> > Above all, could you merge this into fsl-asoc-card?
> > 
> > It'd be nicer to have jack detection over there. And we can
> > put PLL settings to the codec driver as Mark suggested.

> I want to modify imx-wm8960 and upstream it because our release is using it now. After
> upstreaming imx-wm8960, i will try to merge it to fsl-asoc-card.

I knew your intention. That's why I suggested you to merge it directly
to fsl-asoc-card instead of making a duplicated copy of that. Remember
that getting code upstream should be a chance for us to improve thing.

If you find painstaking to handle it in parallel, you can focus on the
improvements of the WM8960 driver while I would help you on the dai-
link part. How about this?

Nicolin
