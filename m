Message-ID: <39A30138.36D33D93@student.ethz.ch>
Date: Wed, 23 Aug 2000 00:39:52 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
References: <200008222110.XAA00741@piglet.grunz.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> > I don't think having to use ShadowFB with the fbdev driver is too bad
> > because it should generally enhance performance :)
>
> I guess control is the exception. I found out it isn't worth the memory
> impact. I once ran a complete x11perf run comparing with and without
> shadowfb, and with shadowfb was overall slower. Some operations were
> faster, though, but not in general.

Oh no. This is very bad.


> I suppose this is because main memory isn't faster on my box than access
> to the VRAM. Both are accessed via a 50 MHz bus, and are of the same
> basic type (plain old DRAM, that is).

Indeed, this breaks the basic assumption behind ShadowFB, that main RAM is
very fast compared to video RAM. The situation is similar for Amigas :-/


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
