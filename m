Date: Mon, 8 Mar 2004 19:46:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marc-Christian Petersen <m.c.p@wolk.linux-systeme.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.6.4-rc2] Disable Macintosh device drivers for all but
 PPC
In-Reply-To: <1078697211.5704.164.camel@gaston>
Message-ID: <Pine.GSO.4.58.0403081945520.16049@waterleaf.sonytel.be>
References: <200403072117.47345@WOLK> <1078697211.5704.164.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Mar 2004, Benjamin Herrenschmidt wrote:
> On Mon, 2004-03-08 at 07:50, Marc-Christian Petersen wrote:
> > I think the attached patch is needed to stop showing us "Macintosh device
> > drivers" for all architectures via menuconfig || xconfig || gconfig.
>
> ... and m68k :)

Indeed. So please add `|| MAC'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
