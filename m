Date: Fri, 18 Aug 2000 23:00:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
cc: mlan@cpu.lu,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: some stuff about controlfb in 2.2
In-Reply-To: <20000818134234.A11762@suse.de>
Message-ID: <Pine.LNX.4.10.10008182259510.378-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 18 Aug 2000, Olaf Hering wrote:
> My question is: How can we improve the support for the controlfb? The
> xf4 patch is needed to remove the offset problem. It is no perfect yet.
> 16bit does not work, colors are screwed up. 8bit has some shift to the
> left (proably one byte/ 8 pixels). 24bit worked fine with 832x624 on the
> 7500. I can not use that high colordepth on the 7600, only 2mb vram.

What exactly do you mean? What is the problem? Is it that smem_start is not on
a page boundary? If yes, this worked fine in XFree86 3.3.x.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
