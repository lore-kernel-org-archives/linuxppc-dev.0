Date: Mon, 4 Aug 2003 08:41:50 -0700
From: Larry McVoy <lm@bitmover.com>
To: Michel D?nzer <michel@daenzer.net>
Cc: Larry McVoy <lm@bitmover.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.0-test2-bk2 (linus' tree) -- arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to `cpufreq_frequency_table_verify'
Message-ID: <20030804154150.GB30195@work.bitmover.com>
References: <200308031456.11550.miles.lane@comcast.net> <1059948097.602.1.camel@gaston> <16174.17597.565364.862198@cargo.ozlabs.ibm.com> <20030804152619.GA30195@work.bitmover.com> <1060011549.900.50.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1060011549.900.50.camel@thor.holligenstrasse29.lan>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 04, 2003 at 05:39:09PM +0200, Michel D?nzer wrote:
> On Mon, 2003-08-04 at 17:26, Larry McVoy wrote:
> > > Here is what I have in a tree locally to go to Linus.  I can't push it
> > > out because ppc.bkbits.net seems to be down.
> >
> > It's back.  If anyone has any insight into how to track down kernel hangs
> > I'd love to hear them.  bkbits.net has been flakey in the last couple of
> > months and sometimes just hangs, last night's was with pings still working
> > but no response at the console.
>
> Which kernel is it running? Something like this happened to every 2.4.21
> kernel I've tried soon after they hit swap. I thought it might be a bad
> interaction of the 2.4.21 VM, CONFIG_HIGHMEM and the XFS and whatnot
> patches and went back to good old 2.4.20-ben8.

2.4.20 and I am using CONFIG_HIGHMEM.  It's on a serverworks chipset and
maybe that's causing problems.  I need to get off IDE.
--
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
