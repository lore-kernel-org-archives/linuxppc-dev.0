Date: Wed, 23 Aug 2000 13:51:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
In-Reply-To: <39A2F6C7.F2743BF7@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10008231350530.380-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Aug 2000, Michel [iso-8859-1] Dänzer wrote:
> Michel Lanners wrote:
> > supposing someone actually finds out how control's hardware cursor works,
> > and supposing someone would actually take the time to implement this,
> > wouldn't we need to provide a XFree driver as well? I guess plain fbdevhw
> > doesn't support hw cursor...
>
> Don't think that there are fbdev ioctls to control it either.

Actually there are, but they are highly experimental since about 4 years :-)
Only Amifb should support them more or less.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
