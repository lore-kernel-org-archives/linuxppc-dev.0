Date: Wed, 31 May 2000 22:46:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: mesh in 2.4.0-test1
Message-ID: <Pine.LNX.4.05.10005312242300.2148-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there anyone who is succesfully using SCSI devices connected to MESH SCSI
with 2.4.0-test1 (or late 2.3.99-preX, e.g. pre9)?

On my CHRP box (with sym53c875 and MESH), no devices at all are detected on the
MESH chain. I haven't tried to remove the sym53c8xx driver (which is scsi0)
from my kernel yet to see whether this is perhaps a more generic problem with
multiple SCSI adapters.

It worked fine in 2.3.99-pre3 from March 21. Anyone with a clue, before I start
diving into the (big) diff between 2.3.99-pre3 and -pre9?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
