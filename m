Message-ID: <389EE09A.571A6C26@denise.shiny.it>
Date: Mon, 07 Feb 2000 16:11:22 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Adrian Cox <apc@agelectronics.co.uk>
CC: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>,
        Debian PowerPC <debian-powerpc@lists.debian.org>
Subject: Re: Altivec and binary compatibility
References: <389AAA06.CBCDB19A@agelectronics.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> Altivec raises an interesting question of binary compatibility, in the
> area of C++ exceptions and C setjmp/longjmp.
>
> As the jmp_buf is a different size in Altivec and non-Altivec code

Because with Altivec we need to save V registers, right ?  Well, I suppose
intel developers had the same problem with P-III "vector" unit. How did they
solve the problem ?

> it is not possible to jump or pass exceptions between the two.
> This is a problem, because:
> 1) Now would not be a good time to change the size of a jmp_buf.
> 2) We do not need two incompatible 32-bit PowerPC ABIs under Linux.
> 2a) Most libraries installed by a distribution will be non-Altivec code,
> to avoid having both G[123] and G4 binary variants of the distribution.

I agree.

> To add to the problem, throwing exceptions on an error is just what a
> modern C++ library is supposed to do.  Throwing or catching an exception
> in Altivec code will produce sequences that cannot execute on a G3

Why ?? (sorry for my ignorance...)

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
