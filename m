Date: Sat, 3 Jun 2000 09:30:57 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000603015640.22680D-100000@ofey.inetnebr.com>
Message-ID: <Pine.LNX.4.05.10006030930000.1278-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 3 Jun 2000, Takashi Oe wrote:
> On Sat, 3 Jun 2000, Michel Lanners wrote:
> > Also, when running Xfree 4, I get a wrapped-around screen in the sense
> > that the leftmost ~200 pixels appear on the _right_ side of the monitor.
> > Might that be the offset of pixel #1 in the framebuffer? Although,
> > that's around 100 bytes IIRC, so wouldn't explain the 200 pixels at 32
> > bit/pixel.... FWIW, I'm running Jack Howarth's XF4-12a RPMs.
>
> XF4's fbdev is not working right for me either.  The weird displacement
> occurs on both of display cards (control, matrox) I have.  I think the
> current XF4 is of no use for fbdev only people.

Probably XF4 handles fix.smem_start being not on a page boundary incorrectly.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
