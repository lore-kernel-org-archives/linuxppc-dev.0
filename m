Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Baxter <robb@synergymicro.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040106221728.GA8268@synergy>
References: <1073338095.9497.70.camel@gaston>
	 <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston>
	 <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston>
	 <20040106081143.GA1644@iliana>
	 <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
	 <20040106144545.GA7261@iliana> <20040106153305.GA6251@synergy>
	 <1073425055.784.3.camel@gaston>  <20040106221728.GA8268@synergy>
Content-Type: text/plain
Message-Id: <1073428290.4416.13.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 09:31:30 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-
> > The kernel doesn't do anything to the L2 cache, it all depends what
> > you firmware does to it.
>
> That's true, but for the ppc stuff, there is initialization routines within
> the kernel source.

Yes, those are initially here to allow change of the setting via
/proc/sys/kernel/l2cr. I also used them to force passing a different
l2cr values via BootX and for setting up the L2 on the second CPU of
SMP machines and to restore it on wakeup from sleep on laptops

Nothing prevents you, of course, from setting L2 in your arch code
as well using those functions, but it's preferred to have the
firmware set it up properly in the first place.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
