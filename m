Message-ID: <XFMail.010329173927.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20010329085335.527C32EFCE@apollo.valhalla.net>
Date: Thu, 29 Mar 2001 17:39:27 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: Sound skips
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> OK.  So nothing much has changed since I last tried it - note that those
> patches take scheduling latency below 1ms on x86.

This means the bad code is in the "small" arch-dependdent part
of the kernel.

> maybe we do have some IRQ blocking as well (I haven't had time to benchmark
> that at 2.4.x - it's on the TODO list).
>
>>(if it doesn't involve libtool).
>
> hmmm.  Have you got any idea what libtool does that is different ?

Not yet. I'll look for it ASA I have time.

> (does strace work at the moment?)

Yes it does. The only uncommon thing I can see is a huge number of
calls to rt_sigprocmask().

> mmap-ing files is "bad news" even with the LL patches (IIRC).

I didn't know that.

>> I tried to lower the fragment size to 9 (512B==0.012s) and it skips
>> even when the system is completely idle.
>
> I don't know what UI you are using but...

I wrote a small prog to play aiffs from disk.

> does this occur each second (i.e. related to, for example, updating a clock
> on screen) ... or
>
> every 20/30 seconds or so - perhaps related to sync() ?

I don't know... It seems quite random, but I have some stuff running in
the taskbar. I'll check better.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
