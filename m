Date: Tue, 3 Oct 2000 19:20:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <Pine.LNX.4.10.10010031640040.1330-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.05.10010031919160.10275-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 3 Oct 2000, Michael Schmitz wrote:
> > > Fine, but how would I do that? And how do I tell atyfb to set up two
> > > framebuffers for the two separate screens`?
> >
> > By adding code to atyfb. Sorry for the short answer ;-)
>
> Har har. I almost guessed that. Once I figure out how to initialize the
> chip to use separate chunks of RAM for the two ports, the little hack to
> make atyfb parse multiple vmode arguments (and consequently set up
> and register multiple framebuffers) would indeed be trivial.
>
> Do you have any idea if the config registers dumped to the console by
> atyfb are all I need to look at?

They're not sufficient. They're relevant for clock and bus programming only.
A second CRTC is certainly not covered by them.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
