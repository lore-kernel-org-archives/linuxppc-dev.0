Message-ID: <3ACF7B01.D13994B2@denise.shiny.it>
Date: Sat, 07 Apr 2001 22:39:29 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sound skips
References: <20010329085335.527C32EFCE@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >(if it doesn't involve libtool).
>
> hmmm.  Have you got any idea what libtool does that is different ?
> (does strace work at the moment?)

The only unusual thing strace shows is thai it calls rt_sigprocmask()
hundred times. rt_sigprocmask() stops irqs for a very short time. A
prog that calls it 1M time shows this is not what I'm looking for.
I searched in all /arch/ppc for something interesting... nothing. I
definitely need a tool to measure how much time the various
spinlock_irq's are hold.

> mmap-ing files is "bad news" even with the LL patches (IIRC).

strace libtool shows 13 lines like this:

mmap(ptrace: umoven: input/output error
)                                  = 0x30019000

I don't know what does it mean.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
