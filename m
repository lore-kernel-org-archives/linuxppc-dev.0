Date: Fri, 24 Mar 2000 18:40:37 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.HPX.4.10.10003241456491.14656-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.10003241806210.22814-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > So it's perfectly legal for resources within the same device to overlap?
> > WTF does X not tolerate this and disables the overlapping one?
>
> It may be legal if the internal decoders are prioritized and the priority
> is the right one (which it should if the firmware has set it up this way).

They are prioritized the right way: if you memset the whole aperture to 0
the chip freaks out instead of just painting the whole screen black. Been
there, done that.

> I don't consider it good practice though, especially when it saves only
> minute amounts of address space. X should tolerate this in any case
> however, it should admit that it is not always smarter than the firmware.

Well, arguing with X is pointless. So far I've always got the short end of
the stick :-)

> > I'm not sure adding subtrees will help - I guess X might go ahead and
> > disable the main resources anyway. Will the subtree resources remain
> > accessible in that case?
>
> Yes, but then I have given up on trying to understand X :-( Oh and the

I mean: if someone disables the original resource, what happens to the
new resources?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
