Date: Mon, 29 Mar 2004 11:31:37 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: PREEMPT on PPC
In-Reply-To: <1080525344.1209.53.camel@gaston>
Message-ID: <Pine.LNX.4.44.0403291117010.30503-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Note that I'm not sure how tightly the problems are tied to swap; after
> > they start, they seem to persist even when swap is no longer used. It's
> > just the best criterion I've been able to identify so far.
>
> Weird. I just can't reproduce any of your problems, neither on the
> tipb with highmem & lots of RAM, or on the wallstreet with no highmem
> and little RAM (thus swap)...

Same here - 128 MB RAM, 256 MB swap with half of that currently in use
(mostly by mol). Doesn't miss a beat.

> I've been running with preempt for a few days now without trouble.
>
> What else are you using ? I suspect something like MOL may have troubles
> with preempt for example...

Apparently not (0.9.69-20031019-5 here, haven't got 0.9.70 to behave yet).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
