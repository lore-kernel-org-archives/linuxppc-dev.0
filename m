Message-ID: <3E1EE645.A780CBD0@imc-berlin.de>
Date: Fri, 10 Jan 2003 16:27:01 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Definitions for c_cflag etc. in termbits.h???
References: <3E1EE23F.5BC310F3@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
>
> Hi there,
>
> I am playing around with UARTs and got completly confused when looking at
> ./include/asm-ppc/termbits.h:
>
> E.g. the DEFINEs of c_iflags appear to me as decimal values!?
>
> /* c_iflag bits */
> #define IGNBRK  0000001

Thanks to you all!

Of course it's octal.

It's friday! Sorry for the noise!

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
