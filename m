Message-ID: <3938C6A2.8FB95D17@student.ethz.ch>
Date: Sat, 03 Jun 2000 10:49:38 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Takashi Oe <toe@unlserve.unl.edu>, Michel Lanners <mlan@cpu.lu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
References: <Pine.LNX.4.05.10006030930000.1278-100000@callisto.of.borg>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> > XF4's fbdev is not working right for me either.  The weird displacement
> > occurs on both of display cards (control, matrox) I have.  I think the
> > current XF4 is of no use for fbdev only people.
>
> Probably XF4 handles fix.smem_start being not on a page boundary
> incorrectly.

What would it have to do to handle it?


Michel


--
Man invented language to satisfy his deep need to complain.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
