Date: Mon, 6 Mar 2000 07:54:16 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Michel Dänzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
 cwith  r128
In-Reply-To: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.05.10003060753180.19293-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 6 Mar 2000, Kostas Gewrgiou wrote:
> On Sun, 5 Mar 2000, Geert Uytterhoeven wrote:
> > On Sun, 5 Mar 2000, Kostas Gewrgiou wrote:
> > >   Yeap its the same in the x86 side as well, atyfb doesn't support 565
> > > either i imagine you remember the jdk problems that we had in xf68_fbdev
> > > because of this.
> >
> > But since Mach64 CT/VT/GT do support RGB 565, adding support for it isn't that
> > difficult. Patches?
>
>  Unfortunately i don't have a mach64 card anymore, i'll take a look in the
> xserver side though, right now it looks only in var.bits_per_pixel but this

The X server should be OK, it's atyfb that needs to be patched.

> is set to 16 even in the 555 case so we need to check green.length as well
> right ?

Yes. RGB555 and RGB565 all use 16 bit pixels.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
