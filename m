Date: Mon, 17 Apr 2000 21:30:39 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: /proc/ppc_htab
Message-ID: <Pine.LNX.4.10.10004172130210.455-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A few days ago I saw `mmu_context_overflow' in my kernel messages.
The machine locked up on `cat /proc/ppc_htab'. Fortunately it autorebooted
after 180 seconds and came back to life again.

Since I don't have direct access to my PPC box now (I'm recovering from knee
surgery) and rely on it for receiving email, I'm not very eager to do some
more experiments with /proc/ppc_htab.

Note that I have no idea what mmu_context_overflow means nor what ppc_htab
really does. Are these two related?

For what it's worth, I'm running the bk tree at the 2.3.99-pre3 level.


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
