Date: Wed, 2 Aug 2000 14:47:53 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New input layer and ADB (Was Re: CONFIG_PPC != Mac)
In-Reply-To: <39859A08.9D224B@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10008021445550.427-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 31 Jul 2000, Martin Costabel wrote:
> Sometimes after a console switch, I end up in capslock mode. Switching
> capslock on then gives lowercase letters (except the letter "L"). After
> a further console switch, things return to normal.

That's normal. With PC keyboards, the LED state of the Caps Lock key is
controlled by Linux, while Mac (and Amiga) keyboards remember the Caps Lock
state in the keyboard. Hence if you do a VC switch to a VC where Caps Lock is
in a different state, Linux and the keyboard will disagree.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
