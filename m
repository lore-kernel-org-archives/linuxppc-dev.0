Date: Wed, 9 Aug 2000 16:20:54 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Josh Huber <huber@mclx.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
In-Reply-To: <Pine.LNX.4.10.10008081853280.13215-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10008091620210.416-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Michael Schmitz wrote:
> > > Is this XF4.0.1 in `fbdev' mode? If yes, it's a bug in the X server. Setting
> > > the DSP registers is part of the video mode initialization and thus is the
> > > sole responsability of the frame buffer device, when running in `fbdev' mode.
> >
> > Yes.  The server shows the SAME behavior using the fbdev driver and
> > the ati driver.  Also, as a note, the 3.3.6 XF68FB_Dev server with ati
> > accel also does the same thing!   So there's some code that's getting
> > used by all three that is wrong?
>
> Both the fbdev and ati driver use the fbdvhw functions to do mode init and
> the like. So it seems the bug is in the kernel driver (sorry Geert).

I don't see how it can be in the kernel driver, if running 3.3.6 XF68FB_Dev
changes the contents of the DSP registers.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
