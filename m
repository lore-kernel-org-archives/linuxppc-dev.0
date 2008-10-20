Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 2A5EBDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Oct 2008 05:01:38 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2108562wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Oct 2008 11:01:37 -0700 (PDT)
Date: Mon, 20 Oct 2008 12:01:35 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] [MPC52XX] gpio: remove dead code
Message-ID: <20081020180135.GA13667@secretlab.ca>
References: <20081020171257.GC4362@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081020171257.GC4362@pengutronix.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2008 at 07:12:57PM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks, I'll pick this up.

> ---
>  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> index 8a455eb..07f89ae 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> @@ -363,11 +363,8 @@ static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, unsigned int gpio)
>  {
>  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
>  	struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
> -	unsigned int ret;
>  
>  	return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
> -
> -	return ret;
>  }
>  
>  static void
> -- 
> 1.5.6.5
> 
> -- 
>   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
