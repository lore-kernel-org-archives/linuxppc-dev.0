Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0132.outbound.protection.outlook.com [207.46.100.132])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC5451A001B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 12:01:36 +1000 (EST)
Date: Fri, 12 Sep 2014 10:01:12 +0800
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, <mpa@pengutronix.de>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140912020110.GA414@audiosh1>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
 <20140911225737.GA13926@Alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140911225737.GA13926@Alpha>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 11, 2014 at 03:57:37PM -0700, Nicolin Chen wrote:
> On Thu, Sep 11, 2014 at 01:38:29PM +0800, Shengjiu Wang wrote:
> > Move the ipg clock enable and disable operation to startup and shutdown,
> > that is only enable ipg clock when ssi is working. Keep clock is disabled
> > when ssi is in idle.
> > otherwise, _fsl_ssi_set_dai_fmt function need to be called in probe,
> > so add ipg clock control for it.
> 
> It seems to be no objection so far against my last suggestion to
> use regmap's mmio_clk() for named ipg clk only. So you may still
> consider about that.
>
I think mmio_clk() can be put to another patch. and this patch only for clk_enable()
and clk_disable() operation.
 
> Anyway, I'd like to do thing in parallel. So I just simply tested
> it on my side and its works fine, it may still need to be tested
> by others though.
> 
> Nicolina

Hi Markus

could you please review it, and share your comments?

wang shengjiu
