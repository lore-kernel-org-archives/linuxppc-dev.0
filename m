Message-ID: <38C77216.411270A2@agelectronics.co.uk>
Date: Thu, 09 Mar 2000 09:42:46 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Greg Allen <gallen@arlut.utexas.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: AltiVec on Linux
References: <v04011708b4ec4b0ae554@[129.116.196.236]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greg Allen wrote:

> It's not a "Linux" compiler -- it's strictly a cross-compiler. It creates
> the toolset "powerpc-eabisim-*". The binaries that it generates do not run
> on Linux.

Take the compiler patches, apply to the compiler source for LinuxPPC,
configure, make. This should work, though I've only done it on Debian.

> Unfortunately, powerpc-eabisim-g++ doesn't recognize "vector" at all.
> That's right, boys and girls, NO C++ SUPPORT WITH ALTIVEC!

For C++ use the keyword __vector.

This is documented in the Altivec Programming Interface Manual, which
can be found at:
http://www.altivec.org/tech_specifications/altivec_pim.pdf

It's not pretty, but it is in the manual.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
