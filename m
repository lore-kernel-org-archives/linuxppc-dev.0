Date: Wed, 17 Apr 2002 08:37:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: olh@suse.de, ajoshi@shell.unixbox.com, jeglin@4pi.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
In-Reply-To: <E16xb2p-0000Bv-00@piglet.grunz.lu>
Message-ID: <Pine.GSO.4.21.0204170837040.1258-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Apr 2002, Michel Lanners wrote:
> On  16 Apr, this message from Olaf Hering echoed through cyberspace:
> >> > 1. Is the Radeon 7000 supported in XFree86? Rather, the real question
> >> > is, does anyone know of any gotchas trying to run it in accelerated
> >> > mode?
> >>
> >> ATI tends to make new cards which are really just newer revisions of older
> >> ASICs.  For example, the Radeon 7200 is realy just a regular radeon with
> >> 64meg DDR (and perhaps higher clocks).  So its highly possible that the
> >> 7000 is a radeon VE (considering its dualhead).  If so, then it is
> >> supported.  Even if it isn't, adding support should be very trivial as it
> >> contains the same 1st generation Radeon ASIC.
> >
> > It is a VE, but I have one report where it fails on a 9600, after
> > loading vgahw.a or something like that. Maybe it must go into another
> > slot or the guy has to boot without video=ofonly.
>
> Loading vgahw.a? Hmmm, that looks suspiciously like problem accessing
> legacy hardcoded VGA ports on the second bus (which as Ben explains
> doesn't support that).
>
> Can somebody please teach XFree to leave those VGA ports alone on PPC?
> Are they of _any_ use on any PPC machine?

Any PPC \not \in PowerMac?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
