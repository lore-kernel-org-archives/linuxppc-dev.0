Date: Thu, 23 Dec 1999 22:18:01 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: vger-now on LongTrail
Message-ID: <Pine.LNX.4.05.9912232214330.369-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Guys,

Now vger is again up-to-date, I gave it a try. Unfortunately the MESH driver
seems to be broken after the SCSI subsystem changes. The last line it dumps is

    mesh: target 5 synchronous at 10.0 MB/s

and then nothing, except cursor flashing, so interrupts are still alive.
If I set the sync target mask to 0, I don't even get that message.

I'll check in a few small changes at vger soon (haven't heard from Larry about
the bk license :-(

Note that my current kernel is 2.3.22. I got it working since yesterday, after
fixing a stupid Sym53c8xx bug (fix showed up in vger thanks to the SPARC guys).

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
