Message-ID: <3AC24AB2.53E1E1E3@denise.shiny.it>
Date: Wed, 28 Mar 2001 22:33:54 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sound skips
References: <20010326085607.B61492EFD1@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >>  You might want to try Andrew Morton's Low-Latency patch (URL:
> >>  http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads)

Done. It doen't make a lot difference, but I can compile stuff without
sound interruptions most of the time (if it doesn't involve libtool).
I tried to lower the fragment size to 9 (512B==0.012s) and it skips
even when the system is completely idle.


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
