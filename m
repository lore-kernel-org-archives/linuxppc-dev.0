Message-ID: <3692FB17.A3A22B55@jlc.net>
Date: Wed, 06 Jan 1999 00:56:40 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org, "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Strange PMAC IDE performance problem
References: <19990105234815.008275@smtp.calvacom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> I remember Cort having tons of them initially with his PowerBook and they
> disappeared, I don't know if it was after a kernel change however.

I am still running 2.1.125 on my PowerBook G3, and get tons
of bogus interrupts.  I am trying to upgrade to 2.1.130 (or the
latest vger tree).  When I run 2.1.130, I don't see the problems.
The major difference is I run the IDE DMA on 2.1.130 and not
on other kernels..........I can't point to anything else.  My other
thought was something wrong with power management.


> I never experienced the slowdown+crash on heavy i/os, even when copying
> full kernel trees locally, over NFS and both at the same time.

Mine will when running 2.1.125.....not with 2.1.130.


> ........ Also, are
> the problem similar when booting with OF and BootX or are there any
> differences ?

I boot with OF (either floppy or enet) because I don't have an
easy way to get the kernel into the MacOS system folder.  I have
hacked the atyfb to force G3 resolution and depth regardless of what
it finds automatically.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
