Date: Wed, 4 Oct 2000 20:09:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <Pine.LNX.4.10.10010031820450.15293-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10010042008500.374-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 3 Oct 2000, Michael Schmitz wrote:
> > > > plum:~ # fbset -depth 24
> > > > ioctl FBIOPUT_VSCREENINFO: Invalid argument
> > >
> > > That's normal, you also have to decrease the virtual size, which was
> > > initialized to the maximum possible value w.r.t. RAM size.
> >
> > It seems to be a problem with the color palette or somehow color depth
> > related.
> > First I just switched to 1024x768-60 and it didn't work, the next time I
> > added -depth 24 and it works fine. So mol can not increase the color
>
> vmode also needs both arguments for me. fbset crashing when you omit the
> depth argument is weird - does fbset not read the current depth from the
> device before a mode set, Geert?

Yes it does.

> We sure could hack the kernel ioctl to take depth 0 as 'dont change' and
> print a warning?

No, that would violate the `round up' policy.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
