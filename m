Message-ID: <37EC952C.9285EA6C@wanadoo.fr>
Date: Sat, 25 Sep 1999 11:26:04 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Shaw Terwilliger <sterwill@io.nu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] Paul's rsync kernel compile fix
References: <19990924222214.A7489@io.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shaw Terwilliger wrote:
> 
> I've been compiling Paul's rsync kernel on my PowerBook G3 and I've
> prepared a patch that blocks out some undeclared (and reference)
> variable initializations in linux/arch/ppc/kernel/pmac_setup.c.  A quick
> look at the other ????_setup.c (prep, chrp, apus) shows this might also
> be useful there, but I didn't run through the compiles to check.
> 
> Has everyone else had the same problem compiling these kernels?
> 
> This is the first time I've dug around in "kernel" kernel stuff,
> and I think I'm clear on why these variables really don't mean
> anything, but I could always be wrong.  :)

I think you are: 
- these variables are used by any number of drivers
- they are declared in <asm/dma.h>

Maybe you should rsync again?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
