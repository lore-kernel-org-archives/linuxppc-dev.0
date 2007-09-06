Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89566DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 13:01:58 +1000 (EST)
Date: Wed, 5 Sep 2007 22:01:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/9] 8xx: Fix CONFIG_PIN_TLB.
Message-ID: <20070906030146.GA12955@ld0162-tx32.am.freescale.net>
References: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
	<4F58F233-56E5-4910-9D33-28A44FCB393C@embeddedalley.com>
	<20070905205301.GA807@ld0162-tx32.am.freescale.net>
	<CF1B6B97-44FA-4002-9030-3C1A20F2F2F4@embeddedalley.com>
	<20070905222310.GA11433@ld0162-tx32.am.freescale.net>
	<04819433-30F0-4789-864D-57B474485E32@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <04819433-30F0-4789-864D-57B474485E32@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 03:42:03PM -0700, Dan Malek wrote:
> On Sep 5, 2007, at 3:23 PM, Scott Wood wrote:
> 
> >The IMMRs I've seen from the bootloader are ff000000 (Freescale  
> >boards)
> >and fa200000 (Embedded Planet).  AFAICT, the number of fixed TLB  
> >entries
> >is fixed at 4 on these chips, so using the fourth for flash  
> >wouldn't take
> >away any general-purpose TLB entries.
> 
> On these same boards, the memory controllers are usually
> configured to put the flash somewhere in that space as well.

Not on any of the boards I've worked with.

> >I certainly agree that it would be nice to check -- my immediate goal
> >is to get things working, though.
> 
> It's more than nice.  If you want this to work correctly and also get
> the performance enhancement, it needs to be done.

And my point was that getting that performance enhancement is "nice". 
It's not there now.  If you want to submit a patch to add it, go right
ahead, but it's not really related to this patch.

-Scott
