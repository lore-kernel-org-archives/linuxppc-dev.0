Date: Wed, 1 Mar 2000 21:01:38 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: bogus ttyS02
Message-ID: <Pine.LNX.4.05.10003012100350.516-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

Since a while 2.3.x kernels detect one serial port too much on my CHRP box.
Anyone else (CHRP, PReP) seeing this?

| ttyS00 at 0x03f8 (irq = 4) is a 16550A
| ttyS01 at 0x02f8 (irq = 3) is a 16550A
| ttyS02 at 0x03e8 (irq = 4) is a 16450

The last one is bogus.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
