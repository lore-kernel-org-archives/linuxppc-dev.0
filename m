Date: Thu, 17 Oct 2002 18:48:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_ADBMOUSE
In-Reply-To: <20021017184255.8221@192.168.4.1>
Message-ID: <Pine.GSO.4.21.0210171847190.401-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 17 Oct 2002, Benjamin Herrenschmidt wrote:
> >Does Linux/PPC on PowerMac still use the code in drivers/macintosh/mac_keyb.c
> >that's protected by CONFIG_ADBMOUSE? It's removed in the m68k tree.
> >If no, I'll send a patch to remove it to Linus.
>
> No, we only used adbhid nowadays, at least in 2.5. I'm about to

Yes, I was mean 2.5.x.

> rework significantly the ADB code anyway to use the new driver
> model (define an adb bus type & framework for drivers).

Nice!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
