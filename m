Date: Sun, 24 Sep 2000 15:43:42 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: daenzerm@student.ethz.ch, reshapiro@mediaone.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <200009231708.TAA00731@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10009241543000.421-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 23 Sep 2000, Michel Lanners wrote:
> On  23 Sep, this message from Michel Dänzer echoed through cyberspace:
> >> Also the screen is oddly "wrapped" on the rage II machine with the fbdev
> >> driver: I can see the full screen but the virtual edge starts about 75% in,
> >> instead of matching the physical edge, and then wraps around.  I don't see
> >> this artifact on the rage pro G3.
> >
> > This is a known problem, which is also kind of fixed in Ani's tree AFAIK. I'm
> > currently working with Geert Uytterheuven to get the definite fix.
>
> Is this the already-known problem of handling an offset for the screen
> start within the framebuffer memory?
>
> Because I'm experiencing this as well with fbdev, and the problem is the
> same for all Apple non-accelerated framebuffers (control, platinum,
> valkyrie), AFAICT. So it would be helpful if this problem would get
> fixed once and for all. FWIW, no propblem with XF3.x.

Should be fixed after applying the untested patch I sent to Michel D.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
