Date: Sun, 30 Sep 2001 13:23:46 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: =?ISO-8859-15?Q?PowerStack_interrupt=A0problem?=
Message-ID: <Pine.GSO.4.10.10109301319240.29063-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

We're having interrupt problems with a Motorola PowerStack running 2.4.9 (from
MontaVista rsync).

Symptoms are:
  - We receive lots of PS/2 mouse interrupts (irq 12), a few hundreds or
    thousands for each mouse move
  - The number of BAD interrupts increases when moving the mouse, a few tens
    for each mouse move
  - Sometimes the machine locks up (no ping response) after heavy mouse
    movement
  - The PS/2 keyboard is fine

Anyone with a suggestion? Any other PowerStack users with similar problems?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
