Date: Thu, 7 Sep 2000 11:53:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: newer xfree86 4.0.1 patches
In-Reply-To: <20000906213248.A3749@suse.de>
Message-ID: <Pine.LNX.4.10.10009071151320.461-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Sep 2000, Olaf Hering wrote:
> There is also a keycode file for ps/2 based machines like PReP and CHRP,
> called "powerpcps2". It is a workaround, the arrow keys and the page
> up/down block are dead as example. I guess it is a kernel bug.

So prefixed scancodes don't work? Sounds familiar. I guess this has something
to do with the X server putting the keyboard in RAW mode (send raw scancodes,
including prefixes) instead of MEDIUMRAW mode (send keycodes, 1 code for each
key pres/release) or vice versa.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
