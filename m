Date: Fri, 12 Nov 1999 13:42:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: 2.3.27 on CHRP Longtrail
Message-ID: <Pine.LNX.4.05.9911121340150.444-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Plain 2.3.27 panics right after calibrating the delay loop. At first sight, it
seems to crash in clear_bit() on address 0xa058, hence probably a NULL pointer
problem somewhere at a higher level. This is being investigated.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
