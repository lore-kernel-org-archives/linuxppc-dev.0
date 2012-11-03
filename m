Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 03C852C0040
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2012 02:29:31 +1100 (EST)
Date: Sat, 3 Nov 2012 16:29:19 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2] powerpc: 52xx: nop out unsupported critical IRQs
Message-ID: <20121103162919.7507401f@wker>
In-Reply-To: <20121103142615.GB24952@pengutronix.de>
References: <1349902593-16431-1-git-send-email-w.sang@pengutronix.de>
 <1349947155-11540-1-git-send-email-w.sang@pengutronix.de>
 <20121020135955.709e20a8@wker>
 <20121103142615.GB24952@pengutronix.de>
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

On Sat, 3 Nov 2012 15:26:15 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> 
> > > Currently, when booting MPC52xx based platforms, we get:
> > > 
> > >         mpc52xx_irqhost_map: invalid irq: virq=16, l1=0, l2=3
> > >         irq: irq-16==>hwirq-0x3 mapping failed: -22
> > >         [WARNing skipped]
> > > 
> > > The warning is wrong since the mapping itself is valid. However, there is no
> > > support for that type of IRQ currently. Print a proper warning and bind the irq
> > > to a no_irq chip.
> > > 
> > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > applied, thanks!
> 
> Thanks, can we have that in 3.7. already?

I hope so, a pull request including this patch is pending.

Thanks,
Anatolij
