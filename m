Date: Wed, 27 Oct 1999 18:33:39 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Capricelli <capricel@enst.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: long-term 7600-booting patch
In-Reply-To: <99102717012102.13242@uranium>
Message-ID: <Pine.LNX.4.05.9910271833130.6037-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Oct 1999, Thomas Capricelli wrote:
> 	I've reported this problem many times to linuxppc support,  Paul
> Mackerras and some others.
> 
> 	Since may 1999, my kernel won't boot UNTIL I applied a patch I have
> available to anyone who wish.
> 
> 	The problem (well known) is with the first (internal) SCSI not syncing
> at boot time.
> 
> 	As my 2.1.125 kernel from linuxppc R4 was always fine but I need to
> boot new kernels, I've made this patch. Not that I understand a lot of what
> i've done, mainly backporting the mesh code from 2.1.125.
> 
> 	At least, my mac now always BOOT. Before applying this patch, I had to
> try between 6 and 16 times to boot my computer. You DON'T know how tiring this
> is

Can you please try a 2.3.x kernel? I suffered from a similar problem and it was
solved in 2.3.x.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
