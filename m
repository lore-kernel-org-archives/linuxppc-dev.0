Date: Thu, 3 Aug 2000 14:44:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ronald Wahl <rwa@peppercon.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: iounmap
In-Reply-To: <Pine.LNX.4.21.0008030950020.1647-100000@goliath.issistance.de>
Message-ID: <Pine.LNX.4.10.10008031443520.425-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Ronald Wahl wrote:
> I'm currently writing a device driver for an pci controller and have to
> map very large amounts of pci memory and i/o ranges via ioremap. The
> problem is that there is no iounmap and ioremap returns NULL after some
> insmod/rmmod cycles. When gets this implemented?

When someone steals some spare time and writes the code.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
