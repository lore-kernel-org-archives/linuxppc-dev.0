Date: Mon, 30 Aug 1999 22:08:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Michel Lanners <mlan@cpu.lu>
cc: apc@agelectronics.co.uk, linuxppc-dev@lists.linuxppc.org
Subject: Re: Zero Pages / Cache Coherency
In-Reply-To: <199908292028.WAA00305@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9908302157530.32139-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 29 Aug 1999, Michel Lanners wrote:
> On  27 Aug, this message from Adrian Cox echoed through cyberspace:
> > I'm currently trying out the pre-zeroing of pages in the idle task, and
> > I'm a little worried about its effect on cache-coherency. I can't prove
> > to
> > my satisfaction that none of the pages being cleared by zero_paged() is
> > in the cache, and I'm not sure that turning off caching in the PTE will
> > have any effect on cache lines already allocated in L1 or L2.
> 
> Cort Dougan had a paper about memory management in Linux on the PowerPC
> online at NMT, but at this time the link is broken
> (http://www.cs.nmt.edu/~cort/papers/linuxppc-mm/). If I remeber right,
> he also spoke about zeroing pegaes in the idle task.

Since I deleted it only this afternoon when cleaning up my homedir, I was able
to restore it from backup (DLT-jukeboxes are nice :-)

    http://www.cs.kuleuven.ac.be/~geert/bin/linuxppc-mm.ps.gz

Will be autoremoved on September 4.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
