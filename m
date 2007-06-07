Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A956DDF10
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:08:42 +1000 (EST)
Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
From: Jon Loeliger <jdl@freescale.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1181150240.5674.139.camel@rhino>
References: <1181149064.5674.134.camel@rhino>
	<1181149622.12740.32.camel@ld0161-tx32>
	<1181150240.5674.139.camel@rhino>
Content-Type: text/plain
Message-Id: <1181232488.31686.19.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 07 Jun 2007 11:08:08 -0500
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

On Wed, 2007-06-06 at 12:17, Wade Farnsworth wrote:

> > 
> > Did you miss where I ACK'ed it 16-May-2007? :-)
> 
> Ah okay, maybe I don't understand what that means.  When you say
> "Acked-by" does that mean you'll push it upstream?

I meant that I picked the patch up, applied it to my tree,
tested it, and verified that _I_ thought it was good.
It received my Vote of Confidence, for whatever that is worth.

> What I meant was I haven't seen anybody pick up this patch yet, and
> would like to know it if will be, or if there is something else I need
> to do.

Right.  This patch is in "generic" PowerPC related code,
and not in my area to "push upstream".  I would expect, say,
Paul to pick it up directly.  Perhaps Kumar would pick it up
and stage it for Paul.  Perhaps akpm would pick it up. :-)

> --Wade

HTH,
jdl
