Date: Thu, 21 Dec 2000 13:23:14 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: ATI mach64 GT Rev 0.x??
Message-ID: <Pine.LNX.4.05.10012211316390.676-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anybody who has an ATI Mach64 GT (RAGE) with chip ID 0x4754 and a revision
number where (rev & 7) is 0?

Revision encoding is defined as: mmFFFMMM, with
  - mm: minor revision
  - FFF: foundry
  - MMM: major revision

AFAIK, only the following revision codes exist: 0x01, 0x41, 0x1a, 0x5a, 0x9a,
which map to revisions 1.0, 1.1, 2.0, 2.1, 2.3.

Atyfb has some tests for (rev & 7) and (rev & 3), but if I'm right, these are
always true, and can be removed.

Gr{oetje,eeting}s,

				Geert (working on making atyfb less complex)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
