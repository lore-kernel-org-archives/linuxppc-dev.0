Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D43D42C0087
 for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2012 23:00:31 +1100 (EST)
Date: Sat, 20 Oct 2012 13:59:55 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2] powerpc: 52xx: nop out unsupported critical IRQs
Message-ID: <20121020135955.709e20a8@wker>
In-Reply-To: <1349947155-11540-1-git-send-email-w.sang@pengutronix.de>
References: <1349902593-16431-1-git-send-email-w.sang@pengutronix.de>
 <1349947155-11540-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Bonesio <bones@secretlab.ca>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, 11 Oct 2012 11:19:15 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Currently, when booting MPC52xx based platforms, we get:
> 
>         mpc52xx_irqhost_map: invalid irq: virq=16, l1=0, l2=3
>         irq: irq-16==>hwirq-0x3 mapping failed: -22
>         [WARNing skipped]
> 
> The warning is wrong since the mapping itself is valid. However, there is no
> support for that type of IRQ currently. Print a proper warning and bind the irq
> to a no_irq chip.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: John Bonesio <bones@secretlab.ca>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Change since V1: drop the default state since all possibilities for l1 are now
> 		 covered in the switch-statement.
> 
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |    9 +++++----

applied, thanks!

Anatolij
