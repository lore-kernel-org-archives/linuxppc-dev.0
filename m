Date: Fri, 26 Mar 2004 18:48:14 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: PREEMPT on PPC
In-Reply-To: <1080201697.1217.3.camel@gaston>
Message-ID: <Pine.LNX.4.44.0403261442210.3900-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I've start looking into the various issues of running CONFIG_PREEMPT
> > on ppc32. I found some problems, there may be more, but here's a
> > first patch that should apply on a recent 2.6.x.
> >
> > I suggest if you want to try this out that you run with the various
> > kernel debugging options enabled. Report me remaining problems.
>
> And here's an updated version of that patch that doesn't break sleep
> on laptops.

Works fine here on 2.6.5-rc2-ben0 . Including disk suspend.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
