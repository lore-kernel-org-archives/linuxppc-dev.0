Date: Tue, 3 Oct 2000 13:14:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
cc: Michel Dänzer <daenzerm@student.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + atidriver
 with rage II/rage pro)
In-Reply-To: <20001002230454.C15425@suse.de>
Message-ID: <Pine.LNX.4.10.10010031313070.1187-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2 Oct 2000, Olaf Hering wrote:
> On Mon, Oct 02, Michel Dänzer wrote:
> > > plum:~ # fbset -depth 24
> > > ioctl FBIOPUT_VSCREENINFO: Invalid argument
> >
> > What about -depth 32? Maybe X uses depth 24, 32 bpp.
>
> Same error.

Depth 32 needs even more RAM :-)

> X can use 8,15,24.  But 32 doesnt work:
> (**) ATI(0): Depth 32, (--) framebuffer bpp 32
> (EE) ATI(0): Weight given (000) is inconsistent with the depth (32)
>
> Looks like that special chip needs a little extra setup in the kernel
> code?

Nitpicking about terminology, it's depth 24, bpp (bits per pixel) 32.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
