Date: Sat, 8 Jan 2000 18:33:06 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
cc: Andreas Tobler <toa@pop.agri.ch>
Subject: Re: remote debugging?
In-Reply-To: <20000107135708.C1891@suse.de>
Message-ID: <Pine.LNX.4.05.10001081832190.633-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 7 Jan 2000, Olaf Hering wrote:
> console=ttyS0,19200 and you will see an output on your console and the
> penguin on your screen. It should be possible to log both to serial and
> to the screen.

That's `console=ttyS0 console=tty0' (or vice versa). The first one is used for
single user/emergency shells.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
