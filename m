Date: Tue, 25 Jul 2000 20:37:27 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTAS on PowerMac Newworld
In-Reply-To: <397DA8F8.E68EF85A@francetelecom.fr>
Message-ID: <Pine.LNX.4.10.10007252036280.1490-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 Jul 2000, FASSINO Jean-Philippe wrote:
> Benjamin Herrenschmidt wrote:
> > >In the kernel for PPC, a lot a code is here just to do what doing RTAS :
> > >pci config,
> > >via (CUDA and PMU) (no need if no ADB keyboard), ...
> > >When doing embedded systems, this drivers is very big and can be saving by
> > >using
> > >RTAS which i think is a very good thing in  CHRP specification. It's
> > >strange that
> > >apple do not provide it fully.
> >
> > Well, they didn't care about it. Note that Macs are far from beeing
> > embedded boxes ;)
>
> Yes, but i'm using embedded term for small system that doing dedicate task
> and only one (for example firewall, gateway, ... in only 50-100k kernel size).
>
> I'm actually experienced that with G4 with 4 network card.

And what's the smallest amount of memory you can put in a G4? I guess it's an
order of magnitude larger than a kernel containing all possible drivers :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
