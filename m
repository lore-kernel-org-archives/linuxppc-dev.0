Message-ID: <374985BC.3FAE197C@wanadoo.fr>
Date: Mon, 24 May 1999 19:00:44 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: semaphores in 2.3.3
References: <199905241630.SAA25266@dv.ba.dlr.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Oliver Neukum wrote:
> 
> Hi,
> 
> as you may have noticed linux-2.3.3  doesn't compile on powerpc due to
> changes in semaphores and waitqueues. This means that ppc is again at a
> disadvantage.
> I hope for ppc to become one of the stable ports.
> I've attached a patch that ports the basic change from i386 to ppc.
> As yet, the kernel will not compile. It needs to include semaphore.h at a
> few places. In addition i've found ide-pmac.c and adbmouse.c to be broken.
> 
> People, this can't be that hard.

AFAICT, this is not a problem of finding the right patches, but to get
them accepted by Linus.

The vger cvs tree has had a compiling 2.3.3 kernel for some time (I am
running it right now). The one I am running is from last Friday, the one
checked out today compiles, but doesn't boot.

I think if you want to use 2.3.x kernels, you have to accept that these
are development kernels, and that there are periods when they don't
work.

After all, there is the stable just one week old version 2.2.9 (although
the official 2.2.9 kernel includes this broken patch of
arch/ppc/kernel/syscalls.c that didn't come from vger).

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
