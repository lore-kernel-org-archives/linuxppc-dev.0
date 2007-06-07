Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id EFE9EDDF0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:33:01 +1000 (EST)
Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1181232488.31686.19.camel@ld0161-tx32>
References: <1181149064.5674.134.camel@rhino>
	<1181149622.12740.32.camel@ld0161-tx32>
	<1181150240.5674.139.camel@rhino>
	<1181232488.31686.19.camel@ld0161-tx32>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:33:00 -0700
Message-Id: <1181233980.5674.174.camel@rhino>
Mime-Version: 1.0
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 11:08 -0500, Jon Loeliger wrote:
> On Wed, 2007-06-06 at 12:17, Wade Farnsworth wrote:
> 
> > > 
> > > Did you miss where I ACK'ed it 16-May-2007? :-)
> > 
> > Ah okay, maybe I don't understand what that means.  When you say
> > "Acked-by" does that mean you'll push it upstream?
> 
> I meant that I picked the patch up, applied it to my tree,
> tested it, and verified that _I_ thought it was good.
> It received my Vote of Confidence, for whatever that is worth.

Ok.  Thanks for acking it by the way.

> 
> > What I meant was I haven't seen anybody pick up this patch yet, and
> > would like to know it if will be, or if there is something else I need
> > to do.
> 
> Right.  This patch is in "generic" PowerPC related code,
> and not in my area to "push upstream".  I would expect, say,
> Paul to pick it up directly.  Perhaps Kumar would pick it up
> and stage it for Paul.  Perhaps akpm would pick it up. :-)
> 

But since this is in drivers/rtc/Kconfig, wouldn't the maintainer of
that subsystem be expected to pick this up?

Thanks for the clarifications.

--Wade
