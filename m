Message-Id: <200004172244.XAA17952@hyperion.valhalla.net>
Date: Mon, 17 Apr 2000 23:51:25 +0100
Subject: Re: /proc/ppc_htab 
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Ani Joshi <ajoshi@shell.unixbox.com>
CC: "PPC-DEV" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> A few days ago I saw `mmu_context_overflow' in my kernel messages.
>> The machine locked up on `cat /proc/ppc_htab'. Fortunately it autorebooted
>> after 180 seconds and came back to life again.
>
> I also saw this a few weeks ago, and was meaning to fix it but I was
> unable to reproduce it.

I have not seen the mmu_context_overflow - but the /proc/ppc_htab has been
causing a lock-up since at least 2.3.51 (sorry it slipped my mind).

I'm using Paul's rsync (latest I've tried is 2.3.99-pre3).

> I'm sure you don't feel like crashing a remote box again, but if you or
> anyone else could cat /proc/ppc_htab and tell if panics and perhaps post
> the OOPS.

Unfortunately there was no panic, OOPS or anything - and - unlike Geert's my
system never came back - just locked up completely - requiring a three
finger salute to get anywhere.  G3/minitower (beige).

Not as much help as I would like - apart from the fact that it was
completely repeatable - I'm out of circulation for 5 weeks now - paid work
;-) but if there's anything I can supply by tomorrow night that will throw
more light on it - let me know.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
