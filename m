Date: Mon, 15 May 2000 09:29:16 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: current bk tree
Message-ID: <Pine.GSO.4.10.10005150925400.4996-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I managed to compile the current bk tree (+ a few fixes I just checked in) and
boot it on my LongTrail. Comments:

  - The MESH driver doesn't detect any disks anymore, which is bad.

  - The kernel still detects 3 serial ports:

      ttyS00 at 0x03f8 (irq = 4) is a 16550A
      ttyS01 at 0x02f8 (irq = 3) is a 16550A
      ttyS02 at 0x03e8 (irq = 4) is a 16450

    The last one is bogus. This problem has been there seen quite a while, but
    seems to be harmless.

I hope to resume working on the PCI allocation stuff soon. I wrote a few
(untested) patches while I was disabled.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
