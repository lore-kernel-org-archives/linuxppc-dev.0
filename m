Date: Sat, 25 Mar 2000 16:13:13 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.05.10003251432500.11322-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10003251537140.26717-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > insists in overlapping the registers with the VRAM, the PCI code in the
> > > kernel (2.3) should give the registers a separate area, saving 4kB of MMIO
> > > space is completely useless.
> >
> > It should but last time I tried it complained about resource conflicts.
> > I've sent BenH a log of this on request.
>
> The kernel code `should' do that, but currently it doesn't. All it does is try
> to allocate the PCI resources, as they are set up by the `bootloader' (OF,
> MacOS, whatever). If they conflict, you just get a warning.
>
> The code I posted for the LongTrail does assign missing/conflicting resources.
> Please adapt it for PowerMac.

Ok, I'll start working on this. If that gets me far enough with XFree to
show it's working, fine. I'll really need 2.2 though (USB mouse support
was broken for me in 2.3).

> And for 2.2.x: sorry, but I don't care what you do there. In theory you should
> do the same thing, but then you have to `invent' all code yourself, while in
> 2.3.x most is already there.

If the resource reassignment helps I can probably hack something like that
for 2.2.x. I wasn't asking you for a PCI resource assignment backport to
2.2 :-)
I've collected a fair share of advice on this topic, so I should get some
results now.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
