Date: Tue, 27 Jan 2004 11:47:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	ncunningham@clear.net.nz,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-ID: <20040127104701.GB18666@elf.ucw.cz>
References: <1075154452.6191.91.camel@gaston> <Pine.LNX.4.44.0401271130010.23778-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0401271130010.23778-100000@opal.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

> > > > Ah, also: The "Freeing memory" phase takes forever. That should
> > > > really be fixed.
> > >
> > > Well, it does the trick for me, but it takes 50% or so of suspend
> > > time. Some memory managment guru making "freeing memory" faster would
> > > certainly be welcome.
> > > 								Pavel
> > > PS: But I'd like to keep it simple...
> >
> > Haven't looked at it yet. Several crash reports so far, mostly
> > lockups right after printing the number of pages to save. I wonder
> > if we have something broken in there. It dies for me once too at
> > this point.
>
> The PMU locking up with interrupts disabled, for me (Lombard, 400 MHz).
> Seems to happen more often on slow machines.
> Otherwise, it works (saving to the last swap partition if you try to
> specify which one to use; patch sent to Ben FWIW).

What is "PMU locking"? Is there some part of powermac harware that
kills machine if you sleep too long with interrupts disabled?

								Pavel
--
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
