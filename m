Date: Sat, 22 Jul 2000 16:10:39 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huber@mclx.com>
cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problems about __cli()
In-Reply-To: <20000720114423.A20249@mclx.com>
Message-ID: <Pine.LNX.4.10.10007221608490.430-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Jul 2000, Josh Huber wrote:
> On Thu, Jul 20, 2000 at 02:45:56PM +0100, Iain Sandoe wrote:
> > I guess I *must* have one of those broken derivatives... and it doesn't work
> > for me without that step...  Admittedly, this is mostly an issue between
> > 2.2.xx and 2.4.0 - but I do have to remember to change it back between
> > whiles... a better way would be ?
>
> Well...hmm, what doesn't work?  You mean you can't build a kernel
> unless you make /usr/src/linux point to the kernel source you're
> building?  This is odd, as I haven't done that...ever!  In fact,
> there's no directories in /usr/src on my machine.

IIRC, there was a time (long before 2.0) that kernel builds did look for
includes in /usr/include/, so you had to unpack (or symlink) your kernel in
/usr/src/linux/. Fortunately the include path was changed to put
root_of_build/include first.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
