Message-ID: <38B00F8D.CEE8CAFF@denise.shiny.it>
Date: Sun, 20 Feb 2000 11:00:13 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Adrian Cox <apc@agelectronics.co.uk>
CC: Rob Barris <rbarris@quicksilver.com>,
        LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>,
        Debian PowerPC <debian-powerpc@lists.debian.org>
Subject: Re: Altivec and binary compatibility
References: <389AAA06.CBCDB19A@agelectronics.co.uk>
			 <389EE09A.571A6C26@denise.shiny.it>
			 <389F09C2.18FD4AA5@agelectronics.co.uk> <v03010d02b4cce4346bac@[192.168.1.16]> <38A7D0FD.D6A7E95D@agelectronics.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> >    This is not correct.  OS's on P-III have to be updated to provide proper
> > context switch support for the SSE registers.  I'm pretty sure Win98 has it
> > covered.  It's really the same type of jump as AltiVec - use of SSE
> > features is not restricted to OS or driver code, apps use them too.
>
> I know that the OS has to support these registers. Latest development
> kernels *DO* support them.
>
> That is not the problem.
>
> The problem is with C++ exception sequences and setjmp being different
> for Altivec and non-Altivec code.

IMHO C++ exceptions are not a problem. All objects are destroyed when a
function exits with an exception and it's an exit without return. The thrown
object is put on the stack (I think) and the calling code will handle it.
Obviously you can't mix code compiled for Altivec and code compiled for plain
PPC if they exchange data with exceptions, jumps and friends.

> How does Linux on ia32 handle linking between generic ia32 and Pentium-III user-space code ?

No idea... It's likely an unsolved issue yet.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
