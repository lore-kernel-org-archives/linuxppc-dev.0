Message-ID: <3C162FE2.2D26113E@mvista.com>
Date: Tue, 11 Dec 2001 10:10:10 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: srinivas pulipati <srinivasp@multitech.co.in>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: how to cross complile helloworld.c
References: <3C15FD95.5F348883@multitech.co.in>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


srinivas pulipati wrote:
>
> hi,
>
> i have compiled glibc for powerpc-linux.
> when i try to compile a sample file helloworld.c
> it is saying undefined  reference to printf.
> looks like it is not taking proper library.
>
> can anyone help me?
>
> thanks
> srinivas
>

After compiling glibc, did you rebuild you compiler set?  Without doing
a recompile gcc is still going to use newlib and will have no knowledge
of the installed glibc.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
