Date: Wed, 28 Nov 01 10:54:05 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111281854.AA27629@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform files question
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> There's no exact way right now.  But it breaks down like this, if you
> have a port which does _not_ need to change include/asm-ppc/serial.h,
> they can all go in arch/ppc/platforms.  If you change
> include/asm-ppc/serial.h AND newBoard_serial.h needs to include
> newBoard.h, they both go in include/asm-ppc/platforms/.

And what if I have a port that has its newBoard_serial.h, but it doesn't need
to include newBoard.h?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
