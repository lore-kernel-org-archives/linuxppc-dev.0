Date: Thu, 1 Mar 2001 20:43:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@mvista.com>
Cc: Stefano Coluccini <s.coluccini@caen.it>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME5100 was RE:Bogus interrupt + little Makefile bug
Message-ID: <20010301204330.A28660@opus.bloom.county>
References: <20010228171203.A29030@beef.az.mvista.com> <NDBBIFIMCKPOADMAJOKMKEJBCPAA.s.coluccini@caen.it> <20010301081747.A30954@beef.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010301081747.A30954@beef.az.mvista.com>; from mporter@mvista.com on Thu, Mar 01, 2001 at 08:17:48AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 01, 2001 at 08:17:48AM -0700, Matt Porter wrote:
>
> [Followups trimmed to only the embedded list]
>
> On Thu, Mar 01, 2001 at 10:55:33AM +0100, Stefano Coluccini wrote:
> > > Ok, I finally got time today to powerup the 5100 that's been laying
> > > around here.  I just pushed the port to the linuxppc_2_5 tree.
> > > Hopefully this saves some effort for others.
> >
> > Very great work !!!
> >
> > I have found a little bug in arch/ppc/boot/pp3/Makefile:
> > the rule to make zImage.initrd miss the -pbp option in the mkprep
> > invocation.
>
> Ah, thanks.  A typo from the great bootloader reorganization, it seems.

Quite probably.  If people in the know (Matt.. :) could check the other
prep-ish board-dirs to make sure mkprep is invoked properly..

> > I've seen that in the make menuconfig, selecting the MVME5100, does not
> > display the possibility to specify the default kernel command line. Don't
> > you think this is an useful option ?
>
> Oversight.  I just turned it on for a bunch of boards.

...and will "soon" be always an option.  I think it's only useless right now
on CHRP/PMAC stand alone kernels.  I of course need to check this out before I
turn it on, and can probably make them use it too..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
