Message-ID: <3C17548A.5AEEDC5B@multitech.co.in>
Date: Wed, 12 Dec 2001 18:28:50 +0530
From: srinivas pulipati <srinivasp@multitech.co.in>
MIME-Version: 1.0
To: Mark Hatle <fray@mvista.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: how to cross complile helloworld.c
References: <3C15FD95.5F348883@multitech.co.in> <3C162FE2.2D26113E@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi mark,

yes i built the gcc after compling glibc only.

just now i figured out the problem.

after compiling glibc..

i edited the file <path where you put glibc/lib/libc.so  and  changed

GROUP ( /lib/libc.so.6 /lib/libc_nonshared.a )
to:
GROUP ( <path where you put glibc>/lib/libc.so.6 <path where you put
glibc>/lib/libc_nonshared.a )

now powepc-linux-gcc is able to compile hello.c file without any error.

thanks
srinivas

Mark Hatle wrote:

> srinivas pulipati wrote:
> >
> > hi,
> >
> > i have compiled glibc for powerpc-linux.
> > when i try to compile a sample file helloworld.c
> > it is saying undefined  reference to printf.
> > looks like it is not taking proper library.
> >
> > can anyone help me?
> >
> > thanks
> > srinivas
> >
>
> After compiling glibc, did you rebuild you compiler set?  Without doing
> a recompile gcc is still going to use newlib and will have no knowledge
> of the installed glibc.
>
> --Mark
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
