Date: Sat, 15 Apr 2000 15:28:44 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Josh Huber <huberj@wpi.edu>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Preserving memory...
In-Reply-To: <20000411151958.H771@mclinux.com>
Message-ID: <Pine.LNX.4.10.10004151528070.359-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Apr 2000, Josh Huber wrote:
> First, is there a way to tell powerpc hardware (Macs in particular -- for
> now) to preserve memory across a system restart?  It looks like it does this
> by default, partially.
>
> Secondly, if I can get the first part to work reliably, does anyone know
> what regions of memory should be avoided, i.e. are thrashed by OF etc?

At least on the LongTrail, all memory is cleared by OF (at least it looks like
that).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
