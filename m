Message-ID: <3DB6A403.2050705@mvista.com>
Date: Wed, 23 Oct 2002 08:28:35 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Vishwanath <vishwanath@mistralsoftware.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Monta Vista Linux Supporting Floating Point operations
References: <002501c27a66$fcc4bd40$faffa8c0@VISHWANATH>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Vishwanath wrote:
> Hi All,
>
> I am working on 440GP using Monta Vista Linux 2.1. I need floating point
> operation support (for eg. function sqrt() for calculating square root of
> given float variable) on Linux. I didn't find math emualtion on the Linux.
> Can anyone tell me how can I get floating point support ?

Floating point support in MontaVista Linux is handled by the compiler and _NOT_
the kernel.  In architecting our system we have weighed the tradeoffs between
soft-floating point, or hard-floating point using kernel exceptions.
Soft-floating point was found to be superior so we use it on all platforms
without a hardware FPU.

One thing to note, because of this the ABI is slightly different then the
binaries you would download off of a random community website.  You need to use
our compiler (or a community compiler configured appropriatly) to build
soft-float.  (On a non-MontaVista compiler, you usually need to pass
-msoft-float on the command line to gcc.)


--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
