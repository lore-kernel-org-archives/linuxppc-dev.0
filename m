Date: Mon, 9 Feb 2004 11:36:53 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: XServe G5 and Linux ?
Message-ID: <20040209103652.GM18913@obroa-skai.de.gnumonks.org>
References: <20040208180539.GG18479@sunbeam.de.gnumonks.org> <1076299574.887.118.camel@gaston>
Mime-Version: 1.0
In-Reply-To: <1076299574.887.118.camel@gaston>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 09, 2004 at 03:06:14PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2004-02-09 at 05:05, Harald Welte wrote:
> >
> > I currently have the requirement for some 1U servers running linux,
> > but specifically being not x86. So apart from the sparc64 systems,
> > there's of course the Apple XServe.
> >
> > I have a couple of questions though:
>
> Well, the machine hasn't yet been released, or if it has, I yet
> haven't had any feedback of linux running on it.

I see.  It's just that the XServe G5 is sold cheaper than the XServe G4
(at least the dealers have a lower price).  That's why I somehow feel
reluctand of buying an old machine.

Also, I can positively confirm that we've had a G5 XServe at the 20C3
(CCC Chaos Communication Congress) at the end of december.  It was used
to relay the A/V streams of the lecture halls into the congress network.

So either the CCC has received an unreleased machine, or they are
already sold.

> > 1) Does anybody have experience running linux on the current G5
> > Xserve?
>
> I expect the kernel to mostly work, +/- minor adaptations that should
> be fairly trivial hopefully, except maybe for the thermal control.
> But then it depends what they changed of the chipset. The above is
> assuming the chipset is just the new northbridge rev and same IO chip.

mh. Unfortunately you're in .au now.  This means I cannot just buy one
of them and ship it to you for getting that initial work done.
Shipping, Taxes, Customs Offices, ... would definitely over-complicate
everything.

> Yes. Though I don't quite support 2.4 on G5s (there _is_ a booting SMP
> 2.4 kernel, I'm not sure how stable it is in the long run).

ok.

> > And a minor curiosity at the end: Are there any plans to include
> > Apple G5 support into the linux ppc64 arch at some point?
>
> It's beeing done, will be upstream soon hopefully.

great. Thanks again.

> You know how to ask :)

yes, but I know how annoying 'user' questions can be... but since there
seems to be no FAQ / blog / whatever...

> Ben.

--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
