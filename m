Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33A561A0163
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 08:57:46 +1000 (EST)
Received: by mail-pa0-f49.google.com with SMTP id lf10so8799380pab.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 15:57:43 -0700 (PDT)
Date: Thu, 11 Sep 2014 15:57:37 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140911225737.GA13926@Alpha>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
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

On Thu, Sep 11, 2014 at 01:38:29PM +0800, Shengjiu Wang wrote:
> Move the ipg clock enable and disable operation to startup and shutdown,
> that is only enable ipg clock when ssi is working. Keep clock is disabled
> when ssi is in idle.
> otherwise, _fsl_ssi_set_dai_fmt function need to be called in probe,
> so add ipg clock control for it.

It seems to be no objection so far against my last suggestion to
use regmap's mmio_clk() for named ipg clk only. So you may still
consider about that.

Anyway, I'd like to do thing in parallel. So I just simply tested
it on my side and its works fine, it may still need to be tested
by others though.

Nicolin
