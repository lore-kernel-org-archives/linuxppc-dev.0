Date: Fri, 24 Mar 2000 14:34:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241423530.21215-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10003241433140.7616-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:
> > > On a somewhat related issue (the PCI mapping funnies for the Lombard and
> > > possibly other Rage Pro devices): what are the penalties if I 'correct'
> > > the PCI mapping for the Rage Pro within atyfb_of_init?
> >
> > To be a bit more constructive: what about adapting my patches and use them on
> > the Lombard as well? Then the conflicting secondary aperture will be assigned a
> > new region, while the valid regions will stay what they are.
>
> Fine with me. I forgot to mention that I'm currently working on the 2.2.15
> atyfb source, do your patches apply to that as well? (Frankly, I tried to
> follow your argument about the PCI / OF resource handling but couldn't
> make out where it would fit in with the problem I try to solve.)

For 2.2.15, I suggest doing it in atyfb manually. But it will be quite
difficult to find a suitable free hole in PCI memory space without the resource
management subsystem.

PCI resource assignment was added in late 2.3.x, together with hot-pluggable
PCI support.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
