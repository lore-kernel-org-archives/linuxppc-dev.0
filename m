Date: Sat, 15 Apr 2000 16:37:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Remaining Pismo issues
In-Reply-To: <20000410003254.010360@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10004151636100.359-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Apr 2000, Benjamin Herrenschmidt wrote:
> Linux has some power management features (like DOZE'ing the CPU in the
> idle thread) but some more general work on power management is needed to
> really improve things. The sound chip could be shut down optionally when
> the driver is not opened (well, eventually disabling the console beep),
> the hard disk could be completely powered off instead of just spun down,
> and the overall CPU activity could be monitored by a deamon and the CPU
> speed adjusted dynamically.

According to my sister (who has a Wallstreet which is currently under repair
because of a broken LCD :-(, the battery lasts longer under Linux than under
MacOS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
