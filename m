Date: Thu, 17 Oct 2002 18:33:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: CONFIG_ADBMOUSE
Message-ID: <Pine.GSO.4.21.0210171831370.401-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

Does Linux/PPC on PowerMac still use the code in drivers/macintosh/mac_keyb.c
that's protected by CONFIG_ADBMOUSE? It's removed in the m68k tree.
If no, I'll send a patch to remove it to Linus.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
