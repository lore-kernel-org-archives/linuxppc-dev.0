Date: Fri, 4 May 2001 16:14:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
In-Reply-To: <20010504160604.A14752@lambda.u-strasbg.fr>
Message-ID: <Pine.LNX.4.05.10105041612120.2886-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 May 2001, Sven LUTHER wrote:
> On Fri, May 04, 2001 at 03:57:29PM +0200, Benjamin Herrenschmidt wrote:
> > >> Note that if you don't want to mess with XFree, I recently added the
> > >> ability to control the CRT & LCD outputs of the Rage M3 to aty128fb in my
> > >> rsync tree. The tool to control it is on www.penguinppc.org/~benh
> > >
> > >BTW, the recently released ibook is said to only have the capacity to mirror,
> > >not act as an independent display ? can that be or is it something limited in
> > >the mac drivers ? It has a 8MB embedded rage mobility 128, same as the
> > >titanium i think.
> >
> > Don't know. Note that the support I added to aty128fb uses one head only. It
> > just allow you to turn on/off the LCD and CRT output, but it's only mirroring.
>
> So mirroring will work, i guess.
>
> for dual head you will need X, isn't it, fbdev seems broken (well at least
> those using fbgen) for dualhead anyway. Don't know if aty128fb uses fbdev.
                                                                      ^^^^^
								      clgen
No, it doesn't.

> BTW, how does the rage 128 work, it has 1 accel engine that draws to the
> framebuffer memory, and one or more ramdac or digital out ports that send the
> fb data to the displays.

I think so.

If you point the second CRTC to the same frame buffer region, you'll have
mirrorring, else you have two different heads.

> So i suppose the you will need to use a trick similar to the matrox one to get
> dual headed accelerated X to work.

Yep. The same is true for atyfb (yes, I should add mirrorring/dualhead support
for the Mobility in my Vaio :-).

> But could it be possible to block this in hardware, and thus force mirroring
> only operation ?

I suppose yes.

> How many different rage 128 mobility are around anyway ?

No idea. I just at the ATI website earlier today, and they seem to have new
variants called M4 and Radeon Mobility.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
