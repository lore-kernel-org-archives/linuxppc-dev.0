In-Reply-To: <Pine.LNX.4.10.9908261001270.29782-100000@mercator.cs.kuleuven.ac.be>
Date: Thu, 26 Aug 1999 10:59:49 +0200
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Performa 5200
Message-Id: <19990826105949.028784@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 26, 1999, Geert Uytterhoeven
<Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:


>Originally the idea was to create machine specific directories for machine
>stuff that's shared between architectures (m68k and PPC Amigas and Macs, m68k
>and SPARC Suns, `PC' for ia32/PPC/MIPS/AXP/SPARC, ...) in 2.3.x, but due to
>the
>feature freeze announce we won't be able to do that in time...

But we do have drivers/macintosh already, we can use it or eventually
sub-divide it for ppc-only and m68k-only drivers, keeping common drivers
at the root level. Also, we could re-merge some drivers, like the zilog
driver (especially since it doesn't use DMA, i never finished it) and the
ADB mouse/keyboard stuff.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
