Message-ID: <38A3D93A.136B5052@agelectronics.co.uk>
Date: Fri, 11 Feb 2000 09:41:14 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>,
        Debian PowerPC <debian-powerpc@lists.debian.org>
Subject: Re: Altivec and binary compatibility
References: <389AAA06.CBCDB19A@agelectronics.co.uk> <389EE09A.571A6C26@denise.shiny.it> <389F09C2.18FD4AA5@agelectronics.co.uk> <38A07887.DB071C6C@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:

> From altivec p. e. m.: "1.2.6 - The AltiVec vector unit never generates an
> exception"
>
> I just started to read the book, but I think AltiVec tells nothing even on
> things like divisions by 0, etc.

C++ exceptions, not machine exceptions:

   if (failure()) thow Oops();

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
