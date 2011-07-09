Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7088B1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Jul 2011 20:14:18 +1000 (EST)
Date: Sat, 9 Jul 2011 12:14:09 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/5200: add GPIO functions for simple interrupt
	GPIOs
Message-ID: <20110709121409.4ee9249e@wker>
In-Reply-To: <20110706175245.GL5805@ponder.secretlab.ca>
References: <1306142730-7528-1-git-send-email-agust@denx.de>
	<20110706175245.GL5805@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 6 Jul 2011 11:52:45 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Mon, May 23, 2011 at 11:25:30AM +0200, Anatolij Gustschin wrote:
> > The mpc52xx_gpio driver currently supports 8 wakeup GPIOs and 32
> > simple GPIOs. Extend it to also support GPIO function of 8 simple
> > interrupt GPIOs controlled in the standard GPIO register module.
> > 
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > ---
> >  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  117 ++++++++++++++++++++++++++++
> 
> I don't want to merge more open coded MMIO gpio driver code.  This whole driver really needs to be converted to use GENERIC_GPIO.

I'm not sure I understand what you mean. Do you mean
the conversion to drop of_mm_* stuff?

Thanks,
Anatolij
