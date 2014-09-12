Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C44DB1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 04:33:33 +1000 (EST)
Received: by mail-pa0-f48.google.com with SMTP id hz1so1837593pad.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 11:33:30 -0700 (PDT)
Date: Fri, 12 Sep 2014 11:33:24 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>, timur@tabi.org
Subject: Re: [PATCH V3] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140912183324.GA2738@Alpha>
References: <894383e00876763f22988fc5f3f9f232f939f923.1410517971.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <894383e00876763f22988fc5f3f9f232f939f923.1410517971.git.shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Li.Xiubo@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, broonie@kernel.org, mpa@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2014 at 06:35:15PM +0800, Shengjiu Wang wrote:
> Check if ipg clock is in clock-names property, then we can move the
> ipg clock enable and disable operation to startup and shutdown, that
> is only enable ipg clock when ssi is working and keep clock is disabled
> when ssi is in idle.
> But when the checking is failed, remain the clock control as before.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

The patch looks fine to me. I tested the has_ipg_clk_name == true
case, and it works fine. As long as there's no further objection,
I can give an Acked-by. (I think Timur and Markus may like to have
a test as well.)

Thank you
Nicolin
