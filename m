Message-ID: <398CDA96.C3CBE4C@denise.shiny.it>
Date: Sat, 05 Aug 2000 23:25:10 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: progress on l2cr
References: <39861753.8DB68BB6@denise.shiny.it> <20000731184228.18405@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> >Is there any reason to keep the L2 cache data-only ?
> >>
> >> There are some rare cases where it can be useful, yes. Like when flushing
> >> it, to avoid the flush code to pollute it.
> >
> >A few bytes inside a 1MB cache are't a problem IMHO. Anyway I enabled it and
> >performance compiling programs is 15% lower.
>
> You have no reason to enable "data only" in normal use. It's used during
> the flush cycle of the cache to avoid polluting it while the flush code
> runs, but it's set and unset automatically, so you don't need to care.

Ok, but /proc/.../l2cr tells it's data-only at boot.

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
