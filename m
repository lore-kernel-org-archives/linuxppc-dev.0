Date: Sun, 5 Mar 2000 22:20:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Michel Dänzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
 cwith  r128
In-Reply-To: <Pine.LNX.4.21.0003052134430.12030-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.05.10003052220090.11732-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 5 Mar 2000, Kostas Gewrgiou wrote:
> On Sun, 5 Mar 2000, Kevin B. Hendricks wrote:
> > >> > By the way, true 16 bit depth (565) does not work on my machine. The
> > >>screen
> > >> > comes up but everything is very very green!
> > >> >
> > >> > Reverting to 16bpp and 15 depth (555) works fine.
> >
> > >  The problem here is that aty128fb doesn't support 16 bit depth,
> > >asking for 16 bit will give you 15 bit but fbdevhw fails to detect
> > >this.
> >
> > Is this true even under x86?  What about in the very latest aty128fb from
> > the latest 2.3.XX kernel?
>
>   Yeap its the same in the x86 side as well, atyfb doesn't support 565
> either i imagine you remember the jdk problems that we had in xf68_fbdev
> because of this.

But since Mach64 CT/VT/GT do support RGB 565, adding support for it isn't that
difficult. Patches?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
