Return-Path: <shawn.guo@linaro.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D1FA2C0339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 23:33:07 +1000 (EST)
Date: Fri, 12 Jul 2013 21:32:57 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Message-ID: <20130712133255.GJ25501@S2101-09.ap.freescale.net>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712084328.GW24508@sirena.org.uk> <51DFF277.7020105@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <51DFF277.7020105@tabi.org>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolin Chen <b42378@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 12, 2013 at 07:11:35AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> >Yes, that's why I just went ahead - you'd said recently that you'd be
> >out of action for a while and not able to test anything.
> 
> Yeah, I'd rather you waited until I at least made sure it compiled.
> Is there any way you can at least install the Freescale PowerPC SDK
> and do compile tests?  At least that way you won't have to wait for
> me for every little thing.

I just compile-tested it with mpc85xx_defconfig.  It compiles good.

Shawn
