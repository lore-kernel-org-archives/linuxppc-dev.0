Date: Sat, 14 Oct 2000 12:09:37 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Samuel Rydh <samuel@ibrium.se>
Subject: Re: [linux-fbdev] Re: Video driver bug
In-Reply-To: <19340907141507.13024@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10010141208290.570-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 13 Oct 2000, Benjamin Herrenschmidt wrote:
> >That's for 2.5.0. I think the first thing we need to do in 2.5.0 is to remove
> >all `mess with non-visible VCs' support, so /dev/fb* works on the _current_
> >video mode.
>
> Well, my understanding is that MOL needs to be able to "probe" for all
> supported mode. Doing so on a visible console would definitely be hell.
> It does that in order to setup the MacOS-side driver mode list.

Wouldn't it be sufficient to run MOL in only one mode, cfr. the X server?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
