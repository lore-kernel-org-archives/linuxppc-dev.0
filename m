Date: Thu, 29 Mar 2001 09:52:32 +0100
Subject: Re: Sound skips
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010329085335.527C32EFCE@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >>  You might want to try Andrew Morton's Low-Latency patch (URL:
>> >>  http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads)
>
> Done. It doen't make a lot difference, but I can compile stuff without
> sound interruptions most of the time

OK.  So nothing much has changed since I last tried it - note that those
patches take scheduling latency below 1ms on x86.

maybe we do have some IRQ blocking as well (I haven't had time to benchmark
that at 2.4.x - it's on the TODO list).

>(if it doesn't involve libtool).

hmmm.  Have you got any idea what libtool does that is different?
(does strace work at the moment?)

mmap-ing files is "bad news" even with the LL patches (IIRC).

> I tried to lower the fragment size to 9 (512B==0.012s) and it skips
> even when the system is completely idle.

I don't know what UI you are using but...

does this occur each second (i.e. related to, for example, updating a clock
on screen) ... or

every 20/30 seconds or so - perhaps related to sync() ?

---

ah well, we'll solve it eventually [otherwise PPC is dead for sound - which
would be a Great Shame (tm).]

ciao,
Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
