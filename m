Date: Sat, 6 Jan 2001 10:42:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
Message-ID: <20010106104247.A1400@opus.bloom.county>
References: <200101051455.f05Et0v06700@ashley.ivey.uwo.ca> <20010105083740.B14321@opus.bloom.county> <20010105154015.R29805@plato.local.lan> <3A572925.4A791E05@iiic.ethz.ch> <20010106055922.Y29805@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010106055922.Y29805@plato.local.lan>; from erbenson@alaska.net on Sat, Jan 06, 2001 at 05:59:22AM -0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 06, 2001 at 05:59:22AM -0900, Ethan Benson wrote:
> On Sat, Jan 06, 2001 at 03:18:13PM +0100, Michel Dänzer wrote:
> >
> > I'm running 2.4.0 from linuxppc_2_3 and have never used bk. rsync is rather
> > cool.
>
> yes but if this tree is stabelized, and thus not being fiddeled with
> (as it should be for a 2.4.0) then a unified diff or full out tarball
> would be more convenient.   IMO anyway.

Well, the first problem is that it's now linuxppc_2_4 (which isn't a rename,
it's a new tree) which needs all the fixes from 2_3, and some of the twitchy
stuff left out.  So it may or may not be possible to get a good 2.4 tree for
a bit (except for 2_5) anyways.

> the main thing i think is needed is a *static* finalized 2.4.0 for
> powerpc people can use.  not everyone wants to recompile the kernel
> every day to get/fix `the tweak of the day' of actively developed
> kernels.

Unfortunatly, that can't happen until 2.4.0 is finalized and bug-free for
PPC.  2_3 may or may not still need some more SMP fixes for pmac, and power3
stuff is still being fixed.  Now that on the whole 2.4 is "stable", we can
try and bring ppc support up to snuff again.  (ie I'm rather sure more PCI
stuffs need to be pulled from the 2_5 tree, 'cuz that's a lot happier on
my machine than 2_3 was).

In short, what I think we'll need soon is what 2.4.0 needs now.  People other
than the usual gang of testers to try it out and find bugs.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
