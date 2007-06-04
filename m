Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB95EDDEE1
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 04:50:40 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Jon Loeliger <jdl@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1180983026.9632.22.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 13:50:26 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-06-02 at 03:22, Segher Boessenkool wrote:
> >> "reg" included in "ranges"?  Something is wrong here.
> >
> > I think it's correct for soc nodes.
> 
> It is not.  "ranges" is the address space translation
> between the parent and child busses; "reg" is the stuff
> that's on the bridge device itself.
> 
> > At least, it appears that all of
> > the dts files with soc nodes do similar things (including this one even
> > without this patch).
> 
> Yes, but that doesn't make it right.

But removing it does break things.  I'm going to leave 
it as-is for now, and we can wrestle over "fixing" it
in a follow up patch.

Thanks,
jdl
