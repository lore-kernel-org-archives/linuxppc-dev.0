Date: Mon, 10 Feb 2003 17:24:21 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: VGA out/External Monitor on ibook 2
In-Reply-To: <20030210150602.GA9933@haar.ae.gatech.edu>
Message-ID: <Pine.LNX.4.44.0302101721560.23854-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Someone lately posted a message detailing the problem (either here or on
> > debian-powerpc): the hsync and vsync pulses appear to be OK (correct
> > frequency) but have a phase jitter.
>
> Unless somebody else posted it too, that would be me. And I now realise
> that it was based on your suggestion (on debian-powerpc) a year back!

Possible - I've suggested someone take a scope and debug this more than
once :-)

> Owen asked: How was it using OFFB? The phase is steady with the OFFB.
>
> > Does that ring a bell with anyone
> > here? Does anyone know which PLL setting the hsync position is derived
> > from?
> >
> > 	Michael
>
> Is it possible that the lcd and crt *have to be* on different
> controllers? From what I understand,  OF and OSX set it up that way but we

Yep, that's entirely possible. Maybe we can't get the proper specs for
both on one controller.

> don't. As I have no documentation, this is just  a conjecture.
> Still I would like to do just that. But I am constrained by the lack of
> documentation. Pointers anybody? Maybe people who desire a dual-head would
> like to help :)

I'd talk to Michel Dänzer about this. The XFree people might have figured
something out on other (i386) architectures. XFree developers have access
to at least some ATI docs.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
