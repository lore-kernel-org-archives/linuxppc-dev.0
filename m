Date: Wed, 27 Oct 1999 18:05:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
cc: Adrian Cox <apc@agelectronics.co.uk>,
        Kumar Gala <kumar@chaos.ph.utexas.edu>, Jim Terman <terman@ddi.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <Pine.HPX.4.10.9910271432490.18743-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.05.9910271803570.6037-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Oct 1999, Gabriel Paubert wrote:
> On Wed, 27 Oct 1999, Adrian Cox wrote:
> > As for the cache thrashing effect, remember that 512 bytes going in and
> > out of the L2 cache is not very expensive, and that there is probably 1
> > or 2MB of L2 fitted.
> 
> My feeling is that it is unlikely that the code is in the L1 cache, this
> code is not a tight loop which is executed 1000 times in a row, and it is
> probably saturating L2 cache bandwidth. If you need 8 bytes of code and 16
> bytes of data for each register save/load on average, it's 3 L2 data beats
> or 6 clocks in the most common scenario (L2 at 1/2 core frequency).

I wasn't primarily concerned about code taking space in the L1 cache, but the
saved Altived registers pushing out valuable data of the L1 cache on each save.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
